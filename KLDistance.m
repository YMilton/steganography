function KL=KLDistance(A,S)
%计算原图像和载密图像的K-L divergence
%[KL]=KLdivergence(NA,NS)
%NA                 原图像直方图
%NS                 载密图像直方图
%KL                 the K-L divergence

A_hist=A(:);
edges=0:1:255;
NA=histc(A_hist,edges);
B_hist=S(:);
NS=histc(B_hist,edges);

k = length(NA);
NAR=NA/length(A_hist);
NSR=NS/length(B_hist);
KL=0;
for i=1:k
    if NAR(i)~=0
        if NSR(i)~=0
            KL = KL+NAR(i)*log2(NAR(i)/NSR(i));
        else
            KL = KL+5e-5;
        end
    else
        KL = KL+0;
    end
end
end