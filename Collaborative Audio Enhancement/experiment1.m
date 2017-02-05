% Try to find the generated subsequence in the audio sequence. The audio
% subsequence is altered using noise and resampling
function [res,array] = experiment1(audio_file)
%% Read audio file and generate dataset
[y,Fs] = audioread(audio_file);
y = mean(y,2);
array = Datagen2(y,Fs);

%% Generate features
X = abs(spectrogram(y,4096));
vpc1 = FeatureSpectralPitchChroma(X,Fs);
l = length(array);

%% Look for the subsesquences
% for r1 = 1:20
%     a = zeros([l 1]);
%     b = zeros([l 1]);
%     F = zeros([l 1]);
%     for r = 1:l
%         n = randi([-100 100]);
%         x = resample(y(array(r,1):array(r,2)),(Fs+n),Fs);
%         x = awgn(x,-30+r1*3,'measured');
%         D = euclalgo(vpc1,x,Fs);
%         [a(r),b(r)] = DTWmethod(D,Fs);
%         F(r) = Fs+n;
%     end
%     
%     res = [a b];
%     fileName2 = ['Results',num2str(r1),'.txt'];
%     fileID = fopen(fileName2,'w');
%     fprintf(fileID,'%6.4f %6.4f\n',res');
%     fclose(fileID);
% end
    a = zeros([l 1]);
    b = zeros([l 1]);
for r = 1:l
        n = randi([-100 100]);
        x = resample(y(array(r,1):array(r,2)),(Fs+n),Fs);
        x = awgn(x,0,'measured');
        D = euclalgo(vpc1,x,Fs);
        [a(r),b(r)] = DTWmethod(D,Fs);
end

res = [a b];
fileName2 = [num2str(0),'dB.txt'];
fileID = fopen(fileName2,'w');
fprintf(fileID,'%6.4f %6.4f\n',res');
fclose(fileID);
    
array = array/Fs;
fileName1 = 'Reference.txt';
fileID = fopen(fileName1,'w');
fprintf(fileID,'%6.4f %6.4f\n',array');
fclose(fileID);