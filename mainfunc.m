close all;
clear all;

load('data/trajp.mat') % 仓储环境的轨迹点
load('data/x.mat')    %100个机器人的初始位置
load('data/storagepoint.mat')   %货架上对应的工作点
load('data/storagerock.mat')     %货架位置
load('data/target.mat')          %最终目标点
load('data/stopp.mat')           %与目标点相对应的，每个机器人站中的停靠点
xpath=zeros(1500,200);%用于存放机器人当前订单的剩余任务
xstate=zeros(1,100); %用来表示机器人的状态，0 未接受订单 1 正在执行订单
state=zeros(1,100); %用来判断机器人是否到达任务点，准备执行任务
xpoint=zeros(3,200);
xorder=zeros(1500,200); %订单任务矩阵，用来存放所有机器人当前路径

dt=0.1;
global v
v = 0.5;
duration = 1; %机器人工作时间
grid on
[t,dis,path] = Floyd1(trajp);
time=0;
worktime=zeros(1,size(x,1));%记录机器人在当前工作点已经工作的时间
[point,goal] = Createorderform();    %产生订单
num=1;
pn=zeros(1,100)
n=ones(size(x,1),1);  %用来记录机器人到达了其当前路径的第几个节点
t=0;
%%
while 1
    if num<200                              %每-s产生一个订单
        [point,goal] = Createorderform();    %产生订单
        %         point=[3 3.5]
        %          goal=[4.5 2]
        num=num+1;
        [crashstate,crash] = robotavoid(x,xstate,state,xorder,xpath,xpoint,n,pn,target,stopp,trajp,path,dis);
        [finalpath,ind,xstate] = bidfunc(x,xstate,xpath,point,goal,duration,trajp,pn,path,dis);    %竞价，给出成本最低的车的路径
        
        xorder(:,2*ind-1:2*ind)=zeros(1500,2);
        n(ind)=1;
        xorder(1:size(finalpath,1),2*ind-1:2*ind)=finalpath;
        xpath(1:size(finalpath,1),2*ind-1:2*ind)=finalpath;
        xpoint(:,2*ind-1:2*ind)=[point;zeros(3-size(point,1),2)];
        pn(ind)=size(point,1);
        time=0;
    end
    while 1
        
        hold off      
        [crashstate,crash] = robotavoid(x,xstate,state,xorder,xpath,xpoint,n,pn,target,stopp,trajp,path,dis);     
        [x,xstate,state,xpath,n,pn,xorder] = Executetask(x,xstate,state,xorder,xpath,xpoint,n,pn,crash,target,stopp,trajp,path,dis); %执行任务
        time=time+dt;
        t=t+dt;
        worktime;
        plot(finalpath(:,1),finalpath(:,2),'--');hold on;
        plot(x(:,1),x(:,2),'ro','MarkerFaceColor','r');hold on;
        plot(storagerock(:,1),storagerock(:,2),'sk');hold on;
        simenvironment()
        plot(target(:,1),target(:,2),'xr');hold on;
        grid on
        drawnow;
        for j=1:size(x,1)
            if state(j)==1                     %如果机器人到达工作点，开始计时，直到任务时间结束
                worktime(j)=worktime(j)+dt;
            end
            if worktime(j)>duration
                worktime(j)=0;
                state(j)=0;
            end
        end
        if time>2
            break;
        end
        
    end
    if num==200&&(~any(xstate))
        break;
    end
    
end