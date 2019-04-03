%%��Ƕ���������Ƕ��ϸ����
function Total = Standard_C(GrayMatrix,BinaryList)
BL = BinaryList;

%% �Ǵ���������������Ƕ�벿��
NGPLSBM = LSBM(BL,GrayMatrix);
NGPLSBR = LSBR(BL,GrayMatrix);
NGPO = OPAP(BL,GrayMatrix);
NGPE = EMD(BL,GrayMatrix,3,2);
% NGPMLSBM = MarkovLSBM(BL,GrayMatrix);
NGPDE1 = DE(BL,GrayMatrix,1);
NGPDE2 = DE(BL,GrayMatrix,2);

%% ����������������Ƕ�벿��
[~,reimg] = FunSplit(GrayMatrix);
positionO = find(reimg==1);%��ȡ������ֵΪ1��λ��
positionZ = find(reimg==0);%��ȡ������ֵΪ0��λ��
vector_One = GrayMatrix(positionO);
vector_Zero = GrayMatrix(positionZ);
if length(BL)<length(positionO)%������������ĳ���С�ڴ��������ص�
    BL_One = BL;
    BL_Zero = [];
else
    BL_One = BL(1:length(positionO)-1);
    BL_Zero = BL(length(positionO):end);
end
NGPAMGDE11 = GrayMatrix;
NGPAMGDE21 = GrayMatrix;
NGPAMGDE22 = GrayMatrix;

%������񻯵�ͼ��Ƕ�����ݵ�ͼƬ
%AMGDE11
nvector_One = DE(BL_One,vector_One,1);%����Ƕ��ĵ�Ϊ���������ص�
NGPAMGDE11(positionO) = nvector_One;
if ~isempty(BL_Zero)%��Ƕ�����������Ƕ��ϸ����
    nvector_Zero = DE(BL_Zero,vector_Zero,1);
    NGPAMGDE11(positionZ) = nvector_Zero;
end

%AMGDE21
nvector_One = DE(BL_One,vector_One,2);
NGPAMGDE21(positionO) = nvector_One;
if ~isempty(BL_Zero)
    nvector_Zero = DE(BL_Zero,vector_Zero,1);
    NGPAMGDE21(positionZ) = nvector_Zero;
end

%AMGDE22
nvector_One = DE(BL_One,vector_One,2);
NGPAMGDE22(positionO) = nvector_One;
if ~isempty(BL_Zero)
    nvector_Zero = DE(BL_Zero,vector_Zero,2);
    NGPAMGDE22(positionZ) = nvector_Zero;
end

% ��֪��ָ��ļ���
% Total(1,1) = PSNR(GrayMatrix,NGPLSBR);%LSBRǶ��
% 
% Total(2,1) = PSNR(GrayMatrix,NGPO);%OPAPǶ��
% 
% Total(3,1) = PSNR(GrayMatrix,NGPE);%EMD31Ƕ��

% Total(4,1) = PSNR(GrayMatrix,NGPDE1);%DE1Ƕ��
% 
% Total(5,1) = PSNR(GrayMatrix,NGPDE2);%DE2Ƕ��

% Total(4,1) = PSNR(GrayMatrix,NGPAMGDE11);%AMGDE11Ƕ��

% Total(4,1) = PSNR(GrayMatrix,NGPAMGDE21);%AMGDE21Ƕ��
% 
% Total(5,1) = PSNR(GrayMatrix,NGPAMGDE12);%AMGDE12Ƕ��

% Total(4,1) = PSNR(GrayMatrix,NGPAMGDE22);%AMGDE22Ƕ��

% Total = PSNR(GrayMatrix,NGPE);%EMD31Ƕ��

%% ��ȫ��ָ��ļ���
Total(1,1) = MCDistance(GrayMatrix,NGPLSBR);%LSBRǶ��

Total(2,1) = MCDistance(GrayMatrix,NGPLSBM);%LSBMǶ��

Total(3,1) = MCDistance(GrayMatrix,NGPO);%OPAPǶ��

Total(4,1) = MCDistance(GrayMatrix,NGPE);%EMD31Ƕ��

% Total(5,1) = MCDistance(GrayMatrix,NGPMLSBM);%MarkovLSBMǶ��

Total(6,1) = MCDistance(GrayMatrix,NGPDE1);%DE1Ƕ��

Total(7,1) = MCDistance(GrayMatrix,NGPDE2);%DE2Ƕ��

Total(8,1) = MCDistance(GrayMatrix,NGPAMGDE11);%AMGDE11Ƕ��

Total(9,1) = MCDistance(GrayMatrix,NGPAMGDE21);%AMGDE21Ƕ��

Total(10,1) = MCDistance(GrayMatrix,NGPAMGDE22);%AMGDE22Ƕ��

% Total(11,1) = MCDistance(GrayMatrix,NGPAMGDE12);%AMGDE12Ƕ��

% Total = MCDistance(GrayMatrix,NGPO);%OPAPǶ��

end


