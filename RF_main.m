%���ɭ��������
clear all
clc

%��������
pa=parpool(4);
%����Ԥ����
load ('data\SpectralClassificationTrain.mat');
[train_x,mu,xita]=zscore(train_x);
train_y=train_y(:,1);

%��ѧϰ������
T=20;

%�������Ĵ���Ԫ��
total_Tree=cell(T,1);
%���ѵ����Ԥ�⾫ȷ�Ⱦ���
P0=zeros(T,1);

%% ѵ��
tic;
parfor i=1:1:T
    %�ز���
    index=randi(size(train_x,1),size(train_x,1),1);
    x=train_x(index,:);
    y=train_y(index,1);
    fprintf('ѵ���� %u ����ѧϰ��...\n',i);
    [tree,P0(i,1)]=tree_train_main(x,y);
    %������ȥ��ԭʼ��������
    tree.set1=[];
    tree.set2=[];
    total_Tree(i,1)={tree};
end
disp('ѵ����ʱ��')
toc;

%����
%���ز�������
load('data\SpectralClassificationTest.mat')
x=normalize(test_x,mu,xita);
y=test_y(:,1);
%���Ԥ����
decision_y=zeros(size(x,1),T);
%��Ų��Լ�Ԥ����ȷ��
P1=zeros(1,T);
tic;
parfor i=1:1:T
    fprintf('ʹ�õ�%u����ѧϰ�����в���\r',i);
%     global Tree;
%     Tree=total_Tree{i,1};
    [decision_y(:,i),P1(i)]=tree_test_main(total_Tree{i,1},x,y);
end

decision=mode(decision_y,2);
P=nnz(decision==y)/size(test_x,1)*100;
fprintf('ģ������Ԥ��׼ȷ�ʣ�%f \r',P);

disp('������ʱ��')
toc;
%����Ԥ��׼ȷ�ʱ仯����ͼ
for i=1:1:T
    decision=mode(decision_y(:,1:i),2);
    P(i)=nnz(decision==y)/size(test_x,1)*100;
end
plot(1:T,P);
xlabel('��ѧϰ������')
ylabel('Ԥ��׼ȷ��')
title('Ԥ��׼ȷ�ʱ仯ͼ')

delete (pa)
clear test_x test_y train_x train_y
% save('���ɭ��\matlab.mat');