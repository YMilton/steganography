%边缘检测高效隐写，分开嵌入
function EMPicture = EdgeLSBR1(BinaryList,Picture,N,method)
    %N表示边缘像素序列替换最低有效位的位数
    %BinaryList二进制信息
    %Picture图像像素值
    bits = {'11111110','11111100','11111000','11110000','11100000','11000000','10000000'};
    EMPicture = Picture;
    if isempty(BinaryList)
        EMPicture = Picture;
    else
        I = bitand(Picture,bin2dec(bits{N}));
        [~,lens,bw] = getLastThreshold(I,method);
        edge_pixels = Picture(bw==1);%边缘像素序列集
        non_edge_pixels = Picture(bw==0);%非边缘像素序列集
        
        L = floor(length(BinaryList)/N);
        
        %根据边缘像素值来分配二进制信息
        if L<=lens(end)%如果二进制正好完全嵌入边缘像素序列
            edgebin = BinaryList(1:L*N);
            bit2matrix = reshape(edgebin,N,L);
            non_edgebin = BinaryList(L*N+1:end);
        else
            edgebin = BinaryList(1:length(edge_pixels)*N);
            bit2matrix = reshape(edgebin,N,length(edge_pixels));
            non_edgebin = BinaryList(length(edge_pixels)*N+1:end);
        end
        
        
        %边缘部分的嵌入
        Nedge_pixels = LSB_N(edge_pixels,bit2matrix,bin2dec(bits{N}));
        EMPicture(bw==1) = Nedge_pixels;
        %非边缘的嵌入
        Nnon_edge_pixels = LSB1(non_edge_pixels,non_edgebin);
        EMPicture(bw==0) = Nnon_edge_pixels;
    end
end

%两个bit的嵌入，批量嵌入
function Npixels = LSB_N(pixels,bit2s,num)
    Npixels = pixels;
    for k=1:length(bit2s)
        Npixels(k) = bitand(pixels(k),num) + bin2value(bit2s(:,k));
    end
end

function value = bin2value(bits)
    value = 0;
    nbits = flipud(bits);
    for k=1:length(nbits)
        value = value + nbits(k)*2^(k-1);
    end
end

%一个bit的嵌入
function Npixels = LSB1(pixels,bit1s)
    Npixels = pixels;
    for k=1:length(bit1s)
        Npixels(k) = bitand(pixels(k),254) + bit1s(k);
    end
end