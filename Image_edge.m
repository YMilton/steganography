clear,clc


image = imread('Image/lenna.bmp');
I = rgb2gray(image);
I_sobel = edge(I,'sobel');
sum_1_sobel = sum(sum(I_sobel==1))
I_canny = edge(I,'Canny');
sum_1_canny = sum(sum(I_canny==1))
I_log = edge(I,'log',0.0005);
sum_1_log = sum(sum(I_log==1))
I_prewitt = edge(I,'Prewitt',0.035);
sum_1_prewitt = sum(sum(I_prewitt==1))
I_zerocross = edge(I,'zerocross');
sum_1_zerocross = sum(sum(I_zerocross==1))


subplot(2,3,1)
imshow(I)
title('ԭͼ')
subplot(2,3,2)
imshow(I_sobel)
title('sobel')
subplot(2,3,3)
imshow(I_canny)
title('canny')
subplot(2,3,4)
imshow(I_log)
title('Laplacian of Gaussian')
subplot(2,3,5)
imshow(I_prewitt)
title('Prewitt')
subplot(2,3,6)
imshow(I_zerocross)
title('zerocross')