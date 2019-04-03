function KL=KLDistance(A,S)
%����ԭͼ�������ͼ���K-L divergence
%[KL]=KLdivergence(NA,NS)
%NA                 ԭͼ��ֱ��ͼ
%NS                 ����ͼ��ֱ��ͼ
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