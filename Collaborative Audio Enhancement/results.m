function [res1,res2,res3,res4,res5,res6,res7] = results
res1 = [];
res2 = [];
res3 = [];
res4 = [];
res5 = [];
res6 = [];
res7 = [];

for r = 11:25;
   
    filename1 = ['GT' num2str(r) '.txt'];
    filename2 = ['SD' num2str(r) '.txt'];
    filename3 = ['EM' num2str(r) '.txt'];
    filename4 = ['CM' num2str(r) '.txt'];
    GT = load (filename1);
    SD = load (filename2);
    EM = load (filename3);
    CM = load (filename4);
    
    metric1 = SD;
    metric1(metric1>0.025) = 1;
    metric1(metric1<=0.025) = 0;
    metric1 = 1-metric1;
    X1 = GT-metric1;
    a = unique(X1);
    out1 = [a,histc(X1(:),a)];
    
    res1(r) = out1(2,2)/441;
    
    metric2 = EM;
    metric2(metric2>0.025) = 1;
    metric2(metric2<=0.025) = 0;
    metric2 = 1-metric2;
    X2 = GT-metric2;
    b = unique(X2);
    out2 = [b,histc(X2(:),b)];
    res2(r) = out2(2,2)/441;
    
    metric3 = CM;
    metric3(metric3>0.025) = 1;
    metric3(metric3<=0.025) = 0;
    metric3 = 1-metric3;
    X3 = GT-metric3;
    c = unique(X3);
    out3 = [c,histc(X3(:),c)];
    res3(r) = out3(2,2)/441;
    
    metric4 = sqrt(SD.*EM);
    metric4(metric4>0.025) = 1;
    metric4(metric4<=0.025) = 0;
    metric4 = 1-metric4;
    X4 = GT-metric4;
    d = unique(X4);
    out4 = [d,histc(X4(:),d)];
    res4(r) = out4(2,2)/441;
    
    metric5 = sqrt(EM.*CM);
    metric5(metric5>0.025) = 1;
    metric5(metric5<=0.025) = 0;
    metric5 = 1-metric5;
    X5 = GT-metric5;
    e = unique(X5);
    out5 = [e,histc(X5(:),e)];
    res5(r) = out5(2,2)/441;
    
    metric6 = sqrt(CM.*SD);
    metric6(metric6>0.05) = 1;
    metric6(metric6<=0.05) = 0;
    metric6 = 1-metric6;
    X6 = GT-metric6;
    f = unique(X6);
    out6 = [f,histc(X6(:),f)];
    res6(r) = out6(2,2)/441;
    
    metric7 = nthroot(CM.*SD.*EM,3);
    metric7(metric7>0.45) = 1;
    metric7(metric7<=0.45) = 0;
    metric7 = 1-metric7;
    X7 = GT-metric7;
    g = unique(X7);
    out7 = [g,histc(X7(:),g)];
    res7(r) = out7(2,2)/441;
    
    end
    