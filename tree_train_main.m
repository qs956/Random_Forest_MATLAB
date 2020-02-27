function [tree,P0]=tree_train_main(train_x,train_y)
%基学习器(C4.5决策树)训练程序
%输入：    train_x为训练数据(n*m矩阵)
%              train_y为标识列(n*1矩阵)
%输出：    tree训练的决策树
%              P0训练集预测准确率
%%

%对数据进行排序以便进行后续操作
data=[train_x,train_y];
%对temp按照最后一列升序排列
data=sortrows(data,size(data,2));

%计算标识的类别个数,并把其声明为全局变量
global m;
[~,m,~]=unique(data(:,end),'last','legacy');
m=size(m,1);


%% 先进行第一次划分
k=ceil(log2(size(data,2)));
index=unique(randi(size(train_x,2),k,1));
temp1=data(:,index);
temp1=[temp1,train_y];
%计算最佳划分属性以及最佳划分值
[bestvalue,bestattribute]=BestAttribute(temp1);
bestattribute=index(bestattribute);
%根据结果,划分原来数据为两个集合set1,set2
[set1,set2]=divideset(data,bestattribute,bestvalue);

%% 创建树
%%
%使用表的数据结构来存放树
%一个节点为一行,一列为一个节点的属性值
%使用行名来分辨节点位置,root为根节点,r为根节点的右节点,rr为第二层最右节点
%节点属性值有6个:
%节点类型type:node为普通节点,leaf为叶节点
%节点的最优划分属性bestattribute:为该属性的列号
%节点的最优划分值bestvalue:比其大的划分到左节点,否则划分到右节点
%节点深度depth,直接等于节点名称中r或l的个数
%数据集set1,set2:用于存放训练时候的数据
%%
%声明为全局变量以方便修改
global Tree;
%声明位置标识字符串
global type;
%创建名为Tree的一个表,其中存入一个元素root
Tree=table('node',0,bestattribute,bestvalue,{set1},{set2},'RowNames',{'root'});
%指定表每行的名称
Tree.Properties.VariableNames = {'Type','depth','bestattribute','bestvalue','set1','set2'};

%初始化为L,即先从左子树开始遍历


%% 开始训练

%训练左子树
if (~isempty(set1))
    type='l';
    decisionTreeTrain(set1);
end

%训练右子树
if (~isempty(set2))
    type='r';
    decisionTreeTrain(set2);
end

%%
%对表进行排序
Tree=sortrows(Tree,'RowNames','descend');
Tree=sortrows(Tree,'depth','descend');

 %% 使用训练数据进行测试
 %%
%先找到根节点的最佳划分属性以及划分值
%注意这里是表索引,要用大括号
attribute=Tree{'root','bestattribute'};
value=Tree{'root','bestvalue'};
x=data(:,1:end-1);
y=data(:,end);
decision_y=zeros(size(y));
for i=1:1:size(x,1)
    %先判断每个属性是哪个子树
    if x(i,attribute)>value
        type='l';
    else
        type='r';
    end
    decision_y(i,1)=decisionTreeTest(x(i,:));
end
%% 模型评价
%计算模型预测准确率
% total_tree(size(total_tree,1)+1,1)={Tree};

P0=nnz(decision_y==y)/size(x,1)*100;
tree=Tree;
end