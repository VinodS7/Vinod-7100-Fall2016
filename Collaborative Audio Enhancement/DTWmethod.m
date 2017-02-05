function [a,b,C] = DTWmethod(D,Fs)

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

[~,b] = min(C(end,:));

while b<l2+1
    if(C(end,b) == C(end,b+1))
        b = b+1;
    else
        break;
    end
end

i = l1+1;
j = b;

while i>2 
    if(j>2)
    [~,I] = min([C(i-1,j-1) C(i,j-1) C(i-1,j)]);
    
    if(I == 1)
        i = i-1;
        j = j-1;
    elseif(I ==2)
        j = j-1;
    elseif(I ==3)
        i = i-1;
    end
    else
        break;
    end
end

a = (j-1)*2048/Fs;
b = (b-1)*2048/Fs;
C = C(2:end,2:end);
        
        

    