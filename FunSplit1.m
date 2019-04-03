function [split,reimg] = FunSplit1(GrayMatrix)

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
split = double(level1);%%第一层分割
reimg = reshape(split(1:p*q),p,q);
end

