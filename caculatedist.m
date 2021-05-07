function [dist] = caculatedist(x,xpath,point,goal)
%计算当前车辆当前位置到目标点距离
dist = 0;
task=[xpath;point;goal]
for i=1:size(task,1)
    dist=dist+norm(x-task(i,:));
end
    
end

