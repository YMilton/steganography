%һ��ͼƬ��Markov��ȫָ���£��ò�ͬǶ�����õ��İ�ȫָ��ֵ
clear,clc

P = imread('Image/lenna.bmp');
G = rgb2gray(P);
[m,n] = size(G);

percents = 0.1:0.1:1;
Res = [];
for k = 1:length(percents)
    disp(percents(k))
    if percents(k)==1
        BL = randi([0,1],[1,m*n-2]);
    else
        BL = randi([0,1],[1,floor(percents(k)*m*n)]);
    end
    Res = [Res,Stego_Methods_MC(G,BL)];
end

save LennaMC.mat Res
