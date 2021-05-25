function [finalpath] = printPath(x,goal,trajp,path,dis)
%将路径序号转换为具体的坐标点

[lib1,ind1]=ismember(x,trajp,'rows');
[lib2,ind2]=ismember(goal,trajp,'rows');
pathind=printpathIndex(ind1,ind2,path);
finalpath=[];
for i=1:size(pathind,2)
    finalpath(i,:)=trajp(pathind(i),:);
end
d=dis(ind1,ind2);
end
