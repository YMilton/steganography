% Saiful Islam,Mangat R Modi and Phalguni Gupta, Edge-based image
% steganography,EURASIP Journal on Information Security 2014

%�Ǳ�Ե����ҲǶ����Ϣ
function EMPicture = Canny2LSB_C(BinaryList,Picture)
    %BinaryList��������Ϣ
    %Pictureͼ������ֵ
    EMPicture = Picture;
    if isempty(BinaryList)
        EMPicture = Picture;
    else
        L = floor(length(BinaryList)/2);
        I = bitand(Picture,252);
        [~,lens,bw] = getThreshold(I,L);
        edge_pixels = Picture(bw==1);%��Ե����ֵ
        non_edge_pixels = Picture(bw==0);%�Ǳ�Ե����ֵ
        
        %���ݱ�Ե����ֵ�������������Ϣ
        if L<=lens(end)
            edgebin = BinaryList(1:L*2);
            bit2matrix = reshape(edgebin,2,L);
            non_edgebin = BinaryList(L*2+1:end);
        else
            edgebin = BinaryList(1:length(edge_pixels)*2);
            bit2matrix = reshape(edgebin,2,length(edge_pixels));
            non_edgebin = BinaryList(length(edge_pixels)*2+1:end);
        end
        
        
        %��Ե���ֵ�Ƕ��
        Nedge_pixels = LSB2(edge_pixels,bit2matrix);
        EMPicture(bw==1) = Nedge_pixels;
        %�Ǳ�Ե��Ƕ��
        Nnon_edge_pixels = LSB1(non_edge_pixels,non_edgebin);
        EMPicture(bw==0) = Nnon_edge_pixels;
    end
end

%����bit��Ƕ�룬����Ƕ��
function Npixels = LSB2(pixels,bit2s)
    Npixels = pixels;
    for k=1:length(bit2s)
        Npixels(k) = bitand(pixels(k),252) + 2*bit2s(1,k) + bit2s(2,k);
    end
end

%һ��bit��Ƕ��
function Npixels = LSB1(pixels,bit1s)
    Npixels = pixels;
    for k=1:length(bit1s)
        Npixels(k) = bitand(pixels(k),254) + bit1s(k);
    end
end