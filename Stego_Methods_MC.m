function MC = Stego_Methods_MC(Gray,BL)

GLSBM = LSBM(BL,Gray);
GLSBR = LSBR(BL,Gray);

GDE1 = DE(BL,Gray,1);
GDE2 = DE(BL,Gray,2);

GCanny2LSB = Canny2LSB_C(BL,Gray);

% ����������������Ƕ�벿��
[~,reimg] = FunSplit1(Gray);
positionO = find(reimg==1);%��ȡ������ֵΪ1��λ�� ������
positionZ = find(reimg==0);%��ȡ������ֵΪ0��λ�� ϸ����
vector1 = Gray(positionO);
vector2 = Gray(positionZ);
if length(BL)<length(positionO)%�ж�С�ڴ��������ص�,�Ա�ֿ�������Ϣ
    BL1 = BL;
    BL2 = [];
else
    BL1 = BL(1:length(positionO)-1);
    BL2 = BL(length(positionO):end);
end
GAMGDE11 = Gray;
GAMGDE21 = Gray;
GAMGDE22 = Gray;

%������񻯵�ͼ��Ƕ�����ݵ�ͼƬ
nvector1 = DE(BL1,vector1,1);%������
GAMGDE11(positionO) = nvector1;
if ~isempty(BL2)
    nvector2 = DE(BL2,vector2,1);%ϸ����
    GAMGDE11(positionZ) = nvector2;
end

nvector1 = DE(BL1,vector1,2);
GAMGDE21(positionO) = nvector1;
if ~isempty(BL2)
    nvector2 = DE(BL2,vector2,1);
    GAMGDE21(positionZ) = nvector2;
end

nvector1 = DE(BL1,vector1,2);
GAMGDE22(positionO) = nvector1;
if ~isempty(BL2)
    nvector2 = DE(BL2,vector2,2);
    GAMGDE22(positionZ) = nvector2;
end

MC(1,1) = MCDistance(Gray,GLSBR);
MC(2,1) = MCDistance(Gray,GLSBM);
MC(3,1) = MCDistance(Gray,GDE1);
MC(4,1) = MCDistance(Gray,GDE2);
MC(5,1) = MCDistance(Gray,GAMGDE11);
MC(6,1) = MCDistance(Gray,GAMGDE21);
MC(7,1) = MCDistance(Gray,GAMGDE22);
MC(8,1) = MCDistance(Gray,GCanny2LSB);
end