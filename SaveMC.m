clear,clc

%嵌入率为0.2bpp下的一阶Markov安全统计
SaveMCMat(0.2);

% file_path =  '.\ucid.v2\';% 图像文件夹路径
% imgjpg = dir(fullfile(fullfile(file_path),'*.jpg'));%获取该文件夹中所有jpg格式的图像
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
