%% �����������������ص�����Ĵ���
function EMPicture = DE_H(BinaryList,Picture,K)
[row,col] = size(Picture);
if col==1
    P = double(Picture);
else
    P = double(Picture(:));
end
B = BinaryList;
Ary = 2*K^2+2*K+1;%Ary���������
sliced_cell = cutbin(B,Ary,2);

Num = floor(row*col/2);
if length(sliced_cell)>Num
    disp('The length of binary list is larger than picture matrix!');
else
    V = P(1:Num*2);
    NP = reshape(V,2,Num);%����������
    for k = 1:length(sliced_cell)
        s = bin2bns(sliced_cell{k},Ary);
        for t = 1:length(s)
            NP(:,k*t) = DE_P(NP(:,k*t),s(t),K);
        end
    end
    NNP = NP(:);
    if mod(row*col,2)==0 
        EMPicture = reshape(NNP,row,col);
    else
        r = mod(row*col,2);
        NP = [NNP;P(end-r+1:end)]; 
        EMPicture = reshape(NP,row,col);
    end
end
EMPicture = uint8(EMPicture);
end

%% ��ʯ������Ĳ���
function NPPixel = DE_P(PPixel,s,k)
hP = bitand(PPixel,240);
lP = PPixel - hP;
D1 = {[0,0];[0,1];[-1,0];[1,0];[0,-1]};
D2 = {[0,0];[0,1];[0,2];
      [-2,0];[1,-1];[1,0];[1,1];
      [-1,-1];[-1,0];[-1,1];[2,0];
      [0,-2];[0,-1]};
D3 = {[0,0];[0,1];[0,2];[0,3];
      [-3,0];[1,-2];[1,-1];[1,0];[1,1];[1,2];
      [-2,-1];[-2,0];[-2,1];[2,-1];[2,0];[2,1];
      [-1,-2];[-1,-1];[-1,0];[-1,1];[-1,2];[3,0];
      [0,-3];[0,-2];[0,-1]};
D4 = {[0,0];[0,1];[0,2];[0,3];[0,4];
      [-4,0];[1,-3];[1,-2];[1,-1];[1,0];[1,1];[1,2];[1,3];
      [-3,-1];[-3,0];[-3,1];[2,-2];[2,-1];[2,0];[2,1];[2,2];
      [-2,-2];[-2,-1];[-2,0];[-2,1];[-2,2];[3,-1];[3,0];[3,1];
      [-1,-3];[-1,-2];[-1,-1];[-1,0];[-1,1];[-1,2];[-1,3];[4,0];
      [0,-4];[0,-3];[0,-2];[0,-1]};
D5 = {[0,0];[0,1];[0,2];[0,3];[0,4];[0,5];
      [-5,0];[1,-4];[1,-3];[1,-2];[1,-1];[1,0];[1,1];[1,2];[1,3];[1,4];
      [-4,-1];[-4,0];[-4,1];[2,-3];[2,-2];[2,-1];[2,0];[2,1];[2,2];[2,3];
      [-3,-2];[-3,-1];[-3,0];[-3,1];[-3,2];[3,-2];[3,-1];[3,0];[3,1];[3,2];
      [-2,-3];[-2,-2];[-2,-1];[-2,0];[-2,1];[-2,2];[-2,3];[4,-1];[4,0];[4,1];
      [-1,-4];[-1,-3];[-1,-2];[-1,-1];[-1,0];[-1,1];[-1,2];[-1,3];[-1,4];[5,0];
      [0,-5];[0,-4];[0,-3];[0,-2];[0,-1]};

L = 2*k^2+2*k+1;
x = lP(1);
y = lP(2);
f = mod((2*k+1)*x+y,L);
d = mod(s-f,L);
switch(k)
    case 1
        NPP = lP+D1{d+1}';
    case 2
        NPP = lP+D2{d+1}';
    case 3
        NPP = lP+D3{d+1}';
    case 4
        NPP = lP+D4{d+1}';
    case 5
        NPP = lP+D5{d+1}';
end
if NPP(1)>15
    NPP(1)=NPP(1)-L;
end
if NPP(1)<0
    NPP(1)=NPP(1)+L;
end
if NPP(2)>15
    NPP(2)=NPP(2)-L;
end
if NPP(2)<0
    NPP(2)=NPP(2)+L;
end
NPPixel = NPP + hP;
end

%% �����Ƶ���Ƭ������Ϊr
function output = cutbin(binvec,Ary,digit)
%Ary������ƣ�digit����n���Ƶ�λ��
r = floor(digit*log2(Ary));%Ary��������Ҫ�Ķ�����λ��
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
function output=bin2bns(Bin,Ary)
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