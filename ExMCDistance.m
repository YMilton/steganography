clear,clc;
t1 = clock;
P = imread('Image\lenna.bmp');
GP = rgb2gray(P);
[row,col] = size(GP);
[~,reimg] = FunSplit(GP);
%%����Ƕ�벿��
positionO = find(reimg==1);%����Ϊ1��λ��
positionZ = find(reimg==0);%%��ȡ������ֵΪ0��λ��
BL = randi([0,1],[1,length(positionO)-4]);

%%����������������Ƕ�벿��
vector = GP(positionO);
%%������񻯵�ͼ��Ƕ�����ݵ�ͼƬ
nvector = EMD(BL,vector,5,2);
NGPO = GP;
NGPO(positionO) = nvector;

vector = GP(positionZ);
%%������񻯵�ͼ��Ƕ�����ݵ�ͼƬ
nvector = EMD(BL,vector,5,2);
NGPZ = GP;
NGPZ(positionZ) = nvector;

% %������񻯵�ͼ��Ƕ�����ݵ�ͼƬ
% NGPO = Embed_Core_AMG(BL,positionO,GP);
% %������񻯵�ͼ��Ƕ�����ݵ�ͼƬ
% NGPZ = Embed_Core_AMG(BL,positionZ,GP);

%������Ƕ��
[NGP,R] = Embed_Core_Matrix(BL,GP);
NGPR = EmbedRandom(BL,GP);

subplot(2,2,1)
imshow(NGPR);
mcd = MCDistance(GP,NGPR);
title(strcat('���Ƕ��,MCDistance=',num2str(mcd)))
subplot(2,2,2)
imshow(NGP);
mcd = MCDistance(GP,NGP);
% title(strcat('˳��Ƕ�������ͼ��,MCDistance=',num2str(mcd)))
title(strcat('˳��MarkovǶ��,MCDistance=',num2str(mcd)))
subplot(2,2,3)
imshow(NGPO);
mcd = MCDistance(GP,NGPO);
% title(strcat('Ƕ���ѡȡΪ1������ͼ��(splitting=1),MCDistance=',num2str(mcd)))
title(strcat('EMD(splitting=1),MCDistance=',num2str(mcd)))
subplot(2,2,4)
imshow(NGPZ);
mcd = MCDistance(GP,NGPZ);
% title(strcat('Ƕ���ѡȡΪ0������ͼ��(splitting=0),MCDistance=',num2str(mcd)))
title(strcat('EMD(splitting=0),MCDistance=',num2str(mcd)))
suptitle(strcat('Ƕ������Ƴ���=',num2str(length(BL))))

t2 = clock;
t = etime(t2,t1);
save time t t2

