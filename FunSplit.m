function [split,reimg] = FunSplit(GrayMatrix)

[p,q] = size(GrayMatrix);
% PSF = fspecial('gaussian',5,5);%创建一个滤波器
% tempIma = imfilter(GrayMatrix,PSF,'conv');%图像的模糊处理
% image = rescaleImage(tempIma);
% NcutMatrix = ncut_multiscale(image);
NcutMatrix = ncut_multiscale(GrayMatrix);
%%pyamg执行模块
save Mat\NcutData.mat NcutMatrix
% disp('Starting the method ruge_stuben_solver of pyamg!');
!python ruge_stuben_solver.py
% disp('Finish the method of the pyamg!');
%%pyamg模块执行完毕，得到Mat数据
load('Mat/RSSMat.mat');
split{1} = double(level1);%%第一层分割
split{2} = double(level2);%%第二层分割
split{3} = double(level3);%%第三层分割
split{4} = double(level4);%%第四层分割
split{5} = double(level5);%%第五层分割

index1 = find(split{1});
index2 = find(split{2});
index3 = find(split{3});
index4 = find(split{4});
index5 = find(split{5});

%%获取分割数据图片大小长度的数据
imgBin = zeros(size(split{1}));
imgBin(index1)=1;
reimg{1} = reshape(imgBin(1:p*q),p,q);%%第一层分割

imgBin = zeros(size(split{1}));
imgBin(index1(index2))=1;
reimg{2} = reshape(imgBin(1:p*q),p,q);%%第二层分割

imgBin = zeros(size(split{1}));
imgBin(index1(index2(index3)))=1;
reimg{3} = reshape(imgBin(1:p*q),p,q);%%第三层分割

imgBin = zeros(size(split{1}));
imgBin(index1(index2(index3(index4))))=1;
reimg{4} = reshape(imgBin(1:p*q),p,q);%%第四层分割

imgBin = zeros(size(split{1}));
imgBin(index1(index2(index3(index4(index5)))))=1;
reimg{5} = reshape(imgBin(1:p*q),p,q);%%第五层分割

% reimg = imreize(split(1:p*q),p,q);

end

