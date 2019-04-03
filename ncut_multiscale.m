function [W,C] = ncut_multiscale(image,options)
% [classes,X] = ncut_multiscale(image,10);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                  %
%   Multiscale Normalized Cuts Segmentation Code   %
%                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% inputs: 
% image: image to segment (size pxq or pxqx3)
% nsegs: number of segments requested
% outputs:
% classes: image regions (size pxq)
% X: eigenvectors (size pxqxnsegs)
% lamda: eigenvalues
% Xr: rotated eigenvectors (computed during discretisation)
% W: multiscale affinity matrix
% C: multiscale constraint matrix
% timing: timing information
% 
% source code available at http://www.seas.upenn.edu/~timothee
% Authors: Timothee Cour, Florence Benezit, Jianbo Shi
% Related publication:
% Timothee Cour, Florence Benezit, Jianbo Shi. Spectral Segmentation with
% Multiscale Graph Decomposition. IEEE International Conference on Computer
% Vision and Pattern Recognition (CVPR), 2005.

% Please cite the paper and source code if you are using it in your work.
image=im2double(image);
[p,q,r] = size(image);
if nargin<2
    options=[];
end
% compute multiscale affinity matrix W and multiscale constraint matrix C
t= cputime;
[layers,C]=compute_layers_C_multiscale(p,q);
dataW = computeParametersW(image);
W=computeMultiscaleW(image,layers,dataW,options);
% disp(['time compute W,C: ',num2str(cputime-t)]);
% compute constrained normalized cuts eigenvectors
% disp('starting multiscale ncut...');
t = cputime;
timing.total=cputime-t;




function [layers,C]=compute_layers_C_multiscale(p,q)
% compute multiscale image affinity matrix W and multiscale constraint
% matrix C from input image
% Timothee Cour, 04-Aug-2008 20:46:38 -- DO NOT DISTRIBUTE
layers = computeParametersLayers(p,q);
[C,C12]=computeMultiscaleConstraints(layers);
% compute each layers(i).location as subsamples of the finest layer
layers=computeLocationFromConstraints(C12,layers);




function dataW = computeParametersW(image)
% sets parameters for computing multiscale image affinity matrix W
% dataW.edgeVariance: edge variance for intervening contour cue
% dataW.sigmaI: intensity variance for intensity cue
% Florence Benezit, Jianbo Shi
[~,~,r]=size(image);
dataW.edgeVariance=0.08; %0.1 %0.08
% dataW.edgeVariance=0.1; %0.1 %0.08
dataW.sigmaI=0.12;%0.12
if r>1
    dataW.sigmaI = 1.4*dataW.sigmaI;
end



function W = computeMultiscaleW(image,layers,dataW,options)
% compute multiscale image affinity matrix W from input image, layer
% parameters layers, and affinity matrix parameters dataW
% Timothee Cour, 04-Aug-2008 20:46:38 -- DO NOT DISTRIBUTE
ns=length(layers);
%compute each scale of multiscale W
for i=1:ns
    optionsi=options;
    if isfield(options,'edges')
        optionsi.edges=options.edges(i);
    end        
    Ws{i}=computeScale(image,layers(i),dataW,optionsi);
end
[p,q,r]=size(image);
%hack: for stability, prevents isolated nodes
maxi=max(max(Ws{1}));
addpath('mex_neighborW');
Ws{1}=Ws{1}+0.01*maxi*mex_neighborW(p,q,4);
%aggregate each scale of W
W=Ws{1};
Ws{1}=[];
for i=2:ns
    [ni,nj]=size(W);
    [ni2,nj2]=size(Ws{i});
    W=[W,sparse(ni,nj2);sparse(ni2,nj),Ws{i}];
    Ws{i}=[];
end




function layers=computeLocationFromConstraints(C12,layers)
% compute each layers(i).location as samples from the finest layer
% each layer is a subsample of the finest layer
% Timothee Cour, 04-Aug-2008 20:46:38 -- DO NOT DISTRIBUTE

p=layers(1).p;
q=layers(1).q;
layers(1).location=1:layers(1).p*layers(1).q;
[X,Y]=ndgrid(1:layers(1).p,1:layers(1).q);

