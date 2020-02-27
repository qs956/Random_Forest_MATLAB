function [ent] = Ent(y)
%信息熵计算函数
%   输入：标识集合y
%   输出：该属性信息熵ent

%%
%统计y之中各个类型的数目
global m;
n=zeros(m,1);
for i=1:1:m
    n(i,1)=nnz(y==i);
end
%去除0
n=n(n>0);
%%
%计算信息熵
p=n./sum(n);
ent=-sum(p.*log2(p));
end