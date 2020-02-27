function []=decisionTreeTrain(data)
%������ѵ������
%   ���룺��������data,ÿһ��Ϊһ������,ÿһ��Ϊһ������(���һ��Ϊ��ǩ��)
%%

%���Ѿ�����Ϊȫ�ֱ���
global Tree;
global type;
%������ʾѵ������
% type
%�����ǰ��������ȫ����ͬһ����,��ô���ؿ�ֵ,ͬʱ���ΪҶ�ڵ�
%bestvalue����ΪInf,bestattribute����Ϊ��ǰ���ݼ�������������y
if size(unique(data(:,end)),1)==1
    temp=table('leaf',size(type,2),data(1,end),inf,{0},{0},'RowNames',{type});
    temp.Properties.VariableNames = ...
    {'Type','depth','bestattribute','bestvalue','set1','set2'};
    Tree=[Tree;temp];
    type=type(1,1:end-1);
    return;
end

%%
%����ʼ����
k=ceil(log2(size(data,2)-1));
index=unique(randi(size(data,2)-1,k,1));
temp1=data(:,index);
temp1=[temp1,data(:,end)];
%������ѻ��������Լ���ѻ���ֵ
[bestvalue,bestattribute]=BestAttribute(temp1);
bestattribute=index(bestattribute);
%���ݽ��,����ԭ������Ϊ��������set1,set2
[set1,set2]=divideset(data,bestattribute,bestvalue);

%�����һ������Ϊ��,��ζ���Ѿ��޷�����
%���ΪҶ�ڵ�
if  isempty(set1)||isempty(set2)
    temp=table('leaf',size(type,2),mode([set1(:,end);set2(:,end)]),inf,{0},{0},'RowNames',{type});
    temp.Properties.VariableNames = ...
    {'Type','depth','bestattribute','bestvalue','set1','set2'};
    Tree=[Tree;temp];
    type=type(1,1:end-1);
    return;
end

%����Ļ��Ѹû��ֽڵ�д�����
temp=table('node',size(type,2),bestattribute,bestvalue,{set1},{set2},'RowNames',{type});
temp.Properties.VariableNames = ...
{'Type','depth','bestattribute','bestvalue','set1','set2'};
Tree=[Tree;temp];

%���±�ʶ��
type=[type,'l'];
%���ֻ��һ��,���ΪҶ�ڵ�
if size(set1,1)==1
    temp=table('leaf',size([type,'l'],2),set1(end),inf,{0},{0},'RowNames',{[type,'l']});
    temp.Properties.VariableNames = ...
    {'Type','depth','bestattribute','bestvalue','set1','set2'};
    Tree=[Tree;temp];
end
%����ݹ�
decisionTreeTrain(set1);

type=[type,'r'];
if size(set2,1)==1
    temp=table('leaf',size([type,'r'],2),set2(end),inf,{0},{0},'RowNames',{[type,'r']});
    temp.Properties.VariableNames = ...
    {'Type','depth','bestattribute','bestvalue','set1','set2'};
    Tree=[Tree;temp];
end

decisionTreeTrain(set2);

%������ɺ���ı�ʶ��
type=type(1,1:end-1);
return;
end

