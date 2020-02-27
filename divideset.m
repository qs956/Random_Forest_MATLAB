function [set1,set2] = divideset(data, column, value)
%数据集划分函数
%   输入：数据集data(需要包含属性列和标签列)
%             划分的列column
%             判断条件value
%   输出：两个划分后的集合set1,set2
%   模型：把data根据column列值划分为两部分
%             大于value为set1,否则为set2
%%

set1=data(data(:,column)>value,:);
set2=data(data(:,column)<=value,:);
end

