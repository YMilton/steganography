clear,clc
close all

img = imread('monarch.bmp');
G = rgb2gray(img);
figure
for k=0:7
    I = bitand(G,2^(7-k));
    subplot(2,4,k+1)
    imshow(I,[]);
    title(strcat('µÚ',num2str(8-k),'Î»'))
end