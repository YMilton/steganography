
%主要思想：嵌入率在1bpp情况下的隐写，对
function [StegoIm11,StegoIm21,StegoIm22] = DEAMG_H(BL,GrayMatrix)
I = bitand(GrayMatrix,240);%高四位获取特征提取矩阵
[~,reimg] = FunSplit1(I);
positionO = find(reimg==1);%获取网格中值为1的位置 粗网格
positionZ = find(reimg==0);%获取网格中值为0的位置 细网格

NGPA = I;
vector1 = GrayMatrix(positionO);
vector0 = GrayMatrix(positionZ);

if length(BL)<=length(positionO)
    BL1 = BL;
    BL0 = [];
else
    BL1 = BL(1:length(positionO)-1);
    BL0 = BL(length(positionO):end);
end

%%AMGDE11
nvector1 = DE_H(BL1,vector1,1);
NGPA(positionO) = nvector1;
nvector2 = DE_H(BL0,vector0,1);
NGPA(positionZ) = nvector2;
StegoIm11 = NGPA;

%%AMGDE21
nvector1 = DE_H(BL1,vector1,2);
NGPA(positionO) = nvector1;
nvector2 = DE_H(BL0,vector0,1);
NGPA(positionZ) = nvector2;
StegoIm21 = NGPA;

%%AMGDE22
nvector1 = DE_H(BL1,vector1,2);
NGPA(positionO) = nvector1;
nvector2 = DE_H(BL0,vector0,2);
NGPA(positionZ) = nvector2;
StegoIm22 = NGPA;
end


