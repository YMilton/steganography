%%先嵌入细网格，再嵌入粗网格
function Total = Standard_F(GrayMatrix,BinaryList)
BL = BinaryList;

%% 非代数多重网格网格化嵌入部分
NGPLSBM = LSBM(BL,GrayMatrix);
NGPLSBR = LSBR(BL,GrayMatrix);
NGPO = OPAP(BL,GrayMatrix);
NGPE = EMD(BL,GrayMatrix,3,2);
NGPMLSBM = MarkovLSBM(BL,GrayMatrix);
NGPDE1 = DE(BL,GrayMatrix,1);
NGPDE2 = DE(BL,GrayMatrix,2);

%% 代数多重网格网格化嵌入部分
[~,reimg] = FunSplit(GrayMatrix);
positionO = find(reimg==1);%获取网格中值为1的位置,粗网格
positionZ = find(reimg==0);%获取网格中值为0的位置，细网格
vector_One = GrayMatrix(positionO);
vector_Zero = GrayMatrix(positionZ);
if length(BL)<length(positionZ)%如果二进制流的长度小于细网格像素点
    BL_Zero = BL;
    BL_One = [];
else
    BL_Zero = BL(1:length(positionZ)-1);
    BL_One = BL(length(positionZ):end);
end
NGPAMGDE11 = GrayMatrix;
NGPAMGDE21 = GrayMatrix;
NGPAMGDE22 = GrayMatrix;

%获得网格化的图像嵌入数据的图片
%AMGDE11
nvector_Zero = DE(BL_Zero,vector_Zero,1);%首先嵌入的点为细网格橡素点
NGPAMGDE11(positionZ) = nvector_Zero;
if ~isempty(BL_One)%当嵌入完粗网格在嵌入细网格
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


%% 安全性指标的计算
Total(1,1) = MCDistance(GrayMatrix,NGPLSBR);%LSBR嵌入

Total(2,1) = MCDistance(GrayMatrix,NGPLSBM);%LSBM嵌入

Total(3,1) = MCDistance(GrayMatrix,NGPO);%OPAP嵌入

Total(4,1) = MCDistance(GrayMatrix,NGPE);%EMD31嵌入

Total(5,1) = MCDistance(GrayMatrix,NGPMLSBM);%MarkovLSBM嵌入

Total(6,1) = MCDistance(GrayMatrix,NGPDE1);%DE1嵌入

Total(7,1) = MCDistance(GrayMatrix,NGPDE2);%DE2嵌入

Total(8,1) = MCDistance(GrayMatrix,NGPAMGDE11);%AMGDE11嵌入

Total(9,1) = MCDistance(GrayMatrix,NGPAMGDE21);%AMGDE21嵌入

Total(10,1) = MCDistance(GrayMatrix,NGPAMGDE22);%AMGDE22嵌入

% Total(11,1) = MCDistance(GrayMatrix,NGPAMGDE12);%AMGDE12嵌入

% Total = MCDistance(GrayMatrix,NGPO);%OPAP嵌入

end


