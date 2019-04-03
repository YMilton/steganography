clear,clc
close all

%获取高4位信息的粗细网格像素点,并DE嵌入
P = imread('Image/BoatsColor.bmp');
R = rgb2gray(P);
[row,col] = size(R);
BL = randi([0,1],[1,floor(row*col*1)-2]);
[StegoIm11,StegoIm21,StegoIm22] = DEAMG_H(BL,R);

% figure
subplot(2,2,1)
% figure,
imshow(R);
title('原图');
subplot(2,2,2)
% figure,
imshow(StegoIm11);
title(strcat('GAMGDE11,PSNR=',num2str(PSNR(R,StegoIm11))));
subplot(2,2,3)
% figure,
imshow(StegoIm21);
title(strcat('GAMGDE21,PSNR=',num2str(PSNR(R,StegoIm21))));
subplot(2,2,4)
% figure,
imshow(StegoIm22);
title(strcat('GAMGDE22,PSNR=',num2str(PSNR(R,StegoIm22))));