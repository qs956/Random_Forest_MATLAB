function [in_gain,d1,d2] = gain(set1,set2)
%��Ϣ������㺯��
%   ���룺������ĳһ���Ͻ��л��ֵ����ݼ���set1,set2
%   �������Ϣ����gain
%             ���ֻ��ֵ�Ԫ�ظ����������ı���d1,d2
%%

%������������Ԫ�ظ���
n=size([set1;set2],1);
n1=size(set1,1);
n2=size(set2,1);
d1=n1/n;
d2=n2/n;
%������Ϣ����
in_gain=Ent([set1(:,end);set2(:,end)])-d1*Ent(set1(:,end))-d2*Ent(set2(:,end));

end

