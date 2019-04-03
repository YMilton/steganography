function embed_matrix = TwoPartEmbed(GrayMatrix,BL,BinaryMatrix)
    embed_matrix = GrayMatrix;
    positionO = find(BinaryMatrix==1);%��ȡ������ֵΪ1��λ��
    positionZ = find(BinaryMatrix==0);%��ȡ������ֵΪ0��λ��
    vector_One = GrayMatrix(positionO);
    vector_Zero = GrayMatrix(positionZ);
    
    %��֤����Ƕ���Ե���Ϊ0������ֵ
    if length(BL)<length(positionZ)%������������ĳ���С��Ϊ0�����ص�
        BL_Zero = BL;
        BL_One = [];
    else
        BL_Zero = BL(1:length(positionZ));
        BL_One = BL(length(positionZ)+1:end);
    end
    
    nvector_Zero = DE(BL_Zero,vector_Zero,2);%����Ƕ��ĵ�Ϊ��Ե�����0�����ص�
    embed_matrix(positionZ) = nvector_Zero;
    if ~isempty(BL_One)%��Ƕ�����Ե���Ϊ0�����ص���Ƕ��Ϊ1�����ص�
        nvector_One = DE(BL_One,vector_One,1);
        embed_matrix(positionO) = nvector_One;
    end
end