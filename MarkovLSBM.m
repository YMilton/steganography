%%Ƕ���㷨�ĺ��Ĳ���
%BinaryListָ�������ļ���PictureMatrixָͼƬ��ʽ�ṹ
%EMPictureMatrixǶ��������ļ����ͼƬ��ʽ�ṹ
function [EMPictureMatrix,R] = MarkovLSBM(BinaryList,PictureMatrix)
B = BinaryList;
M = getMC(PictureMatrix);%�������Ļ�ȡ
R = zeros(256,256);%��¼���������
P = PictureMatrix+1;%���Լ�¼����
PO = PictureMatrix;
NP = PO;
[col,row] = size(PictureMatrix);
if length(B)>col*row
    disp('error:');
    disp('The length of binary list is larger than picture matrix!');
else
for k = 1:length(B)
    %%��¼����߽�����
    if P(k)<=254&&P(k+1)<=255
        m = R(P(k+1)+1,P(k));
        n = R(P(k+1)+1,P(k)+2);
    elseif P(k)>254&&P(k+1)<=255
        m = R(P(k+1)+1,P(k));
        n = 0;
    elseif P(k)<=254&&P(k+1)>255
        m = 0;
        n = 0;
    end
    
    if m>n
        NP(k) = Embedder1(PO(k),B(k));
    elseif m<n
        NP(k) = Embedder2(PO(k),B(k));
    else
        NP(k) = Embedder3(PO(k),B(k));
    end
    
    if(NP(k)-PO(k)==1&&k>1)       
%         M(P(k-1),P(k)) = M(P(k-1),P(k)) - 1;
%         M(P(k),P(k+1)) = M(P(k),P(k+1)) - 1;         
%         M(P(k)+1,P(k+1)) = M(P(k)+1,P(k+1)) + 1;        
%         M(P(k-1),P(k)+1) = M(P(k-1),P(k)+1) + 1;

%         R(P(k-1),P(k)) = R(P(k-1),P(k)) - 1;
%         R(P(k),P(k+1)) = R(P(k),P(k+1)) - 1;      
%         R(P(k)+1,P(k+1)) = R(P(k)+1,P(k+1)) + 1;        
%         R(P(k-1),P(k)+1) = R(P(k-1),P(k)+1) + 1;
        
        M(P(k+1)+1,P(k)+1) = M(P(k+1)+1,P(k)+1) - 1;
        M(P(k)+1,P(k-1)+1) = M(P(k)+1,P(k-1)+1) - 1;
        M(P(k+1)+1,P(k)+2) = M(P(k+1)+1,P(k)+2) + 1;
        M(P(k)+2,P(k-1)+1) = M(P(k)+2,P(k-1)+1) + 1;
        
        R(P(k+1)+1,P(k)+1) = R(P(k+1)+1,P(k)+1) - 1;
        R(P(k)+1,P(k-1)+1) = R(P(k)+1,P(k-1)+1) - 1;
        R(P(k+1)+1,P(k)+2) = R(P(k+1)+1,P(k)+2) + 1;
        R(P(k)+2,P(k-1)+1) = R(P(k)+2,P(k-1)+1) + 1;        
    end
    
    if(NP(k)-PO(k)==-1&&k>1)        
%         M(P(k),P(k+1)) = M(P(k),P(k+1)) - 1;
%         M(P(k-1),P(k)) = M(P(k-1),P(k)) - 1;       
%         M(P(k)-1,P(k+1)) = M(P(k)-1,P(k+1)) + 1; 
%         M(P(k-1),P(k)-1) = M(P(k-1),P(k)-1) + 1;
%         
%         R(P(k),P(k+1)) = R(P(k),P(k+1)) - 1;
%         R(P(k-1),P(k)) = R(P(k-1),P(k)) - 1;
%         R(P(k)-1,P(k+1)) = R(P(k)-1,P(k+1)) + 1; 
%         R(P(k-1),P(k)-1) = R(P(k-1),P(k)-1) + 1;
        
        M(P(k+1)+1,P(k)+1) = M(P(k+1)+1,P(k)+1) - 1;
        M(P(k)+1,P(k-1)+1) = M(P(k)+1,P(k-1)+1) - 1;        
        M(P(k+1)+1,P(k)) = M(P(k+1)+1,P(k)) + 1;
        M(P(k),P(k-1)+1) = M(P(k),P(k-1)+1) + 1;
        
        R(P(k+1)+1,P(k)+1) = R(P(k+1)+1,P(k)+1) - 1;
        R(P(k)+1,P(k-1)+1) = R(P(k)+1,P(k-1)+1) - 1;        
        R(P(k+1)+1,P(k)) = R(P(k+1)+1,P(k)) + 1;
        R(P(k),P(k-1)+1) = R(P(k),P(k-1)+1) + 1;       
    end   
end
EMPictureMatrix = NP;
end
end

%%�������Ĺ���
function MC_Matrix = getMC(PictureList)
P = PictureList+1;%matlab��λ�ļ�λ�Ǵ�1��ʼ���Է��Ǳ����0�����
MC_Matrix = zeros(256,256);%%1-MC�������
for k=1:length(PictureList)-1
    MC_Matrix(P(k+1),P(k)) = MC_Matrix(P(k+1),P(k)) + 1 ;
end
end

%%3��Ƕ����
function result = Embedder1(im,bin)
%%�ؼ���һ�����ǿ�ʼ�͸�ֵ
result = im;%%��ʼ�͸�ֵ�Ա�֤parity(im)==binʱ�����øı�
if(mod(im,2)~=bin)
    if(im>=0&&im<255)
        result = im + 1;
    end
    if(im==255)
        result = im - 1;
    end   
end
end

function result = Embedder2(im,bin)
result = im;
if(mod(im,2)~=bin)
    if(im>0&&im<=255)
        result = im - 1;
    end
    if(im==0)
        result = im + 1;
    end
end
end

function result = Embedder3(im,bin)
result = im;
if(mod(im,2)~=bin)
    if(im==255)
        result = im - 1;
    end
    if(im==0)
        result = im + 1;
    end
    if(im>0&&im<255)
        if(randi([0,1],1)==1)
            result = im - 1;
        else
            result = im + 1;
        end
    end
end
end