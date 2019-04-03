% clear,clc
% x=[2,2,2,3,3,4,4,5,6,6,7,7,7];
% y=[2,4,5,4,6,3,4,5,2,5,3,5,7];
% xx = [2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,5,6,6,6,6,7,7,7];
% yy = [3,6,7,2,3,5,7,2,5,6,7,2,3,4,6,7,3,4,6,7,2,4,6];
% plot(x,y,'ko','linewidth',1.5);
% hold on
% plot(xx,yy,'kx','linewidth',1.5,'MarkerSize',10);
% grid on
% axis([1 8 1 8]);

clear,clc
A = randi([0 1],[64 64]);
[row,col] = size(A);
hold on
for i = 1:row
    for j = 1:col
        if A(i,j)==0
            plot(i,j,'k*');
        else
            plot(i,j,'ko');
        end
    end
end
grid on
axis([1 64 1 64])
%去掉x、y轴的数据
set(gca,'xtick',[],'xticklabel',[]);
set(gca,'ytick',[],'yticklabel',[])