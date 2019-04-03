%% �����������������ص�����Ĵ���
function EMPicture = EMD(BinaryList,Picture,Ary,digit)
%Ary���������,digit����ת����λ��
[~,col] = size(Picture);
if col==1
    P = Picture;
else
    P = Picture(:);
end
B = BinaryList;
n = (Ary-1)/2;%Ƕ��һ��Ary��������Ҫ�����ص����
sliced_cell = cutbin(B,Ary,digit);
[row,col] = size(Picture);
Num = floor(row*col/n);
if length(sliced_cell)*digit>(row*col)/n
    disp('The length of binary list is larger than picture matrix!');
else
    V = P(1:Num*n);
    NP = reshape(V,n,Num);%����������
    for k = 1:length(sliced_cell)
        s = BNS(sliced_cell{k},Ary);
        for t = 1:length(s)
            NP(:,k*t) = EMD_nPixel(NP(:,k*t),s(t),Ary);
        end
    end
    NNP = NP(:);
    if mod(row*col,n)==0 
        EMPicture = reshape(NNP,row,col);
    else
        r = mod(row*col,n);
        NP = [NNP;P(end-r+1:end)]; 
        EMPicture = reshape(NP,row,col);
    end
end

end

%% EMDǶ���㷨�ĺ��Ĳ���
function NnPixel = EMD_nPixel(nPixel,s,Ary)
p = double(nPixel);
x = 1:length(p);
f = mod(sum(x'.*p),Ary);
d = mod(s - f,Ary);
if d<=(Ary-1)/2&&d>0
    p(d) = p(d) + 1;
elseif d>(Ary-1)/2
    p(Ary-d) = p(Ary-d) - 1;
end
NnPixel = p;
end

%% �����Ƶ���Ƭ������Ϊr
function output = cutbin(binvec,Ary,digit)
%Ary������ƣ�digit����n���Ƶ�λ��
r = floor(digit*log2(Ary));
Len = length(binvec);
Num = ceil(Len/r);
sliced_cell = cell(1,Num);
for k = 1:Num
    if k*r>Len
        sliced_cell{k} = binvec(k*r-r+1:end);
    else
        sliced_cell{k} = binvec(k*r-r+1:k*r);
    end
end
output = sliced_cell;
end

%% ��������n���Ƶ�ת��
function output=BNS(Bin,Ary)
%Bin�����������Ƭ��n�������
strb = num2str(Bin);
digit = ceil(length(Bin)/log2(Ary));%ת�����Ƶ�λ��
dec = bin2dec(strb);
k=1;
while(1)
    d = floor(dec/Ary);
    r_box(k) = dec - d*Ary;
    dec = d;
    k = k+1;
    if d==0
        break;
    end
end
result = fliplr(r_box);
L = length(result);
if L<digit
    output = [zeros(1,digit-L),result];
else
    output = result;
end
end