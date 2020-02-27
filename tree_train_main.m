function [tree,P0]=tree_train_main(train_x,train_y)
%��ѧϰ��(C4.5������)ѵ������
%���룺    train_xΪѵ������(n*m����)
%              train_yΪ��ʶ��(n*1����)
%�����    treeѵ���ľ�����
%              P0ѵ����Ԥ��׼ȷ��
%%

%�����ݽ��������Ա���к�������
data=[train_x,train_y];
%��temp�������һ����������
data=sortrows(data,size(data,2));

%�����ʶ��������,����������Ϊȫ�ֱ���
global m;
[~,m,~]=unique(data(:,end),'last','legacy');
m=size(m,1);


%% �Ƚ��е�һ�λ���
k=ceil(log2(size(data,2)));
index=unique(randi(size(train_x,2),k,1));
temp1=data(:,index);
temp1=[temp1,train_y];
%������ѻ��������Լ���ѻ���ֵ
[bestvalue,bestattribute]=BestAttribute(temp1);
bestattribute=index(bestattribute);
%���ݽ��,����ԭ������Ϊ��������set1,set2
[set1,set2]=divideset(data,bestattribute,bestvalue);

%% ������
%%
%ʹ�ñ�����ݽṹ�������
%һ���ڵ�Ϊһ��,һ��Ϊһ���ڵ������ֵ
%ʹ���������ֱ�ڵ�λ��,rootΪ���ڵ�,rΪ���ڵ���ҽڵ�,rrΪ�ڶ������ҽڵ�
%�ڵ�����ֵ��6��:
%�ڵ�����type:nodeΪ��ͨ�ڵ�,leafΪҶ�ڵ�
%�ڵ�����Ż�������bestattribute:Ϊ�����Ե��к�
%�ڵ�����Ż���ֵbestvalue:�����Ļ��ֵ���ڵ�,���򻮷ֵ��ҽڵ�
%�ڵ����depth,ֱ�ӵ��ڽڵ�������r��l�ĸ���
%���ݼ�set1,set2:���ڴ��ѵ��ʱ�������
%%
%����Ϊȫ�ֱ����Է����޸�
global Tree;
%����λ�ñ�ʶ�ַ���
global type;
%������ΪTree��һ����,���д���һ��Ԫ��root
Tree=table('node',0,bestattribute,bestvalue,{set1},{set2},'RowNames',{'root'});
%ָ����ÿ�е�����
Tree.Properties.VariableNames = {'Type','depth','bestattribute','bestvalue','set1','set2'};

%��ʼ��ΪL,���ȴ���������ʼ����


%% ��ʼѵ��

%ѵ��������
if (~isempty(set1))
    type='l';
    decisionTreeTrain(set1);
end

%ѵ��������
if (~isempty(set2))
    type='r';
    decisionTreeTrain(set2);
end

%%
%�Ա��������
Tree=sortrows(Tree,'RowNames','descend');
Tree=sortrows(Tree,'depth','descend');

 %% ʹ��ѵ�����ݽ��в���
 %%
%���ҵ����ڵ����ѻ��������Լ�����ֵ
%ע�������Ǳ�����,Ҫ�ô�����
attribute=Tree{'root','bestattribute'};
value=Tree{'root','bestvalue'};
x=data(:,1:end-1);
y=data(:,end);
decision_y=zeros(size(y));
for i=1:1:size(x,1)
    %���ж�ÿ���������ĸ�����
    if x(i,attribute)>value
        type='l';
    else
        type='r';
    end
    decision_y(i,1)=decisionTreeTest(x(i,:));
end
%% ģ������
%����ģ��Ԥ��׼ȷ��
% total_tree(size(total_tree,1)+1,1)={Tree};

P0=nnz(decision_y==y)/size(x,1)*100;
tree=Tree;
end