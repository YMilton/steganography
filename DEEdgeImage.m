clear,clc
close all
tic
rgb = imread('Image/tiffany.bmp');
I = rgb2gray(rgb);

percent = 1.0;
[rows,cols] = size(I);
BL=randi([0,1],[1,floor(percent*rows*cols)-2]);
[StegoIm11,~,~,~] = DEEdge_H5(BL,I);

figure
imshow(I)
title('original image')

figure
imshow(StegoIm11)
title(strcat('«∂»Î¬ =',num2str(percent),'bpp,PSNR=',num2str(PSNR(I,StegoIm11))))

% figure
% imshow(StegoIm12)
% title(strcat('stego12 image,PSNR=',num2str(PSNR(I,StegoIm12))))
% 
% figure
% imshow(StegoIm21)
% title(strcat('stego21 image,PSNR=',num2str(PSNR(I,StegoIm21))))
% 
% figure
% imshow(StegoIm22)
% title(strcat('stego22 image,PSNR=',num2str(PSNR(I,StegoIm22))))

toc