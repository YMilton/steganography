% ͼ��ͬ��λƽ��Ч��ͼ
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
title('��8λ')
% figure
subplot(2,4,2)
imshow(I7,[])
title('��7λ')
% figure
subplot(2,4,3)
imshow(I6,[])
title('��6λ')
% figure
subplot(2,4,4)
imshow(I5,[])
title('��5λ')
% figure
subplot(2,4,5)
imshow(I4,[])
title('��4λ')
% figure
subplot(2,4,6)
imshow(I3,[])
title('��3λ')
% figure
subplot(2,4,7)
imshow(I2,[])
title('��2λ')
% figure
subplot(2,4,8)
imshow(I1,[])
title('��1λ')

ones = sum(sum(I1==1))
zeros = sum(sum(I1==0))