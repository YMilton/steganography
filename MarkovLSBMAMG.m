%%Ƕ���㷨�ĺ��Ĳ���
%BinaryListָ�������ļ���Position��ָ��Ƕ������ص�λ��������GrayMatrixָ�Ҷ�ͼ�����
%EMPictureMatrixǶ��������ļ����ͼƬ��ά����
function [EMPictureMatrix,R] = MarkovLSBMAMG(BinaryList,Position,GrayMatrix)
B = BinaryList;
M = getMC(GrayMatrix);%�������Ļ�ȡ
R = zeros(256,256);%��¼���������
P = GrayMatrix+1;%���Լ�¼����
PO = GrayMatrix;
NP = PO;
if length(B)>length(Position)
    disp('error:');
    disp('The length of binary list is larger than picture matrix!');
else
for k = 1:length(B)
    t = Position(k);%��Ƕ�����ص��λ��
    %%��¼����߽�����
    if P(t)<=254&&P(t+1)<=255
        m = R(P(t+1)+1,P(t));
        n = R(P(t+1)+1,P(t)+2);
    elseif P(t)>254&&P(t+1)<=255
        m = R(P(t+1)+1,P(t));
        n = 0;
    elseif P(t)<=254&&P(t+1)>255
        m = 0;
        n = 0;
    end
    
    if m>n
       NP(t) = Embedder1(PO(t),B(k));
    elseif m<n
        NP(t) = Embedder2(PO(t),B(k));
    else
        NP(t) = Embedder3(PO(t),B(k));
    end
    
    if(NP(t)-PO(t)==1&&t>1)       
        M(P(t+1)+1,P(t)+1) = M(P(t+1)+1,P(t)+1) - 1;
        M(P(t)+1,P(t-1)+1) = M(P(t)+1,P(t-1)+1) - 1;
        M(P(t+1)+1,P(t)+2) = M(P(t+1)+1,P(t)+2) + 1;
        M(P(t)+2,P(t-1)+1) = M(P(t)+2,P(t-1)+1) + 1;
        
        R(P(t+1)+1,P(t)+1) = R(P(t+1)+1,P(t)+1) - 1;
        R(P(t)+1,P(t-1)+1) = R(P(t)+1,P(t-1)+1) - 1;
        R(P(t+1)+1,P(t)+2) = R(P(t+1)+1,P(t)+2) + 1;
        R(P(t)+2,P(t-1)+1) = R(P(t)+2,P(t-1)+1) + 1;        
    end
    
    if(NP(t)-PO(t)==-1&&t>1)       
        M(P(t+1)+1,P(t)+1) = M(P(t+1)+1,P(t)+1) - 1;
        M(P(t)+1,P(t-1)+1) = M(P(t)+1,P(t-1)+1) - 1;        
        M(P(t+1)+1,P(t)) = M(P(t+1)+1,P(t)) + 1;
        M(P(t),P(t-1)+1) = M(P(t),P(t-1)+1) + 1;
        
        R(P(t+1)+1,P(t)+1) = R(P(t+1)+1,P(t)+1) - 1;
        R(P(t)+1,P(t-1)+1) = R(P(t)+1,P(t-1)+1) - 1;        
        R(P(t+1)+1,P(t)) = R(P(t+1)+1,P(t)) + 1;
        R(P(t),P(t-1)+1) = R(P(t),P(t-1)+1) + 1;       
    end   
end
EMPictureMatrix = NP;
end
end

%%�������Ĺ���
function MC_Matrix = getMC(GrayMatrix)
P = GrayMatrix+1;%matlab��λ�ļ�λ�Ǵ�1��ʼ���Է��Ǳ����0�����
MC_Matrix = zeros(256,256);%%1-MC�������
for k=1:length(GrayMatrix)-1
    MC_Matrix(P(k),P(k+1)) = MC_Matrix(P(k),P(k+1)) + 1 ;
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