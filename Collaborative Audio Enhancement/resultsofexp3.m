function [p,r,f] = resultsofexp3
p = [];
r = [];
f = [];
% for i = 1:25
%  filename1 = ['GT' num2str(i) '.txt'];
%     filename2 = ['SD' num2str(i) '.txt'];
%     filename3 = ['EM' num2str(i) '.txt'];
%     filename4 = ['CM' num2str(i) '.txt'];
%     GT = load (filename1);
%     SD = load (filename2);
%     EM = load (filename3);
%     CM = load (filename4);
%     
%     GT = GT(:);
%     SD = SD(:);
%     EM = EM(:);
%     CM = CM(:);
%     
%     [p(i),r(i),f(i)] = binClassifierGMM(SD,GT);
%     
%     
% end   
input_vector = [];
ground_truth1 = [];
for i1 = 11:24
 filename1 = ['GT' num2str(i1) '.txt'];
    filename2 = ['SD' num2str(i1) '.txt'];
    GT = load (filename1);
    SD = load (filename2);
    GT = GT(:);
    SD = SD(:);
    
    input_vector = [input_vector; SD];
    ground_truth1 = [ground_truth1; GT];
    
end 

SVMmodel = fitcsvm(input_vector,ground_truth1);

pred_data = [];
ground_truth2 = [];
for i2 = 24:25
    filename1 = ['GT' num2str(i1) '.txt'];
    filename2 = ['SD' num2str(i1) '.txt'];
    
    GT = load (filename1);
    SD = load (filename2);
    
    GT = GT(:);
    SD = SD(:);
    
    pred_data = [pred_data; SD];
    ground_truth2 = [ground_truth2; GT];
    
end 
label = predict(SVMmodel,pred_data);

cp = classperf(ground_truth2,label);
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
p = precision;
r = recall;
f = fmeasure;