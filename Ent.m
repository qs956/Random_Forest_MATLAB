function [ent] = Ent(y)
%��Ϣ�ؼ��㺯��
%   ���룺��ʶ����y
%   �������������Ϣ��ent

%%
%ͳ��y֮�и������͵���Ŀ
global m;
n=zeros(m,1);
for i=1:1:m
    n(i,1)=nnz(y==i);
end
%ȥ��0
n=n(n>0);
%%
%������Ϣ��
p=n./sum(n);
ent=-sum(p.*log2(p));
end