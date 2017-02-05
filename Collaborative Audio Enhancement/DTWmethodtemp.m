
%The function identifies if audio clip 1 is a subsequence or overlapped 
%with audio clip 2. It is not an exhaustive check since it does not take 
%care of both types of overlap and cannot tell if audio clip 2 is a subsequence of audio clip 1.                                 

function [costMatrix,alignment,error,cost,slopeDev] = DTWmethodtemp(D)
%% Identify the dimensions of the distance matrix(D)
[l1,l2] = size(D);

%% Initializing the cost matrix from the distance matrix.
costMatrix = zeros([l1+1 l2+1]);
costMatrix(:,1) = NaN;
costMatrix(1,:) = 0;
costMatrix(1,1) = 0;
costMatrix(2:(l1+1),2:(l2+1)) = D;

%% Calculating the cost matrix
for i = 2:l1+1
    costMatrix(i,2) = costMatrix(i-1,2)+ costMatrix(i,2);
end


for i = 2:l1
    for j = 2:l2
        costMatrix(i+1,j+1) = min([costMatrix(i,j) costMatrix(i+1,j) costMatrix(i,j+1)]) + costMatrix(i+1,j+1);
    end
end

%% Identify the end point of the least cost path
[cost1,index1] = min(costMatrix(end,:));

temp = costMatrix(30:end,end);
tempI = 29:l1;
temp = temp./tempI';

[cost2,index2] = min(temp);
index2 = index2+29;
cost2 = cost2*index2;


    

%% Identify the path for bottom row
yb = index1;
xb = l1+1;

pathLength1 = 0;
costMatrix = costMatrix(2:end,2:end);
i = xb-1;
j = yb-1;

pathPoints1(pathLength1+1,1) = i;
pathPoints1(pathLength1+1,2) = j;

while i>1 && j>1
    [~,I] = min([costMatrix(i-1,j-1) costMatrix(i,j-1) costMatrix(i-1,j)]);
    
    pathLength1 = pathLength1+1;
       
    if(I == 1)
        i = i-1;
        j = j-1;
    elseif(I ==2)
        j = j-1;
    elseif(I ==3)
        i = i-1;
    end
    pathPoints1(pathLength1+1,1) = i;
    pathPoints1(pathLength1+1,2) = j;

end
%% Identify the path for last column
yb = l2+1;
xb = index2;

pathLength2 = 0;
i = xb-1;
j = yb-1;

pathPoints2(pathLength2+1,1) = i;
pathPoints2(pathLength2+1,2) = j;

while i>1 && j>1
    [~,I] = min([costMatrix(i-1,j-1) costMatrix(i,j-1) costMatrix(i-1,j)]);
    
    pathLength2 = pathLength2+1;
       
    if(I == 1)
        i = i-1;
        j = j-1;
    elseif(I ==2)
        j = j-1;
    elseif(I ==3)
        i = i-1;
    end
    pathPoints2(pathLength2+1,1) = i;
    pathPoints2(pathLength2+1,2) = j;

end

%% Derive the features which is normalized cost and standard deviation of line

pathPoints2 = flip(pathPoints2,1);

startPoint2 = [pathPoints2(1,1) pathPoints2(1,2)]; 
endPoint2 = [pathPoints2(end,1) pathPoints2(end,2)];
err2 = zeros([1 length(pathPoints2)]);


for r = 1:length(pathPoints2)
    err2(r) = abs(det([endPoint2-startPoint2;pathPoints2(r,:)-startPoint2]))/abs(norm(endPoint2-startPoint2));
end
error2 = mean(err2);
cost2 = cost2/pathLength2;
slopeDev2 = abs(1-(startPoint2(2) - endPoint2(2))/(startPoint2(1) - endPoint2(1)));        
%% Derive the features which is normalized cost and standard deviation of line


pathPoints1 = flip(pathPoints1,1);

startPoint1 = [pathPoints1(1,1) pathPoints1(1,2)]; 
endPoint1 = [pathPoints1(end,1) pathPoints1(end,2)];
err1 = zeros([1 length(pathPoints1)]);


for r = 1:length(pathPoints1)
    err1(r) = abs(det([endPoint1-startPoint1;pathPoints1(r,:)-startPoint1]))/abs(norm(endPoint1-startPoint1));
end
error1 = mean(err1);
cost1 = cost1/pathLength1;
slopeDev1 = abs(1-(startPoint1(2) - endPoint1(2))/(startPoint1(1) - endPoint1(1))); 
%% Compare the two path features
if (slopeDev1 <= slopeDev2)
    error = error1;
    cost = cost1;
    slopeDev = slopeDev1;
    pathPoints = pathPoints1;
else
    error = error2;
    cost = cost2;
    slopeDev = slopeDev2;
    pathPoints = pathPoints2;
end

alignment = [pathPoints(1,1); pathPoints(end,1); pathPoints(1,2); pathPoints(end,2)];
