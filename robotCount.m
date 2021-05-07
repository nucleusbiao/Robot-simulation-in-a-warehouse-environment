function [M] = robotCount(x)
%计算各个区域中机器人的数量

M=zeros(1,9);
for i=1:size(x,1)
    if x(i,1)>2&&x(i,1)<11
        if x(i,2)>16&&x(i,2)<21
            M(1)=M(1)+1;
        end
    end
    if x(i,1)>11&&x(i,1)<23
        if x(i,2)>16&&x(i,2)<21
            M(2)=M(2)+1;
        end
    end    
     if x(i,1)>23&&x(i,1)<31
        if x(i,2)>16&&x(i,2)<21
            M(3)=M(3)+1;
        end
     end
    if x(i,1)>2&&x(i,1)<11
        if x(i,2)>8&&x(i,2)<16
            M(4)=M(4)+1;
        end
    end
    if x(i,1)>11&&x(i,1)<23
        if x(i,2)>8&&x(i,2)<16
            M(5)=M(5)+1;
        end
    end    
     if x(i,1)>23&&x(i,1)<31
        if x(i,2)>8&&x(i,2)<16
            M(6)=M(6)+1;
        end
    end   
    if x(i,1)>2&&x(i,1)<11
        if x(i,2)>2&&x(i,2)<8
            M(7)=M(7)+1;
        end
    end    
    if x(i,1)>11&&x(i,1)<23
        if x(i,2)>2&&x(i,2)<8
            M(8)=M(8)+1;
        end
    end    
     if x(i,1)>23&&x(i,1)<31
        if x(i,2)>2&&x(i,2)<8
            M(9)=M(9)+1;
        end
    end     
    
    
    
end

