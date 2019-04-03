clear,clc;
close all

P = imread('Image/lenna.bmp');
R = rgb2gray(P);
[split,reimg] = FunSplit1(R);
figure,imshow(R);
figure,imshow(reimg);
% figure,imshow(reimg{2});
% figure,imshow(reimg{3});
% figure,imshow(reimg{4});
% figure,imshow(reimg{5});

