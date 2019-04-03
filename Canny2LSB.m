% Saiful Islam,Mangat R Modi and Phalguni Gupta, Edge-based image
% steganography,EURASIP Journal on Information Security 2014

function EMPicture = Canny2LSB(BinaryList,Picture)
    %BinaryList��������Ϣ
    %Pictureͼ������ֵ
    EMPicture = Picture;
    if isempty(BinaryList)
        EMPicture = Picture;
    else
        binL = length(BinaryList);
        if mod(binL,2)==1
            BinaryList = [BinaryList,0];
        end
        bit2matrix = reshape(BinaryList,2,length(BinaryList)/2);%��Ƕ��Ķ�������Ϣ
        
        L = length(BinaryList)/2;
        I = bitand(Picture,252);
        [~,pixelen,bw] = getThreshold(I,L);
        edge_pixels = Picture(bw==1);%��Ե����ֵ
        
        %����Ƕ��
        if pixelen(end)<length(bit2matrix)%��Ե����С�ڶ����ƾ���ĳ���
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

%����Ƕ��
function Npixels = LSB2(pixels,bit2s)
    Npixels = pixels;
    for k=1:length(bit2s)
        Npixels(k) = bitand(pixels(k),252) + 2*bit2s(1,k) + bit2s(2,k);
    end
end