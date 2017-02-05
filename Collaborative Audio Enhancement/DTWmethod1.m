function [ya,yb,xa,xb,C] = DTWmethod1(D,Fs)

[l1,l2] = size(D);

C = zeros([l1+1 l2+1]);
C(:,1) = NaN;
C(1,:) = 0;
C(1,1) = 0;
C(2:(l1+1),2:(l2+1)) = D;

for i = 2:l1+1
    C(i,2) = C(i-1,2)+ C(i,2);
end


for i = 2:l1
    for j = 2:l2
        C(i+1,j+1) = min([C(i,j) C(i+1,j) C(i,j+1)]) + C(i+1,j+1);
    end
end

[v1,b1] = min(C(end,:));
temp = C(2:end,end);
tempI = 1:l1;
temp = temp./tempI';
[v2,b2] = min(temp);
b2 = b2+1;
[~,b] = min([v1,v2]);

if(b ==1)
    yb = b1;
    xb = l1+1;
else
    yb = l2+1;
    xb = b2;
end

i = xb;
j = yb;

while i>2 && j>2
    [~,I] = min([C(i-1,j-1) C(i,j-1) C(i-1,j)]);
    
    if(I == 1)
        i = i-1;
        j = j-1;
    elseif(I ==2)
        j = j-1;
    elseif(I ==3)
        i = i-1;
    end
end

xa =(i-1)*2048;
ya =(j-1)*2048;
xb = (xb-1)*2048;
yb = (yb-1)*2048;


