clear,clc;

P = imread('Image\lenna.bmp');
GP = rgb2gray(P);
[row,col] = size(GP);
[~,reimg] = FunSplit(GP);

%%����Ƕ�벿��
positionO = find(reimg==1);%����Ϊ1��λ��
positionZ = find(reimg==0);%%��ȡ������ֵΪ0��λ��
BL = randi([0,1],[1,row*col-1]);

NGPA = GP;
%%����������������Ƕ�벿��
vector1 = GP(positionO);
vector2 = GP(positionZ);
BL1 = BL(1:length(vector1));
BL2 = BL(length(vector1)+1:end);
%%������񻯵�ͼ��Ƕ�����ݵ�ͼƬ
nvector1 = DE(BL1,vector1,2);
NGPA(positionO) = nvector1;

nvector2 = DE(BL2,vector2,1);
NGPA(positionZ) = nvector2;

%������Ƕ��
[NGPM,R] = Embed_Core_Matrix(BL,GP);
NGPD = DE(BL,GP,1);

subplot(3,1,1)
imshow(NGPM);
mcd = MCDistance(GP,NGPM);
title(strcat('˳��MarkovǶ��,MCDistance=',num2str(mcd)))
subplot(3,1,2)
imshow(NGPD);
mcd = MCDistance(GP,NGPD);
title(strcat('ԭʼDE,MCDistance=',num2str(mcd)))
subplot(3,1,3)
imshow(NGPA);
mcd = MCDistance(GP,NGPA);
title(strcat('DE(splitting=1),MCDistance=',num2str(mcd)))
suptitle(strcat('Ƕ������Ƴ���=',num2str(length(BL))))

