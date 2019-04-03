
function Total = Standard_PSNR(GrayMatrix,BinaryList)
BL = BinaryList;

%% 非代数多重网格网格化嵌入部分
NGPLSBR = LSBR(BL,GrayMatrix);
NGPLSBM = LSBM(BL,GrayMatrix);
% NGPO = OPAP(BL,GrayMatrix);
% NGPE = EMD(BL,GrayMatrix,3,1);
% NGPMLSBM = MarkovLSBM(BL,GrayMatrix);
NGPDE1 = DE(BL,GrayMatrix,1);
NGPDE2 = DE(BL,GrayMatrix,2);
NGPCanny2LSB = Canny2LSB_C(BL,GrayMatrix);

%% 代数多重网格网格化嵌入部分
[~,reimg] = FunSplit1(GrayMatrix);%代数多重网格第一层
positionO = find(reimg==1);%获取网格中值为1的位置
positionZ = find(reimg==0);%获取网格中值为0的位置
vector_One = GrayMatrix(positionO);
vector_Zero = GrayMatrix(positionZ);
BL_One = BL(length(positionZ):end);
BL_Zero = BL(1:length(positionZ)-1);
NGPAMGDE11 = GrayMatrix;
NGPAMGDE21 = GrayMatrix;
% NGPAMGDE12 = GrayMatrix;
NGPAMGDE22 = GrayMatrix;

%获得网格化的图像嵌入数据的图片,先嵌入细网格
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

% 感知度指标的计算
Total(1,1) = ssim(GrayMatrix,NGPLSBR);%LSBR嵌入

Total(2,1) = ssim(GrayMatrix,NGPLSBM);%LSBM嵌入

% Total(3,1) = ssim(GrayMatrix,NGPO);%OPAP嵌入

% Total(4,1) = ssim(GrayMatrix,NGPE);%EMD31嵌入

Total(5,1) = ssim(GrayMatrix,NGPDE1);%DE1嵌入

Total(6,1) = ssim(GrayMatrix,NGPDE2);%DE2嵌入

Total(7,1) = ssim(GrayMatrix,NGPCanny2LSB);%Canny2LSB嵌入

Total(8,1) = ssim(GrayMatrix,NGPAMGDE11);%AMGDE11嵌入

Total(9,1) = ssim(GrayMatrix,NGPAMGDE21);%AMGDE21嵌入

% Total(10,1) = ssim(GrayMatrix,NGPAMGDE12);%AMGDE12嵌入

Total(11,1) = ssim(GrayMatrix,NGPAMGDE22);%AMGDE22嵌入


end

