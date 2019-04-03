clear,clc
close all

image = imread('Image/lenna.bmp');
I = rgb2gray(image);
[rows,cols] = size(I);
BL=randi([0,1],[1,rows*cols]);
EI = DE(BL,I,2);
orignal_MC = MCDistance(I,EI)
orignal_PSNR = PSNR(I,EI)

disp('Edge......')
I_edge = edge(I,'canny');
TPE = TwoPartEmbed(I,BL,I_edge);
edge_MC = MCDistance(I,TPE)
edge_PSNR = PSNR(I,TPE)
