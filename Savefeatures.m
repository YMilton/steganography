clear,clc;
%%ѡ��2000��ͼƬ�ֱ���Markovͳ�Ƶ�Ƕ�롢���Ƕ�롢������������Ϊ0��1��Ƕ��
%%Ȼ����PSNRֵ��Markovͳ�ư�ȫ�������ص�ֵ�Ĵ洢
file_path =  '.\ucid.v2\';% ͼ���ļ���·��
imgjpg = dir(fullfile(file_path,'*.jpg'));%��ȡ���ļ���������jpg��ʽ��ͼ��
imgbmp = dir(fullfile(file_path,'*.bmp'));
imgtif = dir(fullfile(file_path,'*.tif'));
filenames1 = {imgjpg.name}';
filenames2 = {imgbmp.name}';
filenames3 = {imgtif.name}';
filename = [filenames1;filenames2;filenames3];

t1 = clock;
fname = randperm(length(filename),floor(length(filename)/2));
for k = 1:length(filename)
    disp(k)
    if ismember(k,fname)==0%ͼ����û�б�ѡ��
        P = imread(strcat(file_path,filename{k}));
        if length(size(P))==3
            GP = rgb2gray(P);
        else
            GP = P;
        end
        labelcover = -1;%δǶ����Ϣͼ��
        features11(k,:) = [labelcover,spam686(GP)'];
        features21(k,:) = [labelcover,spam686(GP)'];
        features22(k,:) = [labelcover,spam686(GP)'];
    else
        P = imread(strcat(file_path,filename{k}));
        if length(size(P))==3
            GP = rgb2gray(P);
        else
            GP = P;
        end        
        [row,col] = size(GP);
        BL = randi([0,1],[1,row*col-1]);
        [Stego11,Stego21,Stego22] = DEAMG(GP);
        labelstego = 1;
        features11(k,:) = [labelstego,spam686(Stego11)'];
        features21(k,:) = [labelstego,spam686(Stego21)'];
        features22(k,:) = [labelstego,spam686(Stego22)'];
    end
end
disp('AMGDE Successful!');
t2 = clock;
t = etime(t2,t1);
features = features11;
save AMGDE11TrainFeatures_ucid.mat features t
features = features21;
save AMGDE21TrainFeatures_ucid.mat features t
features = features22;
save AMGDE22TrainFeatures_ucid.mat features t



file_path =  '.\jpgbows2-1g\';% ͼ���ļ���·��
imgjpg = dir(fullfile(fullfile(file_path),'*.jpg'));%��ȡ���ļ���������jpg��ʽ��ͼ��
imgbmp = dir(fullfile(fullfile(file_path),'*.bmp'));
imgtif = dir(fullfile(fullfile(file_path),'*.tif'));
filenames1 = {imgjpg.name}';
filenames2 = {imgbmp.name}';
filenames3 = {imgtif.name}';
filename = [filenames1;filenames2;filenames3];


t1 = clock;
fname = randperm(length(filename),floor(length(filename)/2));
for k = 1:length(filename)
    disp(k)
    if ismember(k,fname)==0%ͼ����û�б�ѡ��
        P = imread(strcat(file_path,filename{k}));
        if length(size(P))==3
            GP = rgb2gray(P);
        else
            GP = P;
        end
        labelcover = -1;%δǶ����Ϣͼ��
        features11(k,:) = [labelcover,spam686(GP)'];
        features21(k,:) = [labelcover,spam686(GP)'];
        features22(k,:) = [labelcover,spam686(GP)'];
    else
        P = imread(strcat(file_path,filename{k}));
        if length(size(P))==3
            GP = rgb2gray(P);
        else
            GP = P;
        end        
        [row,col] = size(GP);
        BL = randi([0,1],[1,row*col-1]);
        [Stego11,Stego21,Stego22] = DEAMG(GP);
        labelstego = 1;
        features11(k,:) = [labelstego,spam686(Stego11)'];
        features21(k,:) = [labelstego,spam686(Stego21)'];
        features22(k,:) = [labelstego,spam686(Stego22)'];
    end
end
disp('AMGDE Successful!');
t2 = clock;
t = etime(t2,t1);
features = features11;
save AMGDE11TrainFeatures_rsp.mat features t
features = features21;
save AMGDE21TrainFeatures_rsp.mat features t
features = features22;
save AMGDE22TrainFeatures_rsp.mat features t


% t1 = clock;
% fname = randperm(length(filename),floor(length(filename)/2));
% for k = 1:length(filename)
%     disp(k)
%     if ismember(k,fname)==0%ͼ����û�б�ѡ��
%         P = imread(strcat(file_path,filename{k}));
%         if length(size(P))==3
%             GP = rgb2gray(P);
%         else
%             GP = P;
%         end
%         labelcover = -1;%δǶ����Ϣͼ��
%         features(k,:) = [labelcover,spam686(GP)'];
%     else
%         P = imread(strcat(file_path,filename{k}));
%         if length(size(P))==3
%             GP = rgb2gray(P);
%         else
%             GP = P;
%         end
%         [row,col] = size(GP);
%         BL = randi([0,1],[1,row*col]);
%         Stego = OPAP(BL,GP);
%         labelstego = 1;
%         features(k,:) = [labelstego,spam686(Stego)'];
%     end
% end
% disp('OPAP Successful!');
% t2 = clock;
% t = etime(t2,t1);
% save PrueOPAP2TrainFeatures_ucid.mat features t


% t1 = clock;
% fname = randperm(length(filename),floor(length(filename)/2));
% for k = 1353:length(filename)
%     disp(k)
%     if ismember(k,fname)==0%ͼ����û�б�ѡ��
%         P = imread(strcat(file_path,filename{k}));
%         if length(size(P))==3
%             GP = rgb2gray(P);
%         else
%             GP = P;
%         end
%         labelcover = -1;%δǶ����Ϣͼ��
%         features(k,:) = [labelcover,spam686(GP)'];
%     else
%         P = imread(strcat(file_path,filename{k}));
%         if length(size(P))==3
%             GP = rgb2gray(P);
%         else
%             GP = P;
%         end
%         [row,col] = size(GP);
%         BL = randi([0,1],[1,row*col]);
%         Stego = EMD(BL,GP,3,1);
%         labelstego = 1;
%         features(k,:) = [labelstego,spam686(Stego)'];
%     end
% end
% disp('EMD31 Successful!');
% t2 = clock;
% t = etime(t2,t1);
% save PrueEMD31TrainFeatures_ucid.mat features t


% t1 = clock;
% fname = randperm(length(filename),floor(length(filename)/2));
% for k = 1:length(filename)
%     disp(k)
%     if ismember(k,fname)==0%ͼ����û�б�ѡ��
%         P = imread(strcat(file_path,filename{k}));
%         if length(size(P))==3
%             GP = rgb2gray(P);
%         else
%             GP = P;
%         end
%         labelcover = -1;%δǶ����Ϣͼ��
%         features(k,:) = [labelcover,spam686(GP)'];
%     else
%         P = imread(strcat(file_path,filename{k}));
%         if length(size(P))==3
%             GP = rgb2gray(P);
%         else
%             GP = P;
%         end
%         Stego = DEAMG(GP);
%         labelstego = 1;
%         features(k,:) = [labelstego,spam686(Stego)'];
%     end
% end
% disp('DE12 Successful!');
% t2 = clock;
% t = etime(t2,t1);
% save AMGDE12TrainFeatures_rsp.mat features t


