%AMGDE的隐写算法代码
function [StegoIm11,StegoIm21,StegoIm22] = DEAMG(GrayMatrix)
[~,reimg] = FunSplit(GrayMatrix);
positionO = find(reimg==1);%获取网格中值为1的位置 粗网格
positionZ = find(reimg==0);%获取网格中值为0的位置 细网格
[row,col] = size(GrayMatrix);
BL = randi([0,1],[1,row*col-2]);

NGPA = GrayMatrix;
vector1 = GrayMatrix(positionO);
vector2 = GrayMatrix(positionZ);

%%获得网格化的图像嵌入数据的图片
BL1 = BL(1:length(positionO)-1);
nvector1 = DE(BL1,vector1,1);
NGPA(positionO) = nvector1;
%%获得网格化的图像嵌入数据的图片
BL2 = BL(length(positionO):end);
nvector2 = DE(BL2,vector2,1);
NGPA(positionZ) = nvector2;
StegoIm11 = NGPA;

%%获得网格化的图像嵌入数据的图片
BL1 = BL(1:length(positionO)-1);
nvector1 = DE(BL1,vector1,2);
NGPA(positionO) = nvector1;
%%获得网格化的图像嵌入数据的图片
BL2 = BL(length(positionO):end);
nvector2 = DE(BL2,vector2,1);
NGPA(positionZ) = nvector2;
StegoIm21 = NGPA;

%%获得网格化的图像嵌入数据的图片
BL1 = BL(1:length(positionO)-1);
nvector1 = DE(BL1,vector1,2);
NGPA(positionO) = nvector1;
%%获得网格化的图像嵌入数据的图片
BL2 = BL(length(positionO):end);
nvector2 = DE(BL2,vector2,2);
NGPA(positionZ) = nvector2;
StegoIm22 = NGPA;
end


