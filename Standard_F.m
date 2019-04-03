%%��Ƕ��ϸ������Ƕ�������
function Total = Standard_F(GrayMatrix,BinaryList)
BL = BinaryList;

%% �Ǵ���������������Ƕ�벿��
NGPLSBM = LSBM(BL,GrayMatrix);
NGPLSBR = LSBR(BL,GrayMatrix);
NGPO = OPAP(BL,GrayMatrix);
NGPE = EMD(BL,GrayMatrix,3,2);
NGPMLSBM = MarkovLSBM(BL,GrayMatrix);
NGPDE1 = DE(BL,GrayMatrix,1);
NGPDE2 = DE(BL,GrayMatrix,2);

%% ����������������Ƕ�벿��
[~,reimg] = FunSplit(GrayMatrix);
positionO = find(reimg==1);%��ȡ������ֵΪ1��λ��,������
positionZ = find(reimg==0);%��ȡ������ֵΪ0��λ�ã�ϸ����
vector_One = GrayMatrix(positionO);
vector_Zero = GrayMatrix(positionZ);
if length(BL)<length(positionZ)%������������ĳ���С��ϸ�������ص�
    BL_Zero = BL;
    BL_One = [];
else
    BL_Zero = BL(1:length(positionZ)-1);
    BL_One = BL(length(positionZ):end);
end
NGPAMGDE11 = GrayMatrix;
NGPAMGDE21 = GrayMatrix;
NGPAMGDE22 = GrayMatrix;

%������񻯵�ͼ��Ƕ�����ݵ�ͼƬ
%AMGDE11
nvector_Zero = DE(BL_Zero,vector_Zero,1);%����Ƕ��ĵ�Ϊϸ�������ص�
NGPAMGDE11(positionZ) = nvector_Zero;
if ~isempty(BL_One)%��Ƕ�����������Ƕ��ϸ����
    nvector_One = DE(BL_One,vector_One,1);
    NGPAMGDE11(positionO) = nvector_One;
end

%AMGDE21
nvector_Zero = DE(BL_Zero,vector_Zero,1);
NGPAMGDE21(positionZ) = nvector_Zero;
if ~isempty(BL_One)
    nvector_One = DE(BL_One,vector_One,2);
    NGPAMGDE21(positionO) = nvector_One;
end

%AMGDE22
nvector_Zero = DE(BL_Zero,vector_Zero,2);
NGPAMGDE22(positionZ) = nvector_Zero;
if ~isempty(BL_One)
    nvector_One = DE(BL_One,vector_One,2);
    NGPAMGDE22(positionO) = nvector_One;
end


%% ��ȫ��ָ��ļ���
Total(1,1) = MCDistance(GrayMatrix,NGPLSBR);%LSBRǶ��

Total(2,1) = MCDistance(GrayMatrix,NGPLSBM);%LSBMǶ��

Total(3,1) = MCDistance(GrayMatrix,NGPO);%OPAPǶ��

Total(4,1) = MCDistance(GrayMatrix,NGPE);%EMD31Ƕ��

Total(5,1) = MCDistance(GrayMatrix,NGPMLSBM);%MarkovLSBMǶ��

Total(6,1) = MCDistance(GrayMatrix,NGPDE1);%DE1Ƕ��

Total(7,1) = MCDistance(GrayMatrix,NGPDE2);%DE2Ƕ��

Total(8,1) = MCDistance(GrayMatrix,NGPAMGDE11);%AMGDE11Ƕ��

Total(9,1) = MCDistance(GrayMatrix,NGPAMGDE21);%AMGDE21Ƕ��

Total(10,1) = MCDistance(GrayMatrix,NGPAMGDE22);%AMGDE22Ƕ��

% Total(11,1) = MCDistance(GrayMatrix,NGPAMGDE12);%AMGDE12Ƕ��

% Total = MCDistance(GrayMatrix,NGPO);%OPAPǶ��

end


