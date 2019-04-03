clear,clc

% tic
% image = imread('Image/lenna.bmp');
% I = rgb2gray(image);
% [rows,cols] = size(I);
% 
% MCs = [];
% for percent = 0.1:0.1:1
%     disp(percent)
%     BL=randi([0,1],[1,round(rows*cols*percent)-2]);
%     ILSBR = LSBR(BL,I);
%     ILSBM = LSBM(BL,I);
%     ICannyLSB = Canny2LSB_C(BL,I);
%     IDE1 = DE(BL,I,1);
% %     IDE2 = DE(BL,I,2);
% %     [StegoIm11,StegoIm12,StegoIm21,StegoIm22] = DEEdge(BL,I);
%     
%     [StegoIm11] = DEEdge_H5(BL,I);
%     
% %     MC_C = [MCDistance(I,ILSBR),MCDistance(I,ILSBM),MCDistance(I,ICannyLSB),MCDistance(I,IDE1),MCDistance(I,IDE2),MCDistance(I,StegoIm11),MCDistance(I,StegoIm12),MCDistance(I,StegoIm21),MCDistance(I,StegoIm22)];
%     
%     MC_C = [MCDistance(I,ILSBR),MCDistance(I,ILSBM),MCDistance(I,ICannyLSB),MCDistance(I,IDE1),MCDistance(I,StegoIm11)];
% 
%     MCs = [MCs;MC_C];
% end
% toc

% save BaboonMCs.mat MCs

load LennaMCs.mat

pct = 0.1:0.1:1;
plot(pct,MCs(:,1),'-o',pct,MCs(:,2),'-d',pct,MCs(:,3),'-p',pct,MCs(:,4),'-s',pct,MCs(:,5),'-v','LineWidth',1.5)
legend('LSBR','LSBM','EBIS','DE1','CANNYDE','Location','NorthWest')
xlabel('嵌入率(bpp)')
ylabel('一阶Markov安全指标值')
grid on
set(get(gca,'XLabel'),'FontSize',10.5);
set(get(gca,'YLabel'),'FontSize',10.5);
set(gca,'fontsize',10.5);