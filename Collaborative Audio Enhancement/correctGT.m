r1 = 1;
r2 = 1;
 for i = 1:1136
if(gtl(i) == 1 && l(i) == 1)
e1(r1,:) = gt(i,:) - p(i,:);
r1 = r1+1;
elseif(gtl(i) == 1 && l(i) ==0)
e2(r2,:) = gt(i,:) - p(i,:);
r2 = r2+1;
end
end