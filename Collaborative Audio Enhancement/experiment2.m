% Generate the slope deviation, deviation from straight line and cost of each overlap and compare it to the
% ground truth. This is done on noiseless signals.

function [audio_subsequences,ground_truth,slopeDev_matrix,cost_matrix,error_matrix] = experiment2(fileName)
%% Load and modify audio file

[y,Fs] = audioread(fileName);
y = mean(y,2);

%% Generate dataset

% audio_subsequences = Datagen2(y,Fs);
audio_subsequences = load('subseq1.txt');
l = length(audio_subsequences);

%% Generate Ground Truth
ground_truth = zeros([l l]);
for r1 = 1:l
    temp_var1 = audio_subsequences(r1,1);
    temp_var2 = audio_subsequences(r1,2);
    for r2 = 1:l
        temp_var3 = audio_subsequences(r2,1);
        if(temp_var1 <= temp_var3 && temp_var3 <= temp_var2)
            ground_truth(r1,r2) = 1;
        else
            ground_truth(r1,r2) = 0;
        end
    end
end
            
%% Generate cost and line deviation
cost_matrix = zeros([l l]);
error_matrix = zeros([l l]);
slopeDev_matrix = zeros([l l]);
for r3 = 1:l
    y1 = y(audio_subsequences(r3,1):audio_subsequences(r3,2));
    for r4 = 1:l
        y2 = y(audio_subsequences(r4,1):audio_subsequences(r4,2));
        D = euclalgo(y1,y2,Fs);
        [~,~,error,cost,slopeDev] = DTWmethodtemp(D);
        cost_matrix(r3,r4) = cost;
        error_matrix(r3,r4) = error;
        slopeDev_matrix(r3,r4) = slopeDev;
     end
end