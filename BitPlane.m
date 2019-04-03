% 图像不同的位平面效果图
clear,clc
close all

image = imread('Image/Yacht.bmp');
I = rgb2gray(image);

I8 = bitand(I,bin2dec('10000000'));

I7 = bitand(I,bin2dec('01000000'));

I6 = bitand(I,bin2dec('00100000'));

I5 = bitand(I,bin2dec('00010000'));

I4 = bitand(I,bin2dec('00001000'));

I3 = bitand(I,bin2dec('00000100'));

I2 = bitand(I,bin2dec('00000010'));

I1 = bitand(I,bin2dec('00000001'));

figure
subplot(2,4,1)
imshow(I8,[])
title('第8位')
% figure
subplot(2,4,2)
imshow(I7,[])
title('第7位')
% figure
subplot(2,4,3)
imshow(I6,[])
title('第6位')
% figure
subplot(2,4,4)
imshow(I5,[])
title('第5位')
% figure
subplot(2,4,5)
imshow(I4,[])
title('第4位')
% figure
subplot(2,4,6)
imshow(I3,[])
title('第3位')
% figure
subplot(2,4,7)
imshow(I2,[])
title('第2位')
% figure
subplot(2,4,8)
imshow(I1,[])
title('第1位')

ones = sum(sum(I1==1))
zeros = sum(sum(I1==0))