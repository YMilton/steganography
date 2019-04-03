clear,clc
close all

I = rgb2gray(imread('Image/sailboat.bmp'));
[ths,pixlens,bw] = getThreshold(I,30000);
format long g
[ths pixlens]

[rows,cols] = size(I);
pixlens(end)/(rows*cols)

figure
imshow(bw)