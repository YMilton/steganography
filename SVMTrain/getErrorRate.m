
function [error,Fp,Fn] = getErrorRate(features,percent)

label = features(:,1);
%获取载密图像与原始图像的SPAM特征数据
stegodata = features(label==1,:);
coverdata = features(label==-1,:);

num = floor(length(label)/4);
trainfeatures = [stegodata(1:num,:);coverdata(1:num,:)];
Temp_testfeatures = [stegodata(num+1:end,:);coverdata(num+1:end,:)];
[m,~] = size(Temp_testfeatures);
load('index670.mat');
for k = 1:m
    Temp_testfeatures0(k,:) = Temp_testfeatures(index(k),:);
end
testfeatures = Temp_testfeatures0(1:floor(percent*m),:);

trainlabel = trainfeatures(:,1);
traindata = trainfeatures(:,2:end);

testlabel = testfeatures(:,1);
testdata = testfeatures(:,2:end);

% data = features(:,2:end);
% trainlabel = label;%(1:length(label)/2,:);
% traindata = data;%(1:length(label)/2,:);
% testlabel = label(1:1000,:);
% testdata = data(1:1000,:);

% model = svmtrain(trainlabel,traindata,'-s 0 -t 2 -c 32768 -g 2 -e 0.0001 -h 0');
model = svmtrain(trainlabel,traindata,'-s 0 -t 2 -c 10000 -g 0.0078125 -e 0.0001 -h 0');
% model = svmtrain(trainlabel,traindata,'-s 0 -t 2 -c 1000000 -g 0.015625 -e 0.0001 -h 0');

[predict_label,~,~] = svmpredict(testlabel,testdata,model);

predict_label_neg1 = predict_label(testlabel==-1);
Fp = sum(predict_label_neg1==1)/length(predict_label_neg1);

predict_label_1 = predict_label(testlabel==1);
Fn = sum(predict_label_1==-1)/length(predict_label_1);

error = 0.5*(Fn+Fp);
end