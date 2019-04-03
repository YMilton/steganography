clear,clc

file_path =  '.\ucid.v2\';% ͼ���ļ���·��
imgjpg = dir(fullfile(fullfile(file_path),'*.jpg'));%��ȡ���ļ���������jpg��ʽ��ͼ��
imgbmp = dir(fullfile(fullfile(file_path),'*.bmp'));
imgtif = dir(fullfile(fullfile(file_path),'*.tif'));
filenames1 = {imgjpg.name}';
filenames2 = {imgbmp.name}';
filenames3 = {imgtif.name}';
filename = [filenames1;filenames2;filenames3];

load AMGDE11TrainFeatures_ucid1.mat
label = features(:,1);
index = find(label==0);
if label(end)==1
    index = [index;1338];
end

for k = 1:length(index)
    disp(index(k));
    P = imread(strcat(file_path,filename{index(k)}));
    if length(size(P))==3
        GP = rgb2gray(P);
    else
        GP = P;
    end
    labelcover = -1;%δǶ����Ϣͼ��
    features(index(k),:) = [labelcover,spam686(GP)'];
end

save AMGDE11TrainFeatures_ucid2.mat features t