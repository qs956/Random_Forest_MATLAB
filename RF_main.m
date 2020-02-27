%随机森林主程序
clear all
clc

%并行运算
pa=parpool(4);
%数据预处理
load ('data\SpectralClassificationTrain.mat');
[train_x,mu,xita]=zscore(train_x);
train_y=train_y(:,1);

%基学习器个数
T=20;

%决策树的储存元胞
total_Tree=cell(T,1);
%存放训练集预测精确度矩阵
P0=zeros(T,1);

%% 训练
tic;
parfor i=1:1:T
    %重采样
    index=randi(size(train_x,1),size(train_x,1),1);
    x=train_x(index,:);
    y=train_y(index,1);
    fprintf('训练第 %u 个基学习器...\n',i);
    [tree,P0(i,1)]=tree_train_main(x,y);
    %这里是去除原始集合数据
    tree.set1=[];
    tree.set2=[];
    total_Tree(i,1)={tree};
end
disp('训练用时：')
toc;

%测试
%加载测试数据
load('data\SpectralClassificationTest.mat')
x=normalize(test_x,mu,xita);
y=test_y(:,1);
%存放预测结果
decision_y=zeros(size(x,1),T);
%存放测试集预测正确率
P1=zeros(1,T);
tic;
parfor i=1:1:T
    fprintf('使用第%u个基学习器进行测试\r',i);
%     global Tree;
%     Tree=total_Tree{i,1};
    [decision_y(:,i),P1(i)]=tree_test_main(total_Tree{i,1},x,y);
end

decision=mode(decision_y,2);
P=nnz(decision==y)/size(test_x,1)*100;
fprintf('模型最终预测准确率：%f \r',P);

disp('测试用时：')
toc;
%绘制预测准确率变化曲线图
for i=1:1:T
    decision=mode(decision_y(:,1:i),2);
    P(i)=nnz(decision==y)/size(test_x,1)*100;
end
plot(1:T,P);
xlabel('基学习器数量')
ylabel('预测准确率')
title('预测准确率变化图')

delete (pa)
clear test_x test_y train_x train_y
% save('随机森林\matlab.mat');