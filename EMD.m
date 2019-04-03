%% 二进制流数组与像素点数组的传入
function EMPicture = EMD(BinaryList,Picture,Ary,digit)
%Ary代表进制数,digit进制转化的位数
[~,col] = size(Picture);
if col==1
    P = Picture;
else
    P = Picture(:);
end
B = BinaryList;
n = (Ary-1)/2;%嵌入一个Ary进制数需要的像素点个数
sliced_cell = cutbin(B,Ary,digit);
[row,col] = size(Picture);
Num = floor(row*col/n);
if length(sliced_cell)*digit>(row*col)/n
    disp('The length of binary list is larger than picture matrix!');
else
    V = P(1:Num*n);
    NP = reshape(V,n,Num);%构成像素组
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

%% EMD嵌入算法的核心部分
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

%% 二进制的切片，长度为r
function output = cutbin(binvec,Ary,digit)
%Ary代表进制，digit代表n进制的位数
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

%% 二进制向n进制的转换
function output=BNS(Bin,Ary)
%Bin代表二进制切片，n代表进制
strb = num2str(Bin);
digit = ceil(length(Bin)/log2(Ary));%转换进制的位数
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