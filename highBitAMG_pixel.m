clear,clc
close all

%获取不同高位信息的粗细网格像素点
% P = imread('Image/pepper.bmp');
% R = rgb2gray(P);
% 
% bits={'10000000','11000000','11100000','11110000','11111000','11111100','11111110','11111111'};
% figure
% for k=1:length(bits)
%     I = bitand(R,bin2dec(bits{k}));
%     [split,reimg] = FunSplit(I);
%     subplot(4,2,k)
%     imshow(reimg)
%     title(strcat('highBits=',num2str(k),',Cnodes=',num2str(sum(split==1)),',Fnodes=',num2str(sum(split==0))));
% end


file_path =  '.\Image\';% 图像文件夹路径
imgbmp = dir(fullfile(fullfile(file_path),'*.bmp'));
filename = {imgbmp.name}';
result = [];
for k = 1:length(filename)
    file = strcat(file_path,'\',filename{k});
    P = imread(file);
    R = rgb2gray(P);
    bits={'10000000','11000000','11100000','11110000','11111000','11111100','11111110','11111111'};
    
    edges=[];
    for i=1:length(bits)
        I = bitand(R,bin2dec(bits{i}));
        [split,~] = FunSplit(I);
%         [~,~,reimg] = getLastThreshold(I,'Canny');
%         split = reimg(:);
        edges=[edges,sum(split==1)];        
    end
    result = [result;[k edges]];
end
result
