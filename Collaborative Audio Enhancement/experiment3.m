%RMS normalizing the audio files and performing experiment 2 except with
%noise and resampling. Noise range is in between -6dB to 6dB and resampling
%is between 44kHz to 44.2kHz

function [audio_subsequences,ground_truth,slopeDev_matrix,cost_matrix,error_matrix] = experiment3(fileName)
%% Load and modify audio file

[y,Fs] = audioread(fileName);
y = mean(y,2);


%% Generate dataset

audio_subsequences = Datagen2(y,Fs);
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
    n1 = randi([-100 100]);
    n2 = randi([-6 6]);
    y1 = resample(y1,Fs+n1,Fs);
    y1 = awgn(y1,n2,'measured');
    for r4 = r3:l
        y2 = y(audio_subsequences(r4,1):audio_subsequences(r4,2));
        n3 = randi([-100 100]);
        n4 = randi([-6 6]);
        y2 = resample(y2,Fs+n3,Fs);
        y2 = awgn(y2,n4,'measured');
        D = euclalgo(y1,y2,Fs);
        [~,~,error1,cost1,slopeDev1] = DTWmethodtemp(D);
        [~,~,error2,cost2,slopeDev2] = DTWmethodtemp(D');
        cost_matrix(r3,r4) = cost1;
        error_matrix(r3,r4) = error1;
        slopeDev_matrix(r3,r4) = slopeDev1;
        cost_matrix(r4,r3) = cost2;
        error_matrix(r4,r3) = error2;
        slopeDev_matrix(r4,r3) = slopeDev2;
     end
end