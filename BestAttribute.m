function [bestvalue,j] = BestAttribute(data)
%����ѻ��������Լ�����ֵ
%   ���룺���ݼ�data(Ҫ�����һ��Ϊ��ǩ��,����Ϊ������)
%   �������ѻ���ֵbestvalue
%             ��ѻ������Եı��j
%%


%% ���������ԵĻ��ֵ�
% ��ÿ�����Խ�������,Ȼ�������е�
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

%% ��ÿ�����ԣ�����ÿ�����ֵ����Ϣ����
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
%�������Ϣ������������
%������Ϣ����ÿһ�е����ֵ
in_gain=max(in_gain,[],1);
%�������ֵ���н�������,����index����ԭ��������
[~,index]=sort(in_gain,2,'descend');
%ѡȡ��Ϣ��������ǰ����һ������
index=index(1:ceil(size(data,2)/3));
% point=point(:,index);
% index=1:1:size(data,2)-1;
%% ����Щ���ԣ�������������
%Ԥ�ȷ���ռ���������ٶ�
gain_r=zeros(size(point,1),size(index,2));
for i=1:1:size(index,2)
    for j=1:1:size(point(:,i),1)
        set1=[];
        set2=[];
        [set1,set2]=divideset(data,i,point(j,index(i)));
        gain_r(j,i)=Gain_ratio(set1,set2);
    end
end
%���������������ڵ������Լ��û���ֵ

%����ÿһ�е����������,��ֵ�ֱ�λ��ԭ���ĵ�i��
[max_gain_r,i]=max(gain_r,[],1);
%�����е����ֵ,Ҳ����ԭ�������ʵ����ֵ,λ��max_gain_r����ĵ�j��
[~,j]=max(max_gain_r,[],2);

i=i(j);
%��jת��Ϊԭ���ڼ�������
j=index(j);
bestvalue=point(i,j);
end

