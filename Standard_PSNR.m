
function Total = Standard_PSNR(GrayMatrix,BinaryList)
BL = BinaryList;

%% �Ǵ���������������Ƕ�벿��
NGPLSBR = LSBR(BL,GrayMatrix);
NGPLSBM = LSBM(BL,GrayMatrix);
% NGPO = OPAP(BL,GrayMatrix);
% NGPE = EMD(BL,GrayMatrix,3,1);
% NGPMLSBM = MarkovLSBM(BL,GrayMatrix);
NGPDE1 = DE(BL,GrayMatrix,1);
NGPDE2 = DE(BL,GrayMatrix,2);
NGPCanny2LSB = Canny2LSB_C(BL,GrayMatrix);

%% ����������������Ƕ�벿��
[~,reimg] = FunSplit1(GrayMatrix);%�������������һ��
positionO = find(reimg==1);%��ȡ������ֵΪ1��λ��
positionZ = find(reimg==0);%��ȡ������ֵΪ0��λ��
vector_One = GrayMatrix(positionO);
vector_Zero = GrayMatrix(positionZ);
BL_One = BL(length(positionZ):end);
BL_Zero = BL(1:length(positionZ)-1);
NGPAMGDE11 = GrayMatrix;
NGPAMGDE21 = GrayMatrix;
% NGPAMGDE12 = GrayMatrix;
NGPAMGDE22 = GrayMatrix;

%������񻯵�ͼ��Ƕ�����ݵ�ͼƬ,��Ƕ��ϸ����
nvector_Zero = DE(BL_Zero,vector_Zero,1);
NGPAMGDE11(positionZ) = nvector_Zero;
nvector_One = DE(BL_One,vector_One,1);
NGPAMGDE11(positionO) = nvector_One;


nvector_Zero = DE(BL_Zero,vector_Zero,1);
NGPAMGDE21(positionZ) = nvector_Zero;
nvector_One = DE(BL_One,vector_One,2);
NGPAMGDE21(positionO) = nvector_One;


% nvector_Zero = DE(BL_Zero,vector_Zero,2);
% NGPAMGDE12(positionZ) = nvector_Zero;
% nvector_One = DE(BL_One,vector_One,1);
% NGPAMGDE12(positionO) = nvector_One;


nvector_Zero = DE(BL_Zero,vector_Zero,2);
NGPAMGDE22(positionZ) = nvector_Zero;
nvector_One = DE(BL_One,vector_One,2);
NGPAMGDE22(positionO) = nvector_One;

% ��֪��ָ��ļ���
Total(1,1) = ssim(GrayMatrix,NGPLSBR);%LSBRǶ��

Total(2,1) = ssim(GrayMatrix,NGPLSBM);%LSBMǶ��

% Total(3,1) = ssim(GrayMatrix,NGPO);%OPAPǶ��

% Total(4,1) = ssim(GrayMatrix,NGPE);%EMD31Ƕ��

Total(5,1) = ssim(GrayMatrix,NGPDE1);%DE1Ƕ��

Total(6,1) = ssim(GrayMatrix,NGPDE2);%DE2Ƕ��

Total(7,1) = ssim(GrayMatrix,NGPCanny2LSB);%Canny2LSBǶ��

Total(8,1) = ssim(GrayMatrix,NGPAMGDE11);%AMGDE11Ƕ��

Total(9,1) = ssim(GrayMatrix,NGPAMGDE21);%AMGDE21Ƕ��

% Total(10,1) = ssim(GrayMatrix,NGPAMGDE12);%AMGDE12Ƕ��

Total(11,1) = ssim(GrayMatrix,NGPAMGDE22);%AMGDE22Ƕ��


end

