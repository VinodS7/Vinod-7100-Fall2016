function [precision, recall, fmeasure] = binClassifierGMM(input_vector,ground_truth)

gm = fitgmdist(input_vector,2);
idx = cluster(gm,input_vector);
idx = buffer(idx,21);
idx = idx-1;

cp = classperf(ground_truth,idx);
DiagTable = cp.DiagnosticTable;

precision = DiagTable(1,1)/(DiagTable(1,1)+DiagTable(2,1));
recall = DiagTable(1,1)/(DiagTable(1,1)+DiagTable(1,2));
fmeasure = 2*precision*recall/(precision+recall);

if(precision <0.2)
    idx = 1-idx;
    cp = classperf(ground_truth,idx);
DiagTable = cp.DiagnosticTable;

precision = DiagTable(1,1)/(DiagTable(1,1)+DiagTable(2,1));
recall = DiagTable(1,1)/(DiagTable(1,1)+DiagTable(1,2));
fmeasure = 2*precision*recall/(precision+recall);
end