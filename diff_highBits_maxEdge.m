clear,clc
close all

%不同边缘检测算法不同高位信息获取的最大边缘像素序列长度与其占据整幅图像的比率
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
