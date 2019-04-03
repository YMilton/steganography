% Saiful Islam,Mangat R Modi and Phalguni Gupta, Edge-based image
% steganography,EURASIP Journal on Information Security 2014

function EMPicture = Canny2LSB(BinaryList,Picture)
    %BinaryList二进制信息
    %Picture图像像素值
    EMPicture = Picture;
    if isempty(BinaryList)
        EMPicture = Picture;
    else
        binL = length(BinaryList);
        if mod(binL,2)==1
            BinaryList = [BinaryList,0];
        end
        bit2matrix = reshape(BinaryList,2,length(BinaryList)/2);%待嵌入的二进制信息
        
        L = length(BinaryList)/2;
        I = bitand(Picture,252);
        [~,pixelen,bw] = getThreshold(I,L);
        edge_pixels = Picture(bw==1);%边缘像素值
        
        %进行嵌入
        if pixelen(end)<length(bit2matrix)%边缘像素小于二进制矩阵的长度
            [rows,cols] = size(Picture);
            fprintf('binary list is too long, the largest embedding rate is:%f.\n',pixelen(end)*2/(rows*cols));
            fprintf('edge pixels length is %f, and it can embed binary length is %f.\n',pixelen(end),pixelen(end)*2);
            EMPicture = [];
        else
            Nedge_pixels = LSB2(edge_pixels,bit2matrix);
            EMPicture(bw==1) = Nedge_pixels;
        end
    end
end

%批量嵌入
function Npixels = LSB2(pixels,bit2s)
    Npixels = pixels;
    for k=1:length(bit2s)
        Npixels(k) = bitand(pixels(k),252) + 2*bit2s(1,k) + bit2s(2,k);
    end
end