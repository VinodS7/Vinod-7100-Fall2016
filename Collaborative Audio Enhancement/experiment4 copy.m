%RMS normalizing the audio files and performing experiment 2 except with
%noise and resampling. Noise range is in between -6dB to 6dB and resampling
%is between 44kHz to 44.2kHz

function [audio_subsequences,ground_truth,slopeDev_matrix,cost_matrix,error_matrix,alignment] = experiment4(fileName)
%% Load and modify audio file


[y,Fs] = audioread(fileName);
y = mean(y,2);


%% Generate dataset

audio_subsequences = Datagen2(y,Fs);
l = length(audio_subsequences);

%% Generate Ground Truth
ground_truth = GTgen(audio_subsequences);
            
%% Generate cost and line deviation
cost_matrix = zeros([l l]);
error_matrix = zeros([l l]);
slopeDev_matrix = zeros([l l]);
alignment = zeros([l l 4]);

for r3 = 1:l
    y1 = y(audio_subsequences(r3,1):audio_subsequences(r3,2));
    n1 = randi([-100 100]);
    n2 = randi([-6 6]);
%     y1 = resample(y1,Fs+n1,Fs);
%     y1 = awgn(y1,n2,'measured');
    y1 = applyDegradation('liveRecording',y1,Fs);
    y1 = applyDegradation('smartPhoneRecording',y1,Fs);
    for r4 = r3:l
        y2 = y(audio_subsequences(r4,1):audio_subsequences(r4,2));
        n3 = randi([-100 100]);
        n4 = randi([-6 6]);
%         y2 = resample(y2,Fs+n3,Fs);
%         y2 = awgn(y2,n4,'measured');
        y2 = applyDegradation('liveRecording',y2,Fs);
        y2 = applyDegradation('smartPhoneRecording',y2,Fs);
        D = euclalgo(y1,y2,Fs);
        [~,alignment(r3,r4,:),error1,cost1,slopeDev1] = DTWmethodtemp(D);
        [~,alignment(r4,r3,:),error2,cost2,slopeDev2] = DTWmethodtemp(D');
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