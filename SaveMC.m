clear,clc

%Ƕ����Ϊ0.2bpp�µ�һ��Markov��ȫͳ��
SaveMCMat(0.2);

% file_path =  '.\ucid.v2\';% ͼ���ļ���·��
% imgjpg = dir(fullfile(fullfile(file_path),'*.jpg'));%��ȡ���ļ���������jpg��ʽ��ͼ��
% imgbmp = dir(fullfile(fullfile(file_path),'*.bmp'));
% imgtif = dir(fullfile(fullfile(file_path),'*.tif'));
% filenames1 = {imgjpg.name}';
% filenames2 = {imgbmp.name}';
% filenames3 = {imgtif.name}';
% filename = [filenames1;filenames2;filenames3];
% 
% t1 = clock;
% QS = [];
% percent = 0.2;
% for k = 1:length(filename)
%     disp(k)
%     P = imread(strcat(file_path,filename{k}));
%     if length(size(P))==3
%         GP = rgb2gray(P);
%     else
%         GP = P;
%     end
%     [m,n]=size(GP);
%     BinaryList = randi([0,1],[1,floor(percent*m*n)]);
%     Tmc = StandardAddCanny2LSB(GP,BinaryList);
%     QS = [QS,Tmc];
% end
% t2 = clock;
% t = etime(t2,t1);
% disp('0.2 Successful!');
% save addMC_ucid0_2.mat QS t
