%AMGDE����д�㷨����
function [StegoIm11,StegoIm21,StegoIm22] = DEAMG(GrayMatrix)
[~,reimg] = FunSplit(GrayMatrix);
positionO = find(reimg==1);%��ȡ������ֵΪ1��λ�� ������
positionZ = find(reimg==0);%��ȡ������ֵΪ0��λ�� ϸ����
[row,col] = size(GrayMatrix);
BL = randi([0,1],[1,row*col-2]);

NGPA = GrayMatrix;
vector1 = GrayMatrix(positionO);
vector2 = GrayMatrix(positionZ);

%%������񻯵�ͼ��Ƕ�����ݵ�ͼƬ
BL1 = BL(1:length(positionO)-1);
nvector1 = DE(BL1,vector1,1);
NGPA(positionO) = nvector1;
%%������񻯵�ͼ��Ƕ�����ݵ�ͼƬ
BL2 = BL(length(positionO):end);
nvector2 = DE(BL2,vector2,1);
NGPA(positionZ) = nvector2;
StegoIm11 = NGPA;

%%������񻯵�ͼ��Ƕ�����ݵ�ͼƬ
BL1 = BL(1:length(positionO)-1);
nvector1 = DE(BL1,vector1,2);
NGPA(positionO) = nvector1;
%%������񻯵�ͼ��Ƕ�����ݵ�ͼƬ
BL2 = BL(length(positionO):end);
nvector2 = DE(BL2,vector2,1);
NGPA(positionZ) = nvector2;
StegoIm21 = NGPA;

%%������񻯵�ͼ��Ƕ�����ݵ�ͼƬ
BL1 = BL(1:length(positionO)-1);
nvector1 = DE(BL1,vector1,2);
NGPA(positionO) = nvector1;
%%������񻯵�ͼ��Ƕ�����ݵ�ͼƬ
BL2 = BL(length(positionO):end);
nvector2 = DE(BL2,vector2,2);
NGPA(positionZ) = nvector2;
StegoIm22 = NGPA;
end


