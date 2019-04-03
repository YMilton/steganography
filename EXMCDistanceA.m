clear,clc;

P = imread('Image\lenna.bmp');
GP = rgb2gray(P);
[row,col] = size(GP);
[~,reimg] = FunSplit(GP);

%%网格化嵌入部分
positionO = find(reimg==1);%查找为1的位置
positionZ = find(reimg==0);%%获取网格中值为0的位置
BL = randi([0,1],[1,row*col-1]);

NGPA = GP;
%%代数多重网格网格化嵌入部分
vector1 = GP(positionO);
vector2 = GP(positionZ);
BL1 = BL(1:length(vector1));
BL2 = BL(length(vector1)+1:end);
%%获得网格化的图像嵌入数据的图片
nvector1 = DE(BL1,vector1,2);
NGPA(positionO) = nvector1;

nvector2 = DE(BL2,vector2,1);
NGPA(positionZ) = nvector2;

%非网格化嵌入
[NGPM,R] = Embed_Core_Matrix(BL,GP);
NGPD = DE(BL,GP,1);

subplot(3,1,1)
imshow(NGPM);
mcd = MCDistance(GP,NGPM);
title(strcat('顺序Markov嵌入,MCDistance=',num2str(mcd)))
subplot(3,1,2)
imshow(NGPD);
mcd = MCDistance(GP,NGPD);
title(strcat('原始DE,MCDistance=',num2str(mcd)))
subplot(3,1,3)
imshow(NGPA);
mcd = MCDistance(GP,NGPA);
title(strcat('DE(splitting=1),MCDistance=',num2str(mcd)))
suptitle(strcat('嵌入二进制长度=',num2str(length(BL))))

