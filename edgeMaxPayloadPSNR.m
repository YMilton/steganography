clear,clc
% close all

%不同边缘检测算法在边缘像素序列替换最低有效位的位数不同情况下，PSNR值与最大嵌入容量的比较
tic
bits = {'11111100','11111000','11110000','11100000','11000000','10000000'};
method = 'EdgeLSBR1';
edgeMethod = 'ZeroCross';
im = imread('Image/lenna.bmp');
I = rgb2gray(im);
[row,col] = size(I);
result = [];
for k=1:length(bits)
    [~,pixlens,~] = getLastThreshold(bitand(I,bin2dec(bits{k})),edgeMethod);
    edgeLength = pixlens(end);
    BL = randi([0,1],[1,(edgeLength*(k+1)+row*col-edgeLength)]);
    p = str2func(method);
    Stego = p(BL,I,(k+1),edgeMethod);
    result = [result;[(k+1),edgeLength/(row*col),length(BL)/(row*col),PSNR(I,Stego)]];%[替换的位数 边缘点比率 嵌入率 PSNR值]
%     figure
%     subplot(1,2,1)
%     imshow(I)
%     subplot(1,2,2)
%     imshow(Stego)
%     title(strcat('PSNR=',num2str(PSNR(I,Stego))))
end
toc

result

bound = ones(length(result(:,1)),1)*38;
[AX,H1,H2] = plotyy(result(:,1),result(:,3),result(:,1),[result(:,4),bound]);
set(get(AX(1),'Ylabel'),'String','嵌入率(bpp)')
set(get(AX(2),'Ylabel'),'String','峰值信噪比(dB)')
xlabel('NLSB(位数)')
% title(strcat(edgeMethod,'边缘检测隐写算法'))
% set(H1(1),'LineWidth',1.5,'marker','v')%边缘点比率
set(H1,'LineWidth',1.5,'marker','o')%嵌入率

set(H2(1),'LineWidth',1.5,'marker','s')%PSNR值
set(H2(2),'LineWidth',1.5,'LineStyle',':')%38dB
legend([H1,H2(1)],'嵌入率','峰值信噪比')

% grid on