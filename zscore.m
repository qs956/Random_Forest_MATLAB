function [x,mu,xita] = zscore(x)
%列规范化，归一化函数
%   注意：由于使用了隐式拓展,该函数只适用于R2016b及以上版本
%   输入：数据文件,每一行是一个样本,每一列为一个属性值
%   输出：x--经过标准化,归一化之后的数据
%             mi--数据最小值
%             dv--数据极差max-min
%%
%模型：   x=(x-min(x))./(max(x)-min(x))

%%

mu=mean(x,1);
xita=std(x,1);
% x=(x-mi),./dv;
x=(x-mean(x,1))./std(x,1);

end

