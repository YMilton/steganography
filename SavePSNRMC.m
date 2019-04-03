clear,clc

file_path =  '.\ucid.v2\';% 图像文件夹路径
imgjpg = dir(fullfile(fullfile(file_path),'*.jpg'));%获取该文件夹中所有jpg格式的图像
imgbmp = dir(fullfile(fullfile(file_path),'*.bmp'));
imgtif = dir(fullfile(fullfile(file_path),'*.tif'));
filenames1 = {imgjpg.name}';
filenames2 = {imgbmp.name}';
filenames3 = {imgtif.name}';
filename = [filenames1;filenames2;filenames3];

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
%     Tmc = Standard_F(GP,BinaryList);
%     QS = [QS,Tmc];
% end
% t2 = clock;
% t = etime(t2,t1);
% disp('0.2 Successful!');
% save MC_ucid0_2.mat QS t
 
 
% t1 = clock;
% QS = [];
% percent = 0.4;
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
%     Tmc = Standard_F(GP,BinaryList);
%     QS = [QS,Tmc];
% end
% t2 = clock;
% t = etime(t2,t1);
% disp('0.4 Successful!');
% save MC_ucid0_4.mat QS t


t1 = clock;
QS = [];
percent = 0.6;
for k = 1:length(filename)
    disp(k)
    P = imread(strcat(file_path,filename{k}));
    if length(size(P))==3
        GP = rgb2gray(P);
    else
        GP = P;
    end
    [m,n]=size(GP);
    BinaryList = randi([0,1],[1,floor(percent*m*n)]);
    Tmc = Standard_F(GP,BinaryList);
    QS = [QS,Tmc];
end
t2 = clock;
t = etime(t2,t1);
disp('0.6 Successful!');
save MC_ucid0_6.mat QS t


% t1 = clock;
% QS = [];
% percent = 0.8;
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
%     Tmc = Standard_F(GP,BinaryList);
%     QS = [QS,Tmc];
% end
% t2 = clock;
% t = etime(t2,t1);
% disp('0.8 Successful!');
% save MC_ucid0_8.mat QS t


% t1 = clock;
% QS = [];
% percent = 1;
% for k = 1:length(filename)
%     disp(k)
%     P = imread(strcat(file_path,filename{k}));
%     if length(size(P))==3
%         GP = rgb2gray(P);
%     else
%         GP = P;
%     end
%     [m,n]=size(GP);
%     BinaryList = randi([0,1],[1,floor(percent*(m*n-2))]);
%     Tmc = Standard_F(GP,BinaryList);
%     QS = [QS,Tmc];
% end
% t2 = clock;
% t = etime(t2,t1);
% disp('1 Successful!');
% save MC_ucid1_0.mat QS t