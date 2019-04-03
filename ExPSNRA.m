%AMGDE隐写算法的PSNR值与效果图对比
clc,clear;
close all;
tic
P = imread('Image\barbara.bmp');
GP = rgb2gray(P);
[row,col] = size(GP);
[split,cellimg] = FunSplit(GP);
reimg = cellimg{1};

%%网格化嵌入部分
positionO = find(reimg==1);%查找为1的位置
positionZ = find(reimg==0);%%获取网格中值为0的位置
BL = randi([0,1],[1,row*col-2]);

NGPA21 = GP;
%%代数多重网格网格化嵌入部分
vector1 = GP(positionO);
vector2 = GP(positionZ);
% BL1 = BL(length(vector2):end);
% BL2 = BL(1:length(vector2)-1);
BL1 = BL(1:length(vector1)-1);
BL2 = BL(length(vector1):end);
%%获得网格化的图像嵌入数据的图片
nvector1 = DE(BL1,vector1,2);
NGPA21(positionO) = nvector1;
nvector2 = DE(BL2,vector2,1);
NGPA21(positionZ) = nvector2;

NGPA12 = GP;
%%代数多重网格网格化嵌入部分
vector1 = GP(positionO);
vector2 = GP(positionZ);
% BL1 = BL(length(vector2):end);
% BL2 = BL(1:length(vector2)-1);
BL1 = BL(1:length(vector1)-1);
BL2 = BL(length(vector1):end);
%%获得网格化的图像嵌入数据的图片
nvector1 = DE(BL1,vector1,1);
NGPA12(positionO) = nvector1;
nvector2 = DE(BL2,vector2,2);
NGPA12(positionZ) = nvector2;

NGPA11 = GP;
%%代数多重网格网格化嵌入部分
vector1 = GP(positionO);
vector2 = GP(positionZ);
BL1 = BL(1:length(vector1)-1);
BL2 = BL(length(vector1):end);
% BL1 = BL(length(vector2):end);
% BL2 = BL(1:length(vector2)-1);
%%获得网格化的图像嵌入数据的图片
nvector1 = DE(BL1,vector1,1);
NGPA11(positionO) = nvector1;
nvector2 = DE(BL2,vector2,1);
NGPA11(positionZ) = nvector2;

NGPA22 = GP;
%%代数多重网格网格化嵌入部分
vector1 = GP(positionO);
vector2 = GP(positionZ);
BL1 = BL(1:length(vector1)-1);
BL2 = BL(length(vector1):end);
% BL1 = BL(length(vector2):end);
% BL2 = BL(1:length(vector2)-1);
%%获得网格化的图像嵌入数据的图片
nvector1 = DE(BL1,vector1,2);
NGPA22(positionO) = nvector1;
nvector2 = DE(BL2,vector2,2);
NGPA22(positionZ) = nvector2;


%非网格化嵌入
% [NGPM,R] = Embed_Core_Matrix(BL,GP);
NGPD1 = DE(BL,GP,1);%k=1
NGPD2 = DE(BL,GP,2);%k=2

% subplot(2,3,1)
% figure
subplot(221)
imshow(GP);
title('Cover image')

% subplot(2,4,2)
% imshow(NGPM);
% psnr = PSNR(GP,NGPM);
% title(strcat('MarkovLSBM,PSNR=',num2str(psnr)))

% subplot(2,3,2)
% figure
% imshow(NGPD1);
% psnr = PSNR(GP,NGPD1);
% title(strcat('DE,k=1,PSNR=',num2str(psnr)))

% subplot(2,3,3)
% figure
% imshow(NGPD2);
% psnr = PSNR(GP,NGPD2);
% title(strcat('DE,k=2,PSNR=',num2str(psnr)))

% subplot(2,3,4)
% figure
subplot(222)
imshow(NGPA11);
psnr = PSNR(GP,NGPA11);
title(strcat('AMGDE11,PSNR=',num2str(psnr)))

% subplot(2,3,5)
% figure
subplot(224)
imshow(NGPA22);
psnr = PSNR(GP,NGPA22);
title(strcat('AMGDE22,PSNR=',num2str(psnr)))

% subplot(2,3,6)
% figure
subplot(223)
imshow(NGPA21);
psnr = PSNR(GP,NGPA21);
title(strcat('AMGDE21,PSNR=',num2str(psnr)))

% subplot(2,4,8)
% imshow(NGPA12);
% psnr = PSNR(GP,NGPA12);
% title(strcat('AMGDE12,PSNR=',num2str(psnr)))

% suptitle(strcat('嵌入二进制长度=',num2str(length(BL))))
toc
