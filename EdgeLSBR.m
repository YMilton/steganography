%��Ե����Ч��д��forѭ��ɨ��Ƕ��
function EMPictureMatrix = EdgeLSBR(BinaryList,PictureMatrix,N,method)
%N��ʾ��Ե���������滻�����Чλ��λ��
bits = {'11111110','11111100','11111000','11110000','11100000','11000000','10000000'};
B = BinaryList;
P = PictureMatrix;
[rows,cols]=size(P);
NP = P;
[~,~,bw] = getLastThreshold(bitand(P,bin2dec(bits{N})),method);
edgePixel = P(bw==1);
nonedgePixel = P(bw==0);
if length(B)>(length(edgePixel)*N+length(nonedgePixel))
    disp('error:');
    disp('The length of binary list is larger than picture matrix!');
else
    point = 1;%ָ��
    for k = 1:rows*cols
        if point>length(B)
            break;
        end
        if bw(k)==1 && point+N-1<=length(B)
            NP(k) = bitand(P(k),bin2dec(bits{N}))+bin2value(B(point:point+N-1));
            point=point+N;
        else
            NP(k) = bitand(P(k),254)+B(point);
            point=point+1;
        end
    end
end
EMPictureMatrix = NP;
end

function value = bin2value(bits)%����������תʮ����
    value = 0;
    nbits = flipud(bits);
    for k=1:length(nbits)
        value = value + nbits(k)*2^(k-1);
    end
end

