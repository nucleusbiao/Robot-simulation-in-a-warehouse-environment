function [crashstate,crash] = robotavoid(x,xstate,state,xorder,xpath,xpoint,n,pn,target,stopp,trajp,path,dis)
% 
tempx=x;tempxstate=xstate;tempstate=state;tempxorder=xorder;tempn=n;tempxpath=xpath;
temppn=pn;
crashstate=false;
crash=zeros(size(x,1));
% for i=1:5
% [tempx] = Executetask(tempx,tempxstate,tempstate,tempxorder,tempxpath,xpoint,tempn,temppn,crash,target,stopp,trajp,path,dis);
% end
for i=1:size(x,1)
    for j=1:size(x,1)
        if i~=j&&norm(tempx(i,:)-tempx(j,:))<0.6 
            crashstate=true;
            crash(i,j)=1;
        end
    end
end
end