if length(layers)>1
    Ctemp=C12{1};
end
for i=2:length(layers)
    if i>2
        Ctemp=C12{i-1}*Ctemp;
    end
    xi=roundLimit(Ctemp*X(:),p);
    yi=roundLimit(Ctemp*Y(:),q);
    layers(i).location=sub2ind2([p,q],xi,yi);
end




function ind = sub2ind2(pq,x,y)
% Timothee Cour, 04-Aug-2008 20:46:38 -- DO NOT DISTRIBUTE

if nargin<3
    if isempty(x)
        ind=x;
        return;
    end
    y=x(:,2);
    x=x(:,1);
end
ind = x+pq(1)*(y-1);



function x = roundLimit(x,p)
% Timothee Cour, 04-Aug-2008 20:46:38 -- DO NOT DISTRIBUTE
x = round(x);
x = max(min(x,p),1);



%% 
function [C,C12]=computeMultiscaleConstraints(layers)
% layers: parameters for each layer
% C: multiscale constraint matrix C
% C12: each C12{i} is the interpolation matrix between 2 consecutive layers
% Timothee Cour, 04-Aug-2008 20:46:38 -- DO NOT DISTRIBUTE
C=[];
C12={};
nTot=0;
for i=1:length(layers)
    nTot=nTot+length(layers(i).indexes);
end
for i=1:length(layers)-1
    layer1=layers(i);
    layer2=layers(i+1);
    [Ci,C12i]=computeMultiscaleConstraint_1scale(layer1.p,layer1.q,layer2.p,layer2.q,layer1.indexes,layer2.indexes,nTot);
    C=[C;Ci];
    C12{i}=C12i;
end




function [C,C12]=computeMultiscaleConstraint_1scale(p1,q1,p2,q2,indexes1,indexes2,nTot)
% input: parameters for 2 consecutive layers
% output:
% C: rows of the global multiscale constraint matrix corresponding to those 2 layers; 
% indexes1 and indexes2 are used for indexing into the global multiscale
% constraint matrix
% C12: interpolation matrix between the 2 layers
% Timothee Cour, 04-Aug-2008 20:46:38 -- DO NOT DISTRIBUTE
addpath('mex_constraint_classes');
classes=mex_constraint_classes(p1,q1,p2,q2);
[C,C12]=computeConstraintFromClasses(classes,indexes1,indexes2,nTot);



function [C,C12]=computeConstraintFromClasses(classes,indexes1,indexes2,nTot)
% Timothee Cour, 04-Aug-2008 20:46:38 -- DO NOT DISTRIBUTE
classes=classes(:);
n1=length(classes);
n2=max(classes);
C=sparse(1:n1,classes,1,n1,n2);
sizes=full(sum(C,1));
sizes=1./sizes(:);

C12=sparse(classes,1:n1,sizes(classes),n2,n1);
if nargin <2
    C=[C12,-speye(n2)];    
