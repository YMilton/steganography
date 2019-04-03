%Ëæ»úLSBÆ¥ÅäËã·¨
function EMPictureMatrix = LSBM(BinaryList,PictureMatrix)
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
result = im;
if(mod(im,2)~=bin)
    if(im==255)
        result = im - 1;
    end
    if(im==0)
        result = im + 1;
    end
    if(im>0&&im<255)
        if(randi([0,1],1)==1)
            result = im - 1;
        else
            result = im + 1;
        end
    end
end
end