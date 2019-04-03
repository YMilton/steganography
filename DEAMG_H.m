
%��Ҫ˼�룺Ƕ������1bpp����µ���д����
function [StegoIm11,StegoIm21,StegoIm22] = DEAMG_H(BL,GrayMatrix)
I = bitand(GrayMatrix,240);%����λ��ȡ������ȡ����
[~,reimg] = FunSplit1(I);
positionO = find(reimg==1);%��ȡ������ֵΪ1��λ�� ������
positionZ = find(reimg==0);%��ȡ������ֵΪ0��λ�� ϸ����

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


