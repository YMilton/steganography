clear,clc
close all


im = imread('Image/pepper.bmp');
I = rgb2gray(im);
figure
imshow(I)