else    
    C=sparse([classes;(1:n2)'],[indexes1;indexes2],[sizes(classes);-1*ones(n2,1)],n2,nTot);
end



%% 
function layers=computeParametersLayers(p,q)
% sets parameters for each layer in the multiscale grid
% p,q: input image size
% output: each layers(i) is a struct with fields:
% p,q: size of layer
% indexes: indexes of current layer into a global index reference for all
% layers
% weight: weight of layer in multiscale image affinity W
% scales: scale for edge detection used in intervening contour cue
% radius: connection radius of layer (in finest grid)
% mode2: method to compute affinity matrix for current layer
%
% other intermediate variables:
% ns=#layers
% dist=spacing bw grid points in 2 consecutive layers (corresponds to
% subsample factor)
% Florence Benezit, Timothee Cour, Jianbo Shi
max_image_size = max(p,q);
if (max_image_size>120) && (max_image_size<=500),
    
   ns=1;
         dist=3;
         weight=[3000];
         scales=[1];
         radius=[6];
         layers=computeLayers_aux(p,q,ns,dist,weight,scales,radius);
elseif (max_image_size >500),
    % use 4 levels,
    ns=4;
    dist=3;
    weight=[3000,4000,10000,20000];
    scales=[1,2,3,3];
    radius=[2,3,4,6];
    layers=computeLayers_aux(p,q,ns,dist,weight,scales,radius);
elseif (max_image_size <=120)

        ns=1;
         dist=3;
         weight=[3000];
         scales=[1];
         radius=[6];
         layers=computeLayers_aux(p,q,ns,dist,weight,scales,radius);

end

function layers=computeLayers_aux(p,q,ns,dist,weight,scales,radius)
pi=p;
qi=q;
nTot=0;
for i=1:ns
    layers(i).p=pi;
    layers(i).q=qi;
    layers(i).indexes=nTot+(1:pi*qi)';
    nTot=nTot+pi*qi;
    %     layers(i).dist=dist;
    layers(i).weight=weight(i);
    layers(i).scales=scales(i);
    layers(i).radius=radius(i);
    pi=ceil(pi/dist);
    qi=ceil(qi/dist);

    layers(i).mode2='mixed';
end


%%
function W=computeScale(image,layer,dataW,options)
% compute 1 scale of multiscale image affinity matrix W
% input:
% image: pxq or pxqxk (for example, RGB image)
% layer: parameters for current layer
% dataW: parameters for affinity matrix W
% Timothee Cour, 04-Aug-2008 20:46:38 -- DO NOT DISTRIBUTE

if isfield(layer,'mode2') && ~isempty(layer.mode2)
    if strcmp(layer.mode2,'hist')
        [wi,wj] = cimgnbmap_lower([layer.p,layer.q],layer.radius,1);
        W=computeW_multiscale_hist(layer,image,wi,wj);
        W = W*layer.weight;
        return;
    end
end


% for each layer in image, compute corresponding partial affinity matrix
[~,~,r]=size(image);
for j=1:r,
    optionsj=options;
    if isfield(options,'edges')
        optionsj.edges.emag=options.edges.emag(:,:,j);
        optionsj.edges.ephase=options.edges.ephase(:,:,j);
    end
    Wj = computeScaleChannel (image(:,:,j),layer,dataW,optionsj);
    if j==1
        W=Wj;
    else
        W = min(W,Wj);
    end
end




function W=computeW_multiscale_hist(layer,image,wi,wj)
nbins=200;
sigmaHist=2;

[p,q,r]=size(image);
n=p*q;
[H,map,Fp]=computeFeatureHistogram(image,nbins,2);
Fp=reshape2(Fp,n);
mex_normalizeColumns(Fp);
Fp=Fp.*repmat(1./std(Fp),n,1);
Fp=Fp*sigmaHist;

options.mode='multiscale_hist';
options.F=Fp;
options.hist=-H;
options.map=map;
options.ephase=[];
options.isPhase=0;
options.location=layer.location;
W = mex_affinity_option(wi,wj,options);





function W=computeScaleChannel(image,layer,dataW,options)
% compute 1 scale of multiscale image affinity matrix W for gray scale
% image
% input:
% image:pxq image
% layer:struct containing all layer-specific information such as :
% layer.p,layer.q,layer.radius,layer.scales,layer.weight,layer.location
% layer.mode2:'F' | 'IC' | 'mixed' |'hist'[not used in this function but in another]
% dataW:struct containing other parameters such as:
% dataW.sigmaI,dataW.edgeVariance
% Timothee Cour, 04-Aug-2008 20:46:38 -- DO NOT DISTRIBUTE

addpath('mex_cimgnbmap_lower');
[wi,wj] = mex_cimgnbmap_lower([layer.p,layer.q],layer.radius,1);

if isfield(layer,'mode2') && ~isempty(layer.mode2)
    mode2=layer.mode2;
else
    mode2='mixed';    
end

if ismember(mode2,{'F','mixed'})
    sigmaI=(std(image(:)) + 1e-10 )* dataW.sigmaI;
end
if ismember(mode2,{'IC','mixed'})
    if isfield(options,'edges')
        emag=options.edges.emag;
        ephase=options.edges.ephase;
    else
        [emag,ephase]=computeEdges_multiscale(image,layer.scales);
    end
    edgeVariance=max(emag(:)) * dataW.edgeVariance/sqrt(0.5);
end

switch mode2
    case 'F'
        W=computeW_multiscale_F(layer,image,sigmaI,wi,wj);
    case 'IC'
        W=computeW_multiscale_IC(layer,emag,edgeVariance,ephase,wi,wj);
    case 'mixed'
        W=computeW_multiscale_mixed(layer,image,sigmaI,emag,edgeVariance,ephase,wi,wj);
    otherwise
        error('?');
end
W = W*layer.weight;




function W=computeW_multiscale_F(layer,image,sigmaI,wi,wj)
options.mode='multiscale_option';
options.mode2='F';
options.F=image/sigmaI;
options.location=layer.location;
W = mex_affinity_option(wi,wj,options);


function W=computeW_multiscale_IC(layer,emag,edgeVariance,ephase,wi,wj)
options.mode='multiscale_option';
options.mode2='IC';
options.emag=emag/edgeVariance;
options.ephase=ephase;
options.isPhase=1;
options.location=layer.location;
W = mex_affinity_option(wi,wj,options);


function W=computeW_multiscale_mixed(layer,image,sigmaI,emag,edgeVariance,ephase,wi,wj)
options.mode='multiscale_option';
options.mode2='mixed';
options.F=image/sigmaI;
options.emag=emag/edgeVariance;
options.ephase=ephase;
options.isPhase=1;
options.location=layer.location;
addpath('mex_affinity_option');
W = mex_affinity_option(wi,wj,options);




%% 
function [emag,ephase]=computeEdges_multiscale(image,scale)
%TODO:rename to multichannel
% Timothee Cour, 04-Aug-2008 20:46:38 -- DO NOT DISTRIBUTE
[p,q,r]=size(image);
emag=zeros(p,q,r);
ephase=zeros(p,q,r);
for i=1:r
    [emag(:,:,i),ephase(:,:,i)]=computeEdges_multiscale_aux(image(:,:,i),scale);
end


function [emag,ephase]=computeEdges_multiscale_aux(image,scale)
[ephase,emag]=computeEdgeFast(image,scale);


function [ephase,emag]=computeEdgeFast(I,sigma)
%TODO:optimize
% Timothee Cour, 04-Aug-2008 20:46:38 -- DO NOT DISTRIBUTE

if nargin<2
    sigma=2;
end
[IGx,IGy,IGxx,IGyy]=compute_gradients(I,sigma);

ephase=IGxx+IGyy;
ephase=(ephase>0)-(ephase<0);

if nargout>=2
     emag=sqrt(IGx.^2+IGy.^2);
end




function [IGx,IGy,IGxx,IGyy]=compute_gradients(I,sigma)
[p,q,r]=size(I);
assert(r==1);
if nargin>=2
    I=computeSmoothedI(I,sigma);
end

IGx = [diff(I,1,1);zeros(1,q)];
IGy = [diff(I,1,2),zeros(p,1)];

if nargout>=3
    IGxx = [diff(IGx,1,1);zeros(1,q)];
    IGyy = [diff(IGy,1,2),zeros(p,1)];
end




function IG=computeSmoothedI(I,sigma)
% Timothee Cour, 04-Aug-2008 20:46:38 -- DO NOT DISTRIBUTE

GaussianDieOff = .0001;
pw = 1:30; % possible widths
ssq = sigma*sigma;
% width = max(find(exp(-(pw.*pw)/(2*sigma*sigma))>GaussianDieOff));
width = find(exp(-(pw.*pw)/(2*sigma*sigma))>GaussianDieOff, 1, 'last' );
if isempty(width)
    width = 1;  % the user entered a really small sigma
end

t = (-width:width);
gau = exp(-(t.*t)/(2*ssq))/(2*pi*ssq);     % the gaussian 1D filter

IG=imfilter(I,gau,'conv','replicate');   % run the filter accross rows
IG=imfilter(IG,gau','conv','replicate'); % and then accross columns


