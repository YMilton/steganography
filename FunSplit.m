function [split,reimg] = FunSplit(GrayMatrix)

[p,q] = size(GrayMatrix);
% PSF = fspecial('gaussian',5,5);%����һ���˲���
% tempIma = imfilter(GrayMatrix,PSF,'conv');%ͼ���ģ������
% image = rescaleImage(tempIma);
% NcutMatrix = ncut_multiscale(image);
NcutMatrix = ncut_multiscale(GrayMatrix);
%%pyamgִ��ģ��
save Mat\NcutData.mat NcutMatrix
% disp('Starting the method ruge_stuben_solver of pyamg!');
!python ruge_stuben_solver.py
% disp('Finish the method of the pyamg!');
%%pyamgģ��ִ����ϣ��õ�Mat����
load('Mat/RSSMat.mat');
split{1} = double(level1);%%��һ��ָ�
split{2} = double(level2);%%�ڶ���ָ�
split{3} = double(level3);%%������ָ�
split{4} = double(level4);%%���Ĳ�ָ�
split{5} = double(level5);%%�����ָ�

index1 = find(split{1});
index2 = find(split{2});
index3 = find(split{3});
index4 = find(split{4});
index5 = find(split{5});

%%��ȡ�ָ�����ͼƬ��С���ȵ�����
imgBin = zeros(size(split{1}));
imgBin(index1)=1;
reimg{1} = reshape(imgBin(1:p*q),p,q);%%��һ��ָ�

imgBin = zeros(size(split{1}));
imgBin(index1(index2))=1;
reimg{2} = reshape(imgBin(1:p*q),p,q);%%�ڶ���ָ�

imgBin = zeros(size(split{1}));
imgBin(index1(index2(index3)))=1;
reimg{3} = reshape(imgBin(1:p*q),p,q);%%������ָ�

imgBin = zeros(size(split{1}));
imgBin(index1(index2(index3(index4))))=1;
reimg{4} = reshape(imgBin(1:p*q),p,q);%%���Ĳ�ָ�

imgBin = zeros(size(split{1}));
imgBin(index1(index2(index3(index4(index5)))))=1;
reimg{5} = reshape(imgBin(1:p*q),p,q);%%�����ָ�

% reimg = imreize(split(1:p*q),p,q);

end

