clear,clc
close all

%��ͬ��Ե����㷨��ͬ��λ��Ϣ��ȡ������Ե�������г�������ռ������ͼ��ı���
tic
bits = {'11111100','11111000','11110000','11100000','11000000','10000000'};
I = rgb2gray(imread('Image/lenna.bmp'));
[rows,cols] = size(I);
result=[];
for k=1:length(bits)
    [ths,pixlens,bw] = getLastThreshold(bitand(I,bin2dec(bits{7-k})),'zerocross');
    
    result=[result;[pixlens(end) pixlens(end)/(rows*cols)]];
end
toc
