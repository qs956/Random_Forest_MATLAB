function [set1,set2] = divideset(data, column, value)
%���ݼ����ֺ���
%   ���룺���ݼ�data(��Ҫ���������кͱ�ǩ��)
%             ���ֵ���column
%             �ж�����value
%   ������������ֺ�ļ���set1,set2
%   ģ�ͣ���data����column��ֵ����Ϊ������
%             ����valueΪset1,����Ϊset2
%%

set1=data(data(:,column)>value,:);
set2=data(data(:,column)<=value,:);
end

