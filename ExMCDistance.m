clear,clc;
t1 = clock;
P = imread('Image\lenna.bmp');
GP = rgb2gray(P);
[row,col] = size(GP);
[~,reimg] = FunSplit(GP);
%%网格化嵌入部分
positionO = find(reimg==1);%查找为1的位置
positionZ = find(reimg==0);%%获取网格中值为0的位置
BL = randi([0,1],[1,length(positionO)-4]);

%%代数多重网格网格化嵌入部分
vector = GP(positionO);
%%获得网格化的图像嵌入数据的图片
nvector = EMD(BL,vector,5,2);
NGPO = GP;
NGPO(positionO) = nvector;

vector = GP(positionZ);
%%获得网格化的图像嵌入数据的图片
nvector = EMD(BL,vector,5,2);
NGPZ = GP;
NGPZ(positionZ) = nvector;

% %获得网格化的图像嵌入数据的图片
% NGPO = Embed_Core_AMG(BL,positionO,GP);
% %获得网格化的图像嵌入数据的图片
% NGPZ = Embed_Core_AMG(BL,positionZ,GP);

%非网格化嵌入
[NGP,R] = Embed_Core_Matrix(BL,GP);
NGPR = EmbedRandom(BL,GP);

subplot(2,2,1)
imshow(NGPR);
mcd = MCDistance(GP,NGPR);
title(strcat('随机嵌入,MCDistance=',num2str(mcd)))
subplot(2,2,2)
imshow(NGP);
mcd = MCDistance(GP,NGP);
% title(strcat('顺序嵌入的载密图像,MCDistance=',num2str(mcd)))
title(strcat('顺序Markov嵌入,MCDistance=',num2str(mcd)))
subplot(2,2,3)
imshow(NGPO);
mcd = MCDistance(GP,NGPO);
% title(strcat('嵌入点选取为1的载密图像(splitting=1),MCDistance=',num2str(mcd)))
title(strcat('EMD(splitting=1),MCDistance=',num2str(mcd)))
subplot(2,2,4)
imshow(NGPZ);
mcd = MCDistance(GP,NGPZ);
% title(strcat('嵌入点选取为0的载密图像(splitting=0),MCDistance=',num2str(mcd)))
title(strcat('EMD(splitting=0),MCDistance=',num2str(mcd)))
suptitle(strcat('嵌入二进制长度=',num2str(length(BL))))

t2 = clock;
t = etime(t2,t1);
save time t t2

