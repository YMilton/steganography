%% 阈值的获取，条件是边缘点最大
function [ths,pixlens,bw] = getLastThreshold(I,method)
    %I是灰度图像
    [rows,cols]=size(I);
    N = rows*cols;
    %ths是迭代的阈值，pixelens是迭代的像素值长度，bw在最终阈值下的边缘化后的二值图像
    tmax = 1;
    tmin = 0;
    bool = 0;
    ths = [];
    pixlens = [];
    while ~bool
        th = (tmax+tmin)/2;
        ths = [ths;th];
        bw = edge(I,method,th);
        pixels = I(bw==1);
        %当边缘提取后轮廓像素值不再随阈值的变化而变化，即轮廓像素值恒定
        if ~isempty(pixlens) && pixlens(end)~=0 && length(pixels)==pixlens(end)
%             ths = ths(1:end-1,:);
            ths = ths(1:end,:);
            pixlens = [pixlens;length(pixels)];
            break;
        end
        pixlens = [pixlens;length(pixels)];
        if length(pixels)<N
            tmax = th;
        elseif length(pixels)-N>0.001*N
            tmin = th;
        else
            bool = 1;
        end
    end
end