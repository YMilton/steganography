function psnr=PSNR(A,S)
%%% [psnr]=PSNR(A,S) ����ԭͼ�������ͼ��ķ�ֵ�����
%%% A                ԭͼ
%%% S                ����ͼ��
%%% psnr             ���ط�ֵ�����
[M,N]=size(A);
x_source=A;
x_temp1=double(S)-double(x_source);
x_temp2=x_temp1( : );
x_temp3=abs(x_temp2);
x_temp4=x_temp3'*x_temp3;
d_embed=x_temp4/(M*N);
SDR1=255*255/d_embed;
psnr=10*log10(SDR1);