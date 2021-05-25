function [x,xstate,state,xpath,n,pn,xorder] = Executetask(x,xstate,state,xorder,xpath,xpoint,n,pn,crash,target,stopp,trajp,path,dis) %
% 竞拍完成后，执行订单任务，机器人开始动作

dt=0.1;v=0.5;

for i=1:size(x,1)    
    if xstate(i)==1
        if state(i)==0
            unitp=(xorder(n(i),2*i-1:2*i)-x(i,:))/norm(xorder(n(i),2*i-1:2*i)-x(i,:)); %当前机器人指向当前目标的单位向量           
            dist=dt*(v+normrnd(0,0.1));   %计算移动距离，给速度加入了一个随机偏差
            
            % 判断机器人之间是否冲突，并作出相应行动
            for j=1:size(x,1)
                unitpj=(xorder(n(j),2*j-1:2*j)-x(j,:))/norm(xorder(n(j),2*j-1:2*j)-x(j,:)); %机器人j 指向其当前目标的单位向量 
                if crash(i,j)==1&&xstate(j)==1
                    if state(j)==1
                        x(i,:)=x(i,:);
                        break;
                    else
                        if unitp~=unitpj
                            if i<j
                                x(i,:)=x(i,:);
                                break;
                            else
                                x(i,:)=unitp*dist+x(i,:);
                            end
                        else
                            if unitp(1)>0
                                if x(i,1)<x(j,1)
                                    x(i,:)=x(i,:);
                                else
                                    x(i,:)=unitp*dist+x(i,:);
                                end
                            else
                                if x(i,1)>x(j,1)
                                    x(i,:)=x(i,:);
                                else
                                    x(i,:)=unitp*dist+x(i,:);
                                end
                            end
                            if unitp(2)>0
                                if x(i,2)<x(j,2)
                                    x(i,:)=x(i,:);
                                else
                                    x(i,:)=unitp*dist+x(i,:);
                                end
                            else
                                if x(i,2)>x(j,2)
                                    x(i,:)=x(i,:);
                                else
                                    x(i,:)=unitp*dist+x(i,:);
                                end
                            end
                        end                   
                    end
                end
            end
            if j==size(x,1)
                x(i,:)=unitp*dist+x(i,:);
            end
        else
            x(i,:)=x(i,:);
        end
    end
    
    if norm(xorder(n(i),2*i-1:2*i)-x(i,:))<0.06
        x(i,:)=xorder(n(i),2*i-1:2*i);
        n(i)=n(i)+1;
        xpath(:,2*i-1:2*i)=[xorder(n(i):size(xorder,1),2*i-1:2*i);zeros(n(i)-1,2)];       
        for k=1:3
            if xorder(n(i)-1,2*i-1:2*i)==xpoint(k,2*i-1:2*i)         %判断该节点是否为工作点 
                pn(i)=pn(i)-1;
                state(i)=1;
            end
        end
    end  
    %到达终点后准备进入机器人站
    if xstate(i)==1
        if xorder(n(i),2*i-1)==0&&xorder(n(i),2*i)==0
            [lib1,ind1]=ismember(xorder(n(i)-1,2*i-1:2*i),target,'rows');
            if ind1~=0
                for ii=1:size(stopp,2)/2
                    s=ifoccupy(x,stopp(ind1,2*ii-1:2*ii));   
                    if s==0
                        [finalpath] = printPath(xorder(n(i)-1,2*i-1:2*i),stopp(ind1,2*ii-1:2*ii),trajp,path,dis);
                        xorder(n(i):n(i)+size(finalpath,1)-1,2*i-1:2*i)=finalpath;
                        xpath(:,2*i-1:2*i)=[xorder(n(i):size(xorder,1),2*i-1:2*i);zeros(n(i)-1,2)];
                        break;
                    end
                end
            end
        end
    end
       
    if xorder(n(i),2*i-1)==0&&xorder(n(i),2*i)==0    %完成任务，列表清零
        xstate(i)=0;
        n(i)=1;
        xorder(:,2*i-1:2*i)=zeros(size(xorder,1),2);      
    end    
end

end

