function [decision_y] = decisionTreeTest(x)
%���������Գ���
%	���룺һ������x(1*n����),һ��Ϊһ������
%   ������б������decision_y
%%

%ʹ���Ѿ�ѵ����ɵľ�����
global Tree;
global type;

%���û������ڵ�,�ͷ���NaN
if(~ismember(type,Tree.Properties.RowNames))
    decision_y=NaN;
    return;
end

%%
%�����Ҷ�ӽڵ�,�Ǿ�ֱ���˳�
if strcmp(Tree{type,'Type'},'leaf')
    decision_y=Tree{type,'bestattribute'};
    return;
end

%%
%���ҵ��ڵ����ѻ��������Լ�����ֵ
%ע�������Ǳ�����,Ҫ�ô�����
attribute=Tree{type,'bestattribute'};
value=Tree{type,'bestvalue'};

if x(1,attribute)>value
    type=[type,'l'];
else
    type=[type,'r'];
end
decision_y=decisionTreeTest(x);
end

