function [in_gain,d1,d2] = gain(set1,set2)
%信息增益计算函数
%   输入：两个在某一列上进行划分的数据集合set1,set2
%   输出：信息增益gain
%             两种划分的元素个数与总数的比例d1,d2
%%

%计算各个矩阵的元素个数
n=size([set1;set2],1);
n1=size(set1,1);
n2=size(set2,1);
d1=n1/n;
d2=n2/n;
%计算信息增益
in_gain=Ent([set1(:,end);set2(:,end)])-d1*Ent(set1(:,end))-d2*Ent(set2(:,end));

end

