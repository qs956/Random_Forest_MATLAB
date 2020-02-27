function [decision_y] = decisionTreeTest(x)
%决策树测试程序
%	输入：一个样本x(1*n矩阵),一列为一个属性
%   输出：判别分类结果decision_y
%%

%使用已经训练完成的决策树
global Tree;
global type;

%如果没有这个节点,就返回NaN
if(~ismember(type,Tree.Properties.RowNames))
    decision_y=NaN;
    return;
end

%%
%如果是叶子节点,那就直接退出
if strcmp(Tree{type,'Type'},'leaf')
    decision_y=Tree{type,'bestattribute'};
    return;
end

%%
%先找到节点的最佳划分属性以及划分值
%注意这里是表索引,要用大括号
attribute=Tree{type,'bestattribute'};
value=Tree{type,'bestvalue'};

if x(1,attribute)>value
    type=[type,'l'];
else
    type=[type,'r'];
end
decision_y=decisionTreeTest(x);
end

