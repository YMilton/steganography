function [split,reimg] = FunSplit1(GrayMatrix)

[p,q] = size(GrayMatrix);
% PSF = fspecial('gaussian',5,5);%����һ���˲���
% tempIma = imfilter(GrayMatrix,PSF,'conv');%ͼ���ģ������
% image = rescaleImage(tempIma);
% NcutMatrix = ncut_multiscale(image);
NcutMatrix = ncut_multiscale(GrayMatrix);
%%pyamgִ��ģ��
save Mat\NcutData.mat NcutMatrix
% disp('Starting the method ruge_stuben_solver of pyamg!');
!python ruge_stuben_solver.py
% disp('Finish the method of the pyamg!');

%%pyamgģ��ִ����ϣ��õ�Mat����
load('Mat/RSSMat.mat');
split = double(level1);%%��һ��ָ�
reimg = reshape(split(1:p*q),p,q);
end

