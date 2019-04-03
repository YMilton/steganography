
%%����bows2��4000��ͼƬ��һ����б�Ե����DEǶ�룬�ٻ�ȡSPAM��������ȡ
function getFeatures(percent,method)
    file_path =  '.\jpgbows2-1g\';% ͼ���ļ���·��
    imgjpg = dir(fullfile(fullfile(file_path),'*.jpg'));%��ȡ���ļ���������jpg��ʽ��ͼ��
    imgbmp = dir(fullfile(fullfile(file_path),'*.bmp'));
    imgtif = dir(fullfile(fullfile(file_path),'*.tif'));
    filenames1 = {imgjpg.name}';
    filenames2 = {imgbmp.name}';
    filenames3 = {imgtif.name}';
    filename = [filenames1;filenames2;filenames3];
    
    t1 = clock;
    fname = randperm(length(filename),floor(length(filename)/2));
    for k = 1:length(filename)
        disp(k)
        P = imread(strcat(file_path,filename{k}));
        if length(size(P))==3
            GP = rgb2gray(P);
        else
            GP = P;
        end
        if ismember(k,fname)==0%ͼ����û�б�ѡ��
            labelcover = -1;%δǶ����Ϣͼ��
            if strfind(method,'DEEdge')
                if strcmp(method,'DEEdge_H5')
                    features11(k,:) = [labelcover,spam686(GP)'];
                else
                    features11(k,:) = [labelcover,spam686(GP)'];
                    features12(k,:) = [labelcover,spam686(GP)'];
                    features21(k,:) = [labelcover,spam686(GP)'];
                    features22(k,:) = [labelcover,spam686(GP)'];
                end
            else
                features(k,:) = [labelcover,spam686(GP)'];
            end
        else      
            [row,col] = size(GP);
            labelstego = 1;
            BL = randi([0,1],[1,floor(row*col*percent)-2]);
            
            p = str2func(method);
            if strfind(method,'DEEdge')
                [Stego11,Stego12,Stego21,Stego22] = p(BL,GP);
                if strcmp(method,'DEEdge_H5')
                    features11(k,:) = [labelstego,spam686(Stego11)'];
                else
                    features11(k,:) = [labelstego,spam686(Stego11)'];
                    features12(k,:) = [labelstego,spam686(Stego12)'];
                    features21(k,:) = [labelstego,spam686(Stego21)'];
                    features22(k,:) = [labelstego,spam686(Stego22)'];
                end
            else
                Stego = p(BL,GP);
                features(k,:) = [labelstego,spam686(Stego)'];
            end
            
        end
    end
    str = strcat(method,',The rate of  ',num2str(percent),' embedding successful!');
    disp(str);
    t2 = clock;
    t = etime(t2,t1);
    if strfind(method,'DEEdge')
        if strcmp(method,'DEEdge_H5')
            features = features11;
            matname = strcat(method,'11TrainFeatures_rsp',num2str(percent),'.mat');
            save(matname,'features','t')
        else
            features = features11;
            matname = strcat(method,'11TrainFeatures_rsp',num2str(percent),'.mat');
            save(matname,'features','t')
            
            features = features12;
            matname = strcat(method,'12TrainFeatures_rsp',num2str(percent),'.mat');
            save(matname,'features','t')
            
            features = features21;
            matname = strcat(method,'21TrainFeatures_rsp',num2str(percent),'.mat');
            save(matname,'features','t')
            
            features = features22;
            matname = strcat(method,'22TrainFeatures_rsp',num2str(percent),'.mat');
            save(matname,'features','t')
        end
    else
        matname = strcat('Prue',method,'TrainFeatures_rsp',num2str(percent),'.mat');
        save(matname,'features','t')
    end
end


