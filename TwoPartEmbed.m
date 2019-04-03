function embed_matrix = TwoPartEmbed(GrayMatrix,BL,BinaryMatrix)
    embed_matrix = GrayMatrix;
    positionO = find(BinaryMatrix==1);%获取网格中值为1的位置
    positionZ = find(BinaryMatrix==0);%获取网格中值为0的位置
    vector_One = GrayMatrix(positionO);
    vector_Zero = GrayMatrix(positionZ);
    
    %保证首先嵌入边缘检测为0的像素值
    if length(BL)<length(positionZ)%如果二进制流的长度小于为0的像素点
        BL_Zero = BL;
        BL_One = [];
    else
        BL_Zero = BL(1:length(positionZ));
        BL_One = BL(length(positionZ)+1:end);
    end
    
    nvector_Zero = DE(BL_Zero,vector_Zero,2);%首先嵌入的点为边缘检测是0的像素点
    embed_matrix(positionZ) = nvector_Zero;
    if ~isempty(BL_One)%当嵌入完边缘检测为0的像素点再嵌入为1的像素点
        nvector_One = DE(BL_One,vector_One,1);
        embed_matrix(positionO) = nvector_One;
    end
end