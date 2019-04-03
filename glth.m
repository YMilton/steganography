clear,clc
close all

tic
I = rgb2gray(imread('Image/baboon.bmp'));
[ths,pixlens,bw] = getLastThreshold(bitand(I,248),'Canny');
[ths1,pixlens1,bw1] = getLastThreshold(I,'Canny');
toc
% format long g
% [ths(end) pixlens(end)]%ths是迭代的阈值，pixelens是迭代的像素值长度
[rows,cols] = size(I);
% pixlens(end)/(rows*cols)
% 
% [ths1(end) pixlens1(end)]
% pixlens1(end)/(rows*cols)

subplot(131)
imshow(I)
title('原图')
subplot(132)
imshow(bw1)
title(strcat('原图最优阈值，Th=',num2str(ths1(end)),',Pm=',num2str(pixlens1(end)),',R=',num2str(pixlens1(end)/(rows*cols))))
subplot(133)
imshow(bw)
title(strcat('像素高5位信息最优阈值，Th=',num2str(ths(end)),',Pm=',num2str(pixlens(end)),',R=',num2str(pixlens(end)/(rows*cols))))