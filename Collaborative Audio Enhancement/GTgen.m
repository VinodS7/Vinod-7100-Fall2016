function ground_truth = GTgen(subseq)
l = length(subseq);
for i = 1:l
    for j = 1:l
        if (subseq(j,1) <= subseq(i,2) && subseq(j,1) >= subseq(i,1) && subseq(i,2)>= subseq(j,2))
            x1 = subseq(j,1)-subseq(i,1)+1;
            y1 = subseq(j,2)-subseq(i,1)+1;
            x2 = 1;
            y2 = subseq(j,2) - subseq(j,1)+1;
        elseif (subseq(j,1) <= subseq(i,2) && subseq(j,1) >= subseq(i,1) && subseq(i,2) < subseq(j,2))
           x1 = subseq(j,1)-subseq(i,1)+1;
            y1 = subseq(i,2)-subseq(i,1)+1;
            x2 = 1;
            y2 = subseq(i,2) - subseq(j,1)+1;
        else
            x1 = NaN;
            y1 = NaN;
            x2 = NaN;
            y2 = NaN;
        end
        
ground_truth(i,j,:) = [x2 y2 x1 y1];
    end
end

ground_truth = reshape(ground_truth,[],4);


            