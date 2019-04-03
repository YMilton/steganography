clear,clc
tic
rgb = imread('Image/lenna.bmp');
I = rgb2gray(rgb);

[rows,cols] = size(I);
BL=randi([0,1],[1,floor(rows*cols)-2]);
[StegoIm11,StegoIm12,StegoIm21,StegoIm22] = DEEdge_H(BL,I);
I1 = edge(I,'canny');
I11 = edge(StegoIm11,'canny');
I12 = edge(StegoIm11,'canny');
I21 = edge(StegoIm11,'canny');
I22 = edge(StegoIm11,'canny');
figure
subplot(231)
imshow(I1)
title('original image')
subplot(232)
imshow(I11)
title('stego11 image')
subplot(233)
imshow(I12)
title('stego12 image')
subplot(234)
imshow(I21)
title('stego21 image')
subplot(235)
imshow(I22)
title('stego22 image')


A = bitand(I,240);
B11 = bitand(StegoIm11,240);
B12 = bitand(StegoIm12,240);
B21 = bitand(StegoIm21,240);
B22 = bitand(StegoIm22,240);

sum(A(:)~=B11(:))
sum(A(:)~=B12(:))
sum(A(:)~=B21(:))
sum(A(:)~=B22(:))

toc