function [bestvalue,j] = BestAttribute(data)
%求最佳划分属性以及划分值
%   输入：数据集data(要求最后一列为标签列,其余为属性列)
%   输出：最佳划分值bestvalue
%             最佳划分属性的编号j
%%


%% 求所有属性的划分点
% 对每个属性进行排序,然后求其中点
point=zeros(size(data)-1);
temp=zeros(size(data,1),1);
temp1=zeros(size(data,1)-1,1);
temp2=zeros(size(data,1)-1,1);
for i=1:1:size(data,2)-1
    temp=sort(data(:,i));
    temp1=temp(1:end-1,:);
    temp2=temp(2:end,:);
    point(:,i)=(temp1+temp2)./2;
end

%% 对每个属性，求它每个划分点的信息增益
in_gain=zeros(size(point));
for i=1:1:size(data,2)-1
    for j=1:1:size(point(:,i),1)
        set1=[];
        set2=[];
        [set1,set2]=divideset(data,i,point(j,i));
        [in_gain(j,i),~,~]=gain(set1,set2);
    end
end
%%
%求最大信息增益的属性序号
%计算信息增益每一列的最大值
in_gain=max(in_gain,[],1);
%对列最大值进行降序排列,并用index储存原来的索引
[~,index]=sort(in_gain,2,'descend');
%选取信息增益最大的前三分一的属性
index=index(1:ceil(size(data,2)/3));
% point=point(:,index);
% index=1:1:size(data,2)-1;
%% 对这些属性，计算其增益率
%预先分配空间提高运算速度
gain_r=zeros(size(point,1),size(index,2));
for i=1:1:size(index,2)
    for j=1:1:size(point(:,i),1)
        set1=[];
        set2=[];
        [set1,set2]=divideset(data,i,point(j,index(i)));
        gain_r(j,i)=Gain_ratio(set1,set2);
    end
end
%求解最大增益率所在的属性以及该划分值

%计算每一列的最大增益率,该值分别位于原来的第i行
[max_gain_r,i]=max(gain_r,[],1);
%计算行的最大值,也就是原来增益率的最大值,位于max_gain_r矩阵的第j列
[~,j]=max(max_gain_r,[],2);

i=i(j);
%把j转换为原来第几个属性
j=index(j);
bestvalue=point(i,j);
end

