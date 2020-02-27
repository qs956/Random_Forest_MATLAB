function []=decisionTreeTrain(data)
%决策树训练函数
%   输入：样本矩阵data,每一行为一个样本,每一列为一个属性(最后一列为标签列)
%%

%树已经声明为全局变量
global Tree;
global type;
%用于显示训练进程
% type
%如果当前集合样本全属于同一类型,那么返回空值,同时标记为叶节点
%bestvalue设置为Inf,bestattribute设置为当前数据集合中类型最多的y
if size(unique(data(:,end)),1)==1
    temp=table('leaf',size(type,2),data(1,end),inf,{0},{0},'RowNames',{type});
    temp.Properties.VariableNames = ...
    {'Type','depth','bestattribute','bestvalue','set1','set2'};
    Tree=[Tree;temp];
    type=type(1,1:end-1);
    return;
end

%%
%否则开始划分
k=ceil(log2(size(data,2)-1));
index=unique(randi(size(data,2)-1,k,1));
temp1=data(:,index);
temp1=[temp1,data(:,end)];
%计算最佳划分属性以及最佳划分值
[bestvalue,bestattribute]=BestAttribute(temp1);
bestattribute=index(bestattribute);
%根据结果,划分原来数据为两个集合set1,set2
[set1,set2]=divideset(data,bestattribute,bestvalue);

%如果有一个集合为空,意味着已经无法划分
%标记为叶节点
if  isempty(set1)||isempty(set2)
    temp=table('leaf',size(type,2),mode([set1(:,end);set2(:,end)]),inf,{0},{0},'RowNames',{type});
    temp.Properties.VariableNames = ...
    {'Type','depth','bestattribute','bestvalue','set1','set2'};
    Tree=[Tree;temp];
    type=type(1,1:end-1);
    return;
end

%否则的话把该划分节点写入表中
temp=table('node',size(type,2),bestattribute,bestvalue,{set1},{set2},'RowNames',{type});
temp.Properties.VariableNames = ...
{'Type','depth','bestattribute','bestvalue','set1','set2'};
Tree=[Tree;temp];

%更新标识符
type=[type,'l'];
%如果只有一行,标记为叶节点
if size(set1,1)==1
    temp=table('leaf',size([type,'l'],2),set1(end),inf,{0},{0},'RowNames',{[type,'l']});
    temp.Properties.VariableNames = ...
    {'Type','depth','bestattribute','bestvalue','set1','set2'};
    Tree=[Tree;temp];
end
%进入递归
decisionTreeTrain(set1);

type=[type,'r'];
if size(set2,1)==1
    temp=table('leaf',size([type,'r'],2),set2(end),inf,{0},{0},'RowNames',{[type,'r']});
    temp.Properties.VariableNames = ...
    {'Type','depth','bestattribute','bestvalue','set1','set2'};
    Tree=[Tree;temp];
end

decisionTreeTrain(set2);

%程序完成后更改标识符
type=type(1,1:end-1);
return;
end

