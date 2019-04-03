function Distance=MCDistance(A,B)%[Distance,DDD]=MC_Distance_Optimal(M_A,M_B,Stand)
%Calculate the distance of tow Markov Chains
%Distance=MC_Distance_Optimal(M_A,M_B,Stand)
%A         the cover image matrix
%B         the secret image matrix
%Distance  the distance of tow Markov Chain of the image matrix
%A and B have the same row and column

%Calculate the distance
%DDD=0;
M_A = Markov(A);
M_B = Markov(B);
Distance=0;
for i=1:256
    for j=1:256
        if M_A(i,j)~=0
            if M_B(i,j)~=0
                Distance=Distance+M_A(i,j)*log10((M_A(i,j)/sum(M_A(i,:)))*(sum(M_B(i,:))/M_B(i,j)));
            else
                Distance=Distance+5e-8;
            end
        else
            Distance = Distance+0;
        end
    end
end
Distance=abs(Distance);
end


function [M_A]=Markov(A)
%Markov calculate Markov Chain and its experience
%[A_MC,M_A]=Markov(A)
%A     the image matrix
%A_MC  the Markov Chain of the image matrix
%M_A   the experience of the Markov Chain

[m,n]=size(A);
%按列扫描排列成Markov Chain
A_MC=[];
for k=1:n
    if mod(k,2)~=0 %若为偶数列则从下往上扫描
        A_MC=[A_MC;A(:,k)];
    else
        A_MC=[A_MC;flipud(A(:,k))];
    end
end

%计算经验矩阵 Empirical Matrix
M_A=zeros(256,256);
for k=1:m*n-1
    M_A(A_MC(k+1)+1,A_MC(k)+1)=M_A(A_MC(k+1)+1,A_MC(k)+1)+1;
end
M_A=M_A/(m*n-1);

end
