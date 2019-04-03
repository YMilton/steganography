clc,clear;
tic
P = imread('Image\tiffany.bmp');
GP = rgb2gray(P);
[split,reimg] = FunSplit(GP);

%%����Ƕ�벿��
positionO = find(reimg==1);%����Ϊ1��λ��
NumO = length(positionO)-1;
BL = randi([0,1],[1,int64(NumO)]);
vector = GP(positionO);
%%������񻯵�ͼ��Ƕ�����ݵ�ͼƬ
nvector = OPAP(BL,vector);
NGPO = GP;
NGPO(positionO) = nvector;

positionZ = find(reimg==0);%%��ȡ������ֵΪ0��λ��
vector = GP(positionZ);
%%������񻯵�ͼ��Ƕ�����ݵ�ͼƬ
nvector = OPAP(BL,vector);
NGPZ = GP;
NGPZ(positionZ) = nvector;

%%������Ƕ��
NGP = Embed_Core_Matrix(BL,GP);

subplot(2,2,1)
imshow(GP);
title('ԭʼ�Ҷ�ͼ��')
subplot(2,2,2)
imshow(NGP);
psnr = PSNR(GP,NGP);
title(strcat('˳��Ƕ�������ͼ��,PSNR=',num2str(psnr)))
subplot(2,2,3)
imshow(NGPO);
psnr = PSNR(GP,NGPO);
title(strcat('Ƕ���ѡȡΪ1������ͼ��(splitting=1),PSNR=',num2str(psnr)))
subplot(2,2,4)
imshow(NGPZ);
psnr = PSNR(GP,NGPZ);
title(strcat('Ƕ���ѡȡΪ0������ͼ��(splitting=0),PSNR=',num2str(psnr)))
suptitle(strcat('Ƕ������Ƴ���=',num2str(length(BL))))
toc
