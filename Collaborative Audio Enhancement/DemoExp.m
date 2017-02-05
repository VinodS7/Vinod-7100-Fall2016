function [audio_subsequences,ground_truth,slopeDev_matrix,cost_matrix,error_matrix,alignment,fadePoint] = DemoExp(fileName)
%% Load and modify audio file


[y,Fs] = audioread(fileName);
y = mean(y,2);

y = y(Fs*45:Fs*75);
%% Generate dataset

audio_subsequences = Datagen2(y,Fs);
l = length(audio_subsequences);

for r1 = 1:length(audio_subsequences)
    ytemp = y(audio_subsequences(r1,1):audio_subsequences(r1,2));
    n1 = randi([-100 100]);
    n2 = randi([0 10]);
%     ytemp = resample(ytemp,Fs+n1,Fs);
%     ytemp = awgn(ytemp,n2,'measured');
%     ytemp = applyDegradation('liveRecording',ytemp,Fs);
%     ytemp = applyDegradation('smartPhoneRecording',ytemp,Fs);
    yn{r1} = ytemp;
    
end
    %% Generate Ground Truth
ground_truth = GTgen(audio_subsequences);
            
%% Generate cost and line deviation
cost_matrix = zeros([l l]);
error_matrix = zeros([l l]);
slopeDev_matrix = zeros([l l]);
alignment = zeros([l l 4]);
fadePoint = zeros([l l 2]);

for r3 = 1:l
    y1 = yn{r3};
    
    for r4 = r3:l
        y2 = yn{r4};
        D = euclalgo(y1,y2,Fs);
        [fadePoint(r3,r4,:),alignment(r3,r4,:),error1,cost1,slopeDev1] = DTWmethoddemo(D);
        [fadePoint(r3,r4,:),alignment(r4,r3,:),error2,cost2,slopeDev2] = DTWmethoddemo(D');
        cost_matrix(r3,r4) = cost1;
        error_matrix(r3,r4) = error1;
        slopeDev_matrix(r3,r4) = slopeDev1;
        cost_matrix(r4,r3) = cost2;
        error_matrix(r4,r3) = error2;
        slopeDev_matrix(r4,r3) = slopeDev2;
     end
end
alignment = reshape(alignment,[],4);
alignment = alignment.*2048;
fadePoint = reshape(fadePoint,[],2);
fadePoint = fadePoint.*2048;
y1 = yn{1};
y2 = yn{2};
y3 = yn{3};
n1 = mean([alignment(8,2)-alignment(8,1) alignment(8,4)- alignment(8,3)]);
W = linspace(1,0,2048); 
n1 = round(n1)/2-2048;
W = padarray(W',n1,'replicate','both');
n1 = length(W);
y2(end-n1+1:end) = y2(end-n1+1:end).*W;
y3(1:n1) = y3(1:n1).*(1-W);
y23 = zeros(size(y2,1) + size(y3,1) - n1, 1);
y23(1:size(y2,1)) = y2;
y23(end-size(y3,1)+1:end) = y23(end-size(y3,1)+1:end) + y3;
n2 = mean([alignment(4,2)-alignment(4,1) alignment(4,4)- alignment(4,3)]);
W = linspace(1,0,2048); 
n2 = round(n2)/2-2048;
W = padarray(W',n2,'replicate','both');
n2 = length(W);
y1(end-n2+1:end) = y1(end-n2+1:end).*W;
y23(1:n2) = y23(1:n2).*(1-W);
y123 = zeros(size(y1,1) + size(y23,1) - n2, 1);
y123(1:size(y1,1)) = y1;
y123(end-size(y23,1)+1:end) = y123(end-size(y23,1)+1:end) + y23;
audiowrite('demo_reconstructed.wav',y123,Fs);
audiowrite('demo_file1.wav',yn{1},Fs);
audiowrite('demo_file2.wav',yn{2},Fs);
audiowrite('demo_file3.wav',yn{3},Fs);
