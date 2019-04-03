function SaveMCMat(percent)
    file_path =  '.\ucid.v2\';% 图像文件夹路径 ucid.v2图库1338张图像
    imgjpg = dir(fullfile(fullfile(file_path),'*.jpg'));%获取该文件夹中所有jpg格式的图像
    imgbmp = dir(fullfile(fullfile(file_path),'*.bmp'));
    imgtif = dir(fullfile(fullfile(file_path),'*.tif'));
    filenames1 = {imgjpg.name}';
    filenames2 = {imgbmp.name}';
    filenames3 = {imgtif.name}';
    filename = [filenames1;filenames2;filenames3];

    t1 = clock;
    QS = [];
    for k = 1:length(filename)
        disp(k)
        P = imread(strcat(file_path,filename{k}));
        if length(size(P))==3
            GP = rgb2gray(P);
        else
            GP = P;
        end
        [m,n]=size(GP);
        if percent~=1
            BinaryList = randi([0,1],[1,floor(percent*m*n)]);
        else
            BinaryList = randi([0,1],[1,floor(percent*m*n)-2]);
        end
        Tmc = StandardAddCanny2LSB(GP,BinaryList);
        QS = [QS,Tmc];
    end
    t2 = clock;
    t = etime(t2,t1);
    str = strcat(num2str(percent),' Successful!');
    disp(str);
    if percent~=1
        s = strcat('addMC_ucid',num2str(percent),'.mat');
        save(s,'QS','t')
    else
        save addMC_ucid1.0.mat QS t
    end
end
