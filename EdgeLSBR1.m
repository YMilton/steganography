%��Ե����Ч��д���ֿ�Ƕ��
function EMPicture = EdgeLSBR1(BinaryList,Picture,N,method)
    %N��ʾ��Ե���������滻�����Чλ��λ��
    %BinaryList��������Ϣ
    %Pictureͼ������ֵ
    bits = {'11111110','11111100','11111000','11110000','11100000','11000000','10000000'};
    EMPicture = Picture;
    if isempty(BinaryList)
        EMPicture = Picture;
    else
        I = bitand(Picture,bin2dec(bits{N}));
        [~,lens,bw] = getLastThreshold(I,method);
        edge_pixels = Picture(bw==1);%��Ե�������м�
        non_edge_pixels = Picture(bw==0);%�Ǳ�Ե�������м�
        
        L = floor(length(BinaryList)/N);
        
        %���ݱ�Ե����ֵ�������������Ϣ
        if L<=lens(end)%���������������ȫǶ���Ե��������
            edgebin = BinaryList(1:L*N);
            bit2matrix = reshape(edgebin,N,L);
            non_edgebin = BinaryList(L*N+1:end);
        else
            edgebin = BinaryList(1:length(edge_pixels)*N);
            bit2matrix = reshape(edgebin,N,length(edge_pixels));
            non_edgebin = BinaryList(length(edge_pixels)*N+1:end);
        end
        
        
        %��Ե���ֵ�Ƕ��
        Nedge_pixels = LSB_N(edge_pixels,bit2matrix,bin2dec(bits{N}));
        EMPicture(bw==1) = Nedge_pixels;
        %�Ǳ�Ե��Ƕ��
        Nnon_edge_pixels = LSB1(non_edge_pixels,non_edgebin);
        EMPicture(bw==0) = Nnon_edge_pixels;
    end
end

%����bit��Ƕ�룬����Ƕ��
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

%һ��bit��Ƕ��
function Npixels = LSB1(pixels,bit1s)
    Npixels = pixels;
    for k=1:length(bit1s)
        Npixels(k) = bitand(pixels(k),254) + bit1s(k);
    end
end