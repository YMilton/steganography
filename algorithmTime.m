clear,clc


tic
method = 'DEAMG';
im = imread('Image/lenna.bmp');
I = rgb2gray(im);
[row,col] = size(I);
BL = randi([0,1],[1,floor(row*col)]);
p = str2func(method);
[Stego1,Stego2,Stego3] = p(I);
toc