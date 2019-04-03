%%先嵌入粗网格，再嵌入细网格
function Total = Standard_C(GrayMatrix,BinaryList)
BL = BinaryList;

%% 非代数多重网格网格化嵌入部分
NGPLSBM = LSBM(BL,GrayMatrix);
NGPLSBR = LSBR(BL,GrayMatrix);
NGPO = OPAP(BL,GrayMatrix);
NGPE = EMD(BL,GrayMatrix,3,2);
% NGPMLSBM = MarkovLSBM(BL,GrayMatrix);
NGPDE1 = DE(BL,GrayMatrix,1);
NGPDE2 = DE(BL,GrayMatrix,2);

%% 代数多重网格网格化嵌入部分
[~,reimg] = FunSplit(GrayMatrix);
positionO = find(reimg==1);%获取网格中值为1的位置
positionZ = find(reimg==0);%获取网格中值为0的位置
vector_One = GrayMatrix(positionO);
vector_Zero = GrayMatrix(positionZ);
if length(BL)<length(positionO)%如果二进制流的长度小于粗网格像素点
    BL_One = BL;
    BL_Zero = [];
else
    BL_One = BL(1:length(positionO)-1);
    BL_Zero = BL(length(positionO):end);
end
NGPAMGDE11 = GrayMatrix;
NGPAMGDE21 = GrayMatrix;
NGPAMGDE22 = GrayMatrix;

%获得网格化的图像嵌入数据的图片
%AMGDE11
nvector_One = DE(BL_One,vector_One,1);%首先嵌入的点为粗网格橡素点
NGPAMGDE11(positionO) = nvector_One;
if ~isempty(BL_Zero)%当嵌入完粗网格在嵌入细网格
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

% 感知度指标的计算
% Total(1,1) = PSNR(GrayMatrix,NGPLSBR);%LSBR嵌入
% 
% Total(2,1) = PSNR(GrayMatrix,NGPO);%OPAP嵌入
% 
% Total(3,1) = PSNR(GrayMatrix,NGPE);%EMD31嵌入

% Total(4,1) = PSNR(GrayMatrix,NGPDE1);%DE1嵌入
% 
% Total(5,1) = PSNR(GrayMatrix,NGPDE2);%DE2嵌入

% Total(4,1) = PSNR(GrayMatrix,NGPAMGDE11);%AMGDE11嵌入

% Total(4,1) = PSNR(GrayMatrix,NGPAMGDE21);%AMGDE21嵌入
% 
% Total(5,1) = PSNR(GrayMatrix,NGPAMGDE12);%AMGDE12嵌入

% Total(4,1) = PSNR(GrayMatrix,NGPAMGDE22);%AMGDE22嵌入

% Total = PSNR(GrayMatrix,NGPE);%EMD31嵌入

%% 安全性指标的计算
Total(1,1) = MCDistance(GrayMatrix,NGPLSBR);%LSBR嵌入

Total(2,1) = MCDistance(GrayMatrix,NGPLSBM);%LSBM嵌入

Total(3,1) = MCDistance(GrayMatrix,NGPO);%OPAP嵌入

Total(4,1) = MCDistance(GrayMatrix,NGPE);%EMD31嵌入

% Total(5,1) = MCDistance(GrayMatrix,NGPMLSBM);%MarkovLSBM嵌入

Total(6,1) = MCDistance(GrayMatrix,NGPDE1);%DE1嵌入

Total(7,1) = MCDistance(GrayMatrix,NGPDE2);%DE2嵌入

Total(8,1) = MCDistance(GrayMatrix,NGPAMGDE11);%AMGDE11嵌入

Total(9,1) = MCDistance(GrayMatrix,NGPAMGDE21);%AMGDE21嵌入

Total(10,1) = MCDistance(GrayMatrix,NGPAMGDE22);%AMGDE22嵌入

% Total(11,1) = MCDistance(GrayMatrix,NGPAMGDE12);%AMGDE12嵌入

% Total = MCDistance(GrayMatrix,NGPO);%OPAP嵌入

end


