%AMGDE隐写算法在嵌入率为1bpp的SSIM值实验结果对比
clear,clc

file_path =  '.\Image\';% 图像文件夹路径
% imgjpg = dir(fullfile(fullfile(file_path),'*.jpg'));%获取该文件夹中所有jpg格式的图像
imgbmp = dir(fullfile(fullfile(file_path),'*.bmp'));
% imgtif = dir(fullfile(fullfile(file_path),'*.tif'));
% filenames1 = {imgjpg.name}';
filenames2 = {imgbmp.name}';
% filenames3 = {imgtif.name}';
filename = filenames2;%图库USC-SIPI中的10张图像
% load ('Mat\BL.mat');

t1 = clock;
SSIMs = [];
for k = 1:length(filename)
    disp(k)
    P = imread(strcat(file_path,filename{k}));
    if length(size(P))==3
        GP = rgb2gray(P);
    else
        GP = P;
    end
    [m,n]=size(GP);
    BinaryList = randi([0,1],[1,m*n-2]);
%     BinaryList = BL(1,m*n-2);
    Tmc = Standard_PSNR(GP,BinaryList);
    SSIMs = [SSIMs,Tmc];
end
t2 = clock;
t = etime(t2,t1);
SSIMs = SSIMs';
SSIMs(:,[3,4,10])=[]
save('SSIMs.mat','SSIMs');
disp('Successful!');