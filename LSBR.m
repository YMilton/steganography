%LSB置换算法
function EMPictureMatrix = LSBR(BinaryList,PictureMatrix)
B = BinaryList;
P = PictureMatrix;
NP = P;
[col,row] = size(PictureMatrix);
if length(B)>col*row
    disp('error:');
    disp('The length of binary list is larger than picture matrix!');
else
    for k = 1:length(B)
        NP(k) = Embedder(P(k),B(k));
    end
end
EMPictureMatrix = NP;
end


function result = Embedder(im,bin)
if(mod(im,2)==bin)
    nim = im;
else
    if mod(im,2)==1
        nim = im-1;
    else
        nim = im+1;
    end
end
result = nim;
end



% function EMPictureMatrix = LSBR(BinaryList,PictureMatrix)
% P = PictureMatrix;
% NP = P;
% B = BinaryList;
% sliced_cell = cutbin(B,2);
% [col,row] = size(P);
% if length(sliced_cell)>col*row
%     disp('The length of binary list is larger than picture matrix!');
% else
%     for k = 1:length(sliced_cell)
%         NP(k) = OPAP_Dot(P(k),sliced_cell{k});
%     end
% end
% EMPictureMatrix = NP;
% end
% 
% %Optimal Pixel Adjustment Process(OPAP)
% %Pixel is the original pixel
% function MPixel = OPAP_Dot(Pixel,Sliced_Bin)
% r = length(Sliced_Bin);
% s_bin = num2str(Sliced_Bin);
% s = bin2dec(s_bin);
% p_bin = dec2bin(Pixel,8);
% v_bin = [p_bin(1:length(p_bin)-r),s_bin];%Embeded binary
% MPixel = bin2dec(v_bin);
% end
% 
% %二进制的切片
% function output = cutbin(binvec,r)
% Len = length(binvec);
% Num = ceil(Len/r);
% sliced_cell = cell(1,Num);
% for k = 1:Num
%     if k*r>Len
%         sliced_cell{k} = binvec(k*r-r+1:end);
%     else
%         sliced_cell{k} = binvec(k*r-r+1:k*r);
%     end
% end
% output = sliced_cell;
% end



