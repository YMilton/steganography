clear,clc
close all

image = imread('Image/tiffany.bmp');
I = rgb2gray(image);
[rows,cols] = size(I);

PSNRs = [];
for percent = 0.25:0.25:1
    BL=randi([0,1],[1,round(rows*cols*percent)-2]);
    ILSBR = LSBR(BL,I);
    ILSBM = LSBM(BL,I);
    ICannyLSB = Canny2LSB_C(BL,I);
    IDE1 = DE(BL,I,1);
    IDE2 = DE(BL,I,2);
    [StegoIm11,StegoIm12,StegoIm21,StegoIm22] = DEEdge(BL,I);
    p = PSNR(I,ILSBR);
    PSNR_C = [PSNR(I,ILSBR),PSNR(I,ILSBM),PSNR(I,ICannyLSB),PSNR(I,IDE1),PSNR(I,IDE2),PSNR(I,StegoIm11),PSNR(I,StegoIm12),PSNR(I,StegoIm21),PSNR(I,StegoIm22)];
    PSNRs = [PSNRs;PSNR_C];
end
save PSNRs.mat PSNRs
