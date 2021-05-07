function [t,dis,path] = Floyd1(trajp)

% 生成图的邻接矩阵
t=zeros(length(trajp),length(trajp));
for j=1:9
    n1=[896 891 886 881 876 871 866 861 856];  
for i=1:17
    
    if mod(i,2)~=0
        t(n1(j),n1(j)-(91-10*(j-1)))=1;
        n1(j)=n1(j)-(91-10*(j-1));
    else
        t(n1(j),n1(j)-(9+10*(j-1)))=1;
        n1(j)=n1(j)-(9+10*(j-1));
    end
end
end
for j=1:9
    n2=[46 41 36 31 26 21 16 11 6];  
    
for i=1:17   
    if mod(i,2)~=0
        t(n2(j),n2(j)+(9+10*(j-1)))=1;
        n2(j)=n2(j)+(9+10*(j-1));
    else
        t(n2(j),n2(j)+(91-10*(j-1)))=1;
        n2(j)=n2(j)+(91-10*(j-1));
    end
end
end
for i=1:9
    t(100*i,100*i-99)=1;
end
for i=1:size(t,1)
    
        if ismember(i,[ 908:9:1224 909:9:1224])
            t(i,i-1)=1;
        end
        if ismember(i,[904:9:1224 905:9:1224 906:9:1224 907:9:1224 908:9:1224 909:9:1224])
            t(i,i-3)=1;
        end
        if ismember(i,[901:9:1224 904:9:1224 902:9:1224 905:9:1224 903:9:1224 906:9:1224])
            t(i,i+3)=1;
        end
        if i<900
            t(i,i+1)=1;
        end        
        
end
b1=[45:-5:5 100:100:900 895:-5:855 850:-100:50];b2=[46:-5:6 1:100:801 896:-5:856 851:-100:51];
for i=1:36
    t(b1(i),909+(i-1)*9)=1;
    t(907+(i-1)*9,b2(i))=1;
end

% Floyd
dis=t;
for  i=1:length(dis)
    for  j=1:length(dis)
        if dis(i,j)==0
            path(i,j)=-1;
        else
            path(i,j)=i;
        end
    end
end
for  i=1:length(dis)
    for  j=1:length(dis)
        if dis(i,j)==1
            dis(i,j)=norm(trajp(i,:)-trajp(j,:));
        else
            dis(i,j)=inf;
        end
        if i==j
            dis(i,j)=0;
        end
    end
end
n=length(dis);
for k=1:n
    for i=1:n
        for j=1:n
            if dis(i,j)>dis(i,k)+dis(k,j)
                dis(i,j)=dis(i,k)+dis(k,j);
                path(i,j)=k;
            end
        end
    end
end
end

