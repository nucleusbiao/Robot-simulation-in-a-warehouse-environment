function [point,goal] = Createorderform()
%生成订单
point=[];
global storagepoint;
global target;
N=size(storagepoint,1);
n=size(target,1);
nodenumber=unidrnd(3);          %产生任务点个数

task=randperm(N,nodenumber);
for i=1:nodenumber
    point(i,:)=storagepoint(task(i),:);
end

goalind=unidrnd(n);
goal=target(goalind,1:2);

end

