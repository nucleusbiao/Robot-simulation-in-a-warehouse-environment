function s = ifoccupy(x,p)
%判断某个位置是否停有车量
s=0;
for i=1:size(x,1)
    if p(1)==x(i,1)&&p(2)==x(i,2)
        s=1;
    end
end
end

