
function EMPictureVector = OPAP(BinaryList,PictureVector) 
P = PictureVector;
NP = P;
B = BinaryList;
sliced_cell = cutbin(B,2);
[col,row] = size(P);
if length(sliced_cell)>col*row
    disp('The length of binary list is larger than picture matrix!');
else
    for k = 1:length(sliced_cell)
        NP(k) = OPAP_Dot(P(k),sliced_cell{k});
    end
end
EMPictureVector = NP;
end

%Optimal Pixel Adjustment Process(OPAP)
%Pixel is the original pixel
function MPixel = OPAP_Dot(Pixel,Sliced_Bin)
r = length(Sliced_Bin);
s_bin = num2str(Sliced_Bin);
s = bin2dec(s_bin);
p_bin = dec2bin(Pixel,8);
v_bin = [p_bin(1:length(p_bin)-r),s_bin];%Embeded binary
v = bin2dec(v_bin);
vr_bin = p_bin(length(p_bin)-r+1:end);
vr = bin2dec(vr_bin);

if (vr-s>2^(r-1))&&(v+2^r<=255)
    MPixel = v+2^r;
elseif (vr-s<-2^(r-1))&&(v-2^r>=0)
    MPixel = v-2^r;
else
    MPixel = v;
end
end

%二进制的切片
function output = cutbin(binvec,r)
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

