function [decision_y,P] = tree_test_main(tree,test_x,test_y)
%基学习器测试函数
%输入：    tree已经生成的决策树
%              test_x测试集属性
%              test_y测试集标签
%输出：    decision_y预测的标签
%              P预测准确率
%%
global Tree;
Tree=tree;
global type;
attribute=Tree{'root','bestattribute'};
value=Tree{'root','bestvalue'};
decision_y=zeros(size(test_y));
for i=1:1:size(test_x,1)
    if test_x(i,attribute)>value
        type='l';
    else
        type='r';
    end
    decision_y(i,1)=decisionTreeTest(test_x(i,:));
end

P=nnz(decision_y==test_y)/size(test_x,1)*100;
end

