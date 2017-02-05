function [y12,costMatrix,pathPoints,error,cost,slopeDev,a1,a2] = audioReconstruction(filename1,filename2)

[y1,Fs] = audioread(filename1);
y1 = mean(y1,2);
[y2,~] = audioread(filename2);
y2 = mean(y2,2);
y1 = y1(Fs*142:Fs*162);
y2 = y2(Fs*42:Fs*62);
a1 = y1;
a2 = y2;
% y2 = applyDegradation('liveRecording',y2,Fs);
% y1 = applyDegradation('smartPhoneRecording',y1,Fs);

D = euclalgo(y1,y2,Fs);

[costMatrix,pathPoints,error,cost,slopeDev] = DTWmethodtemp(D);

n = round((pathPoints(end,1)-pathPoints(1,1)+1)*2048);

W = linspace(1,0,n)';                                    %'

y1(end-n+1:end) = y1(end-n+1:end).*W;
y2(1:n) = y2(1:n).*(1-W);
y12 = zeros(size(y1,1) + size(y2,1) - n, 1);
y12(1:size(y1,1)) = y1;
y12(end-size(y2,1)+1:end) = y12(end-size(y2,1)+1:end) + y2;


    
    