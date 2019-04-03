clc,clear;
tic
P = imread('Image\tiffany.bmp');
GP = rgb2gray(P);
[split,reimg] = FunSplit(GP);

%%网格化嵌入部分
positionO = find(reimg==1);%查找为1的位置
NumO = length(positionO)-1;
BL = randi([0,1],[1,int64(NumO)]);
vector = GP(positionO);
%%获得网格化的图像嵌入数据的图片
nvector = OPAP(BL,vector);
NGPO = GP;
NGPO(positionO) = nvector;

positionZ = find(reimg==0);%%获取网格中值为0的位置
vector = GP(positionZ);
%%获得网格化的图像嵌入数据的图片
nvector = OPAP(BL,vector);
NGPZ = GP;
NGPZ(positionZ) = nvector;

%%非网格化嵌入
NGP = Embed_Core_Matrix(BL,GP);

subplot(2,2,1)
imshow(GP);
title('原始灰度图像')
subplot(2,2,2)
imshow(NGP);
psnr = PSNR(GP,NGP);
title(strcat('顺序嵌入的载密图像,PSNR=',num2str(psnr)))
subplot(2,2,3)
imshow(NGPO);
psnr = PSNR(GP,NGPO);
title(strcat('嵌入点选取为1的载密图像(splitting=1),PSNR=',num2str(psnr)))
subplot(2,2,4)
imshow(NGPZ);
psnr = PSNR(GP,NGPZ);
title(strcat('嵌入点选取为0的载密图像(splitting=0),PSNR=',num2str(psnr)))
suptitle(strcat('嵌入二进制长度=',num2str(length(BL))))
toc
