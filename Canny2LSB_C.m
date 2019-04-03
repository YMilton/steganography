% Saiful Islam,Mangat R Modi and Phalguni Gupta, Edge-based image
% steganography,EURASIP Journal on Information Security 2014

%非边缘部分也嵌入信息
function EMPicture = Canny2LSB_C(BinaryList,Picture)
    %BinaryList二进制信息
    %Picture图像像素值
    EMPicture = Picture;
    if isempty(BinaryList)
        EMPicture = Picture;
    else
        L = floor(length(BinaryList)/2);
        I = bitand(Picture,252);
        [~,lens,bw] = getThreshold(I,L);
        edge_pixels = Picture(bw==1);%边缘像素值
        non_edge_pixels = Picture(bw==0);%非边缘像素值
        
        %根据边缘像素值来分配二进制信息
        if L<=lens(end)
            edgebin = BinaryList(1:L*2);
            bit2matrix = reshape(edgebin,2,L);
            non_edgebin = BinaryList(L*2+1:end);
        else
            edgebin = BinaryList(1:length(edge_pixels)*2);
            bit2matrix = reshape(edgebin,2,length(edge_pixels));
            non_edgebin = BinaryList(length(edge_pixels)*2+1:end);
        end
        
        
        %边缘部分的嵌入
        Nedge_pixels = LSB2(edge_pixels,bit2matrix);
        EMPicture(bw==1) = Nedge_pixels;
        %非边缘的嵌入
        Nnon_edge_pixels = LSB1(non_edge_pixels,non_edgebin);
        EMPicture(bw==0) = Nnon_edge_pixels;
    end
end

%两个bit的嵌入，批量嵌入
function Npixels = LSB2(pixels,bit2s)
    Npixels = pixels;
    for k=1:length(bit2s)
        Npixels(k) = bitand(pixels(k),252) + 2*bit2s(1,k) + bit2s(2,k);
    end
end

%一个bit的嵌入
function Npixels = LSB1(pixels,bit1s)
    Npixels = pixels;
    for k=1:length(bit1s)
        Npixels(k) = bitand(pixels(k),254) + bit1s(k);
    end
end