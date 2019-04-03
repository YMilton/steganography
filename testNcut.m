clear,clc

im = imread('Image/lenna.bmp');
I = rgb2gray(im);
NcutMatrix = ncut_multiscaleC(I);