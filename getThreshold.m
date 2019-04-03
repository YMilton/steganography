%% ��ֵ������Ӧѡ��
function [ths,pixlens,bw] = getThreshold(I,N)
    %I�ǻҶ�ͼ��N��Ƕ������Ƶĳ���
    %ths�ǵ�������ֵ��pixelens�ǵ���������ֵ���ȣ�bw��������ֵ�µı�Ե����Ķ�ֵͼ��
    tmax = 1;
    tmin = 0;
    bool = 0;
    ths = [];
    pixlens = [];
    while ~bool
        th = (tmax+tmin)/2;
        ths = [ths;th];
        bw = edge(I,'canny',th);
        pixels = I(bw==1);
        %����Ե��ȡ����������ֵ��������ֵ�ı仯���仯������������ֵ�㶨
        if ~isempty(pixlens) && length(pixels)==pixlens(end)
%             ths = ths(1:end-1,:);
            ths = ths(1:end,:);
            pixlens = [pixlens;length(pixels)];
            break;
        end
        pixlens = [pixlens;length(pixels)];
        if length(pixels)<N
            tmax = th;
        elseif length(pixels)-N>0.001*N
            tmin = th;
        else
            bool = 1;
        end
    end
end