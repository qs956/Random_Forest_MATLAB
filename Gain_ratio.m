function [gain_r] = Gain_ratio(set1,set2)
%��Ϣ�����ʼ��㺯��
%	���룺������ĳһ���Ͻ��л��ֵ����ݼ���set1,set2
%   �������Ϣ������gain_r
%%

if (isempty(set1)||isempty(set2))
    gain_r=0;
    return;
end
%������Ϣ����
[Gain,d1,d2]=gain(set1,set2);
%����������
IV=-d1*log2(d1)-d2*log2(d2);
gain_r=Gain/IV;

end

