function [flow] = preditflow(finalpath,i,x,xpath)
%计算机器人途经各个区域的机器人密度的总和

tempx=x;tempxpath=xpath;
tempxpath(1:size(finalpath,1),2*i-1:2*i)=finalpath;

f=zeros(1,9);

for m=1:fix(size(finalpath,1)/4)    
    for n=1:100
        tempx(n,:)=tempxpath(4*m,2*n-1:2*n);
    end

    if tempx(i,1)>3&&tempx(i,1)<11
        if tempx(i,2)>16&&tempx(i,2)<21
            [M] = robotCount(tempx);
            if M(1)>f(1)
                f(1)=M(1)/40;
            end
        end
    end
    if tempx(i,1)>11&&tempx(i,1)<23
        if tempx(i,2)>16&&tempx(i,2)<21
            [M] = robotCount(tempx);
            if M(2)>f(2)
                f(2)=M(2)/60;
            end
        end
    end
    if tempx(i,1)>23&&tempx(i,1)<31
        if tempx(i,2)>16&&tempx(i,2)<21
            [M] = robotCount(tempx);
            if M(3)>f(3)
                f(3)=M(3)/40;
            end
        end
    end
    if tempx(i,1)>3&&tempx(i,1)<11
        if tempx(i,2)>8&&tempx(i,2)<16
            [M] = robotCount(tempx);
            if M(4)>f(4)
                f(4)=M(4)/64;
            end
        end
    end
    if tempx(i,1)>11&&tempx(i,1)<23
        if tempx(i,2)>8&&tempx(i,2)<16
            [M] = robotCount(tempx);
            if M(5)>f(5)
                f(5)=M(5)/96;
            end
        end
    end
    if tempx(i,1)>23&&tempx(i,1)<31
        if tempx(i,2)>8&&tempx(i,2)<16
            [M] = robotCount(tempx);
            if M(6)>f(6)
                f(6)=M(6)/64;
            end
        end
    end
    if tempx(i,1)>3&&tempx(i,1)<11
        if tempx(i,2)>3&&tempx(i,2)<8
            [M] = robotCount(tempx);
            if M(7)>f(7)
                f(7)=M(7)/40;
            end
        end
    end
    if tempx(i,1)>11&&tempx(i,1)<23
        if tempx(i,2)>3&&tempx(i,2)<8
            [M] = robotCount(tempx);
            if M(8)>f(8)
                f(8)=M(8)/60;
            end
        end
    end
    if tempx(i,1)>23&&tempx(i,1)<31
        if tempx(i,2)>3&&tempx(i,2)<8
            [M] = robotCount(tempx);
            if M(9)>f(9)
                f(9)=M(9)/40;
            end
        end
    end
    
end
flow=sum(f);
end

