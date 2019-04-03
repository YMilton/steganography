clear,clc

image = imread('Image/tiffany.bmp');
I = rgb2gray(image);

I_edge = edge(I,'canny');
I7 = bitand(I,bin2dec('11111110'));
I7_edge = edge(I7,'canny');
I6 = bitand(I,bin2dec('11111100'));
I6_edge = edge(I6,'canny');
I5 = bitand(I,bin2dec('11111000'));
I5_edge = edge(I5,'canny');
I4 = bitand(I,bin2dec('11110000'));
I4_edge = edge(I5,'canny');
I3 = bitand(I,bin2dec('11100000'));
I3_edge = edge(I3,'canny');
I2 = bitand(I,bin2dec('11100000'));
I2_edge = edge(I2,'canny');
I1 = bitand(I,bin2dec('11100000'));
I1_edge = edge(I1,'canny');

figure
subplot(2,4,1)
imshow(I_edge)
title(strcat('ǰ8bits,PSNR=',num2str(PSNR(I,I))))
subplot(2,4,2)
imshow(I7_edge)
title(strcat('ǰ7bits,PSNR=',num2str(PSNR(I,I7))))
subplot(2,4,3)
imshow(I6_edge)
title(strcat('ǰ6bits,PSNR=',num2str(PSNR(I,I6))))
subplot(2,4,4)
imshow(I5_edge)
title(strcat('ǰ5bits,PSNR=',num2str(PSNR(I,I5))))
subplot(2,4,5)
imshow(I4_edge)
title(strcat('ǰ4bits,PSNR=',num2str(PSNR(I,I4))))
subplot(2,4,6)
imshow(I3_edge)
title(strcat('ǰ3bits,PSNR=',num2str(PSNR(I,I3))))
subplot(2,4,7)
imshow(I2_edge)
title(strcat('ǰ2bits,PSNR=',num2str(PSNR(I,I2))))
subplot(2,4,8)
imshow(I1_edge)
title(strcat('ǰ1bits,PSNR=',num2str(PSNR(I,I1))))