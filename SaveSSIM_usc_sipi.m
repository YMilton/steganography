%AMGDE��д�㷨��Ƕ����Ϊ1bpp��SSIMֵʵ�����Ա�
clear,clc

file_path =  '.\Image\';% ͼ���ļ���·��
% imgjpg = dir(fullfile(fullfile(file_path),'*.jpg'));%��ȡ���ļ���������jpg��ʽ��ͼ��
imgbmp = dir(fullfile(fullfile(file_path),'*.bmp'));
% imgtif = dir(fullfile(fullfile(file_path),'*.tif'));
% filenames1 = {imgjpg.name}';
filenames2 = {imgbmp.name}';
% filenames3 = {imgtif.name}';
filename = filenames2;%ͼ��USC-SIPI�е�10��ͼ��
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