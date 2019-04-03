%%嵌入算法的核心部分
%BinaryList指二进制文件，Position是指待嵌入的像素点位置向量，GrayMatrix指灰度图像矩阵
%EMPictureMatrix嵌入二进制文件后的图片二维矩阵
function [EMPictureMatrix,R] = MarkovLSBMAMG(BinaryList,Position,GrayMatrix)
B = BinaryList;
M = getMC(GrayMatrix);%经验矩阵的获取
R = zeros(256,256);%记录矩阵的生成
P = GrayMatrix+1;%用以记录矩阵
PO = GrayMatrix;
NP = PO;
if length(B)>length(Position)
    disp('error:');
    disp('The length of binary list is larger than picture matrix!');
else
for k = 1:length(B)
    t = Position(k);%待嵌入像素点的位置
    %%记录矩阵边界设置
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

%%经验矩阵的构建
function MC_Matrix = getMC(GrayMatrix)
P = GrayMatrix+1;%matlab中位的记位是从1开始，以防角标出现0的情况
MC_Matrix = zeros(256,256);%%1-MC经验矩阵
for k=1:length(GrayMatrix)-1
    MC_Matrix(P(k),P(k+1)) = MC_Matrix(P(k),P(k+1)) + 1 ;
end
end

%%3个嵌入器
function result = Embedder1(im,bin)
%%关键的一步，是开始就赋值
result = im;%%开始就赋值以保证parity(im)==bin时，不用改变
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