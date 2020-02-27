function [gain_r] = Gain_ratio(set1,set2)
%信息增益率计算函数
%	输入：两个在某一列上进行划分的数据集合set1,set2
%   输出：信息增益率gain_r
%%

if (isempty(set1)||isempty(set2))
    gain_r=0;
    return;
end
%计算信息增益
[Gain,d1,d2]=gain(set1,set2);
%计算增益率
IV=-d1*log2(d1)-d2*log2(d2);
gain_r=Gain/IV;

end

