function [decision_y,P] = tree_test_main(tree,test_x,test_y)
%��ѧϰ�����Ժ���
%���룺    tree�Ѿ����ɵľ�����
%              test_x���Լ�����
%              test_y���Լ���ǩ
%�����    decision_yԤ��ı�ǩ
%              PԤ��׼ȷ��
%%
global Tree;
Tree=tree;
global type;
attribute=Tree{'root','bestattribute'};
value=Tree{'root','bestvalue'};
decision_y=zeros(size(test_y));
for i=1:1:size(test_x,1)
    if test_x(i,attribute)>value
        type='l';
    else
        type='r';
    end
    decision_y(i,1)=decisionTreeTest(test_x(i,:));
end

P=nnz(decision_y==test_y)/size(test_x,1)*100;
end

