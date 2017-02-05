function [ground_truth,input_vector4,label,ground_truth_label,DiagTable7] = mycrossval

input_vector1 = [];
input_vector2 = [];
input_vector3 = [];
input_vector4 = [];
ground_truth = [];
for i = 50:75
if(i ==62)
continue
end
    GT = load (['GT' num2str(i) '.txt']);
    SD = load (['SD' num2str(i) '.txt']);
    CM = load (['CM' num2str(i) '.txt']);
    EM = load (['EM' num2str(i) '.txt']);
    path = load (['path' num2str(i) '.txt']);   
    
    
%     GT = GT(:);
    SD = SD(:);
    CM = CM(:);
    EM = EM(:);
    
    input_vector1 = [input_vector1; SD];
    ground_truth = [ground_truth; GT];
    input_vector2 = [input_vector2; CM];
    input_vector3 = [input_vector3; EM];
    input_vector4 = [input_vector4; path];
end  
ground_truth_label = ground_truth;
ground_truth_label(isnan(ground_truth_label)) = 0;
ground_truth_label(ground_truth_label ~= 0) = 1;
ground_truth_label = ground_truth_label(:,1);
% input_vector1 = (input_vector1-min(input_vector1))/(max(input_vector1)-min(input_vector1));
% input_vector2 = (input_vector2-min(input_vector2))/(max(input_vector2)-min(input_vector2));
% input_vector3 = (input_vector3-min(input_vector3))/(max(input_vector3)-min(input_vector3));

   input_vector = input_vector1; 
    p = 60;
% SVMModel1 = fitcsvm([input_vector1(1:round(length(input_vector)*p/100)) ],ground_truth_label(1:round(length(input_vector)*p/100)));
%     label = predict(SVMModel1,[input_vector1(round(length(input_vector)*p/100)+1:end)] );
%     cp = classperf(ground_truth_label(round(length(input_vector)*p/100)+1:end),label,'Positive',1,'Negative',0);
%     DiagTable1 = cp.DiagnosticTable;
%     
% SVMModel2 = fitcsvm([input_vector2(1:round(length(input_vector)*p/100)) ],ground_truth_label(1:round(length(input_vector)*p/100)));
%     label = predict(SVMModel2,[input_vector2(round(length(input_vector)*p/100)+1:end)] );
%     cp = classperf(ground_truth_label(round(length(input_vector)*p/100)+1:end),label,'Positive',1,'Negative',0);
%     DiagTable2 = cp.DiagnosticTable;
% 
% SVMModel3 = fitcsvm([input_vector3(1:round(length(input_vector)*p/100)) ],ground_truth_label(1:round(length(input_vector)*p/100)));
%     label = predict(SVMModel3,[input_vector3(round(length(input_vector)*p/100)+1:end)] );
%     cp = classperf(ground_truth_label(round(length(input_vector)*p/100)+1:end),label,'Positive',1,'Negative',0);
%     DiagTable3 = cp.DiagnosticTable;
% 
%     SVMModel4 = fitcsvm([input_vector1(1:round(length(input_vector)*p/100)) input_vector2(1:round(length(input_vector)*p/100)) ],ground_truth_label(1:round(length(input_vector)*p/100)));
%     label = predict(SVMModel4,[input_vector1(round(length(input_vector)*p/100)+1:end) input_vector2(round(length(input_vector)*p/100)+1:end) ]);
%     cp = classperf(ground_truth_label(round(length(input_vector)*p/100)+1:end),label,'Positive',1,'Negative',0);
%     DiagTable4 = cp.DiagnosticTable;
%     
% SVMModel5 = fitcsvm([input_vector1(1:round(length(input_vector)*p/100))  input_vector3(1:round(length(input_vector)*p/100))],ground_truth_label(1:round(length(input_vector)*p/100)));
%     label = predict(SVMModel5,[input_vector1(round(length(input_vector)*p/100)+1:end)  input_vector3(round(length(input_vector)*p/100)+1:end)]);
%     cp = classperf(ground_truth_label(round(length(input_vector)*p/100)+1:end),label,'Positive',1,'Negative',0);
%     DiagTable5 = cp.DiagnosticTable;
%     
% SVMModel6 = fitcsvm([ input_vector2(1:round(length(input_vector)*p/100)) input_vector3(1:round(length(input_vector)*p/100))],ground_truth_label(1:round(length(input_vector)*p/100)));
%     label = predict(SVMModel6,[ input_vector2(round(length(input_vector)*p/100)+1:end) input_vector3(round(length(input_vector)*p/100)+1:end)]);
%     cp = classperf(ground_truth_label(round(length(input_vector)*p/100)+1:end),label,'Positive',1,'Negative',0);
%     DiagTable6 = cp.DiagnosticTable;
%     
% 
    SVMModel7 = fitcsvm([input_vector1(1:round(length(input_vector)*p/100)) input_vector2(1:round(length(input_vector)*p/100)) input_vector3(1:round(length(input_vector)*p/100))],ground_truth_label(1:round(length(input_vector)*p/100)));
    label = predict(SVMModel7,[input_vector1(round(length(input_vector)*p/100)+1:end) input_vector2(round(length(input_vector)*p/100)+1:end) input_vector3(round(length(input_vector)*p/100)+1:end)]);
    cp = classperf(ground_truth_label(round(length(input_vector)*p/100)+1:end),label,'Positive',1,'Negative',0);
    DiagTable7 = cp.DiagnosticTable;
%     
% p1 = DiagTable1(1,1)/sum(DiagTable1(1,:));
% r1 = DiagTable1(1,1)/sum(DiagTable1(:,1));
% f1 = 2*p1*r1/(p1+r1);
% 
% p2 = DiagTable2(1,1)/sum(DiagTable2(1,:));
% r2 = DiagTable2(1,1)/sum(DiagTable2(:,1));
% f2 = 2*p2*r2/(p2+r2);
% 
% p3 = DiagTable3(1,1)/sum(DiagTable3(1,:));
% r3 = DiagTable3(1,1)/sum(DiagTable3(:,1));
% f3 = 2*p3*r3/(p3+r3);
% 
% p4 = DiagTable4(1,1)/sum(DiagTable4(1,:));
% r4 = DiagTable4(1,1)/sum(DiagTable4(:,1));
% f4 = 2*p4*r4/(p4+r4);
% 
% p5 = DiagTable5(1,1)/sum(DiagTable5(1,:));
% r5 = DiagTable5(1,1)/sum(DiagTable5(:,1));
% f5 = 2*p5*r5/(p5+r5);
% 
% p6 = DiagTable6(1,1)/sum(DiagTable6(1,:));
% r6 = DiagTable6(1,1)/sum(DiagTable6(:,1));
% f6 = 2*p6*r6/(p6+r6);
% 
% p7 = DiagTable7(1,1)/sum(DiagTable7(1,:));
% r7 = DiagTable7(1,1)/sum(DiagTable7(:,1));
% f7 = 2*p7*r7/(p7+r7);
% 
% p = [p1 p2 p3 p4 p5 p6 p7];
% r = [r1 r2 r3 r4 r5 r6 r7];
% f = [f1 f2 f3 f4 f5 f6 f7];
% 
