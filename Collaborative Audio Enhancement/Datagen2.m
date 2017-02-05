%Generates subsequence audio clips that covers the entire length of the
%original audio file

function [audio_clips] = Datagen2(y,Fs)
%% Choose number of starting points
length_audio = length(y);
numStartingPoints = 2;
% n = randi([round(l/10/Fs) round(l/Fs)]);

%% Randonly generate values of starting points

startPoints = zeros([1 numStartingPoints]);

for r1 = 1:numStartingPoints
    startPoints(r1) = randi([1 length_audio-10*Fs]);   
end

startPoints = sort(startPoints);

if(startPoints(1) ~= 1)
    startPoints = [1;startPoints'];
end

%% Randomly generate end points 

endPoints = zeros([1 length(startPoints)-1]);

for r2 = 1:length(startPoints)-1
    if(startPoints(r2+1) - startPoints(r2) > 10*Fs)
        endPoints(r2) = randi([startPoints(r2+1) length_audio]);
    elseif(startPoints(r2+1) - startPoints(r2) < 10*Fs)
        endPoints(r2) = randi([startPoints(r2)+10*Fs length_audio]);
    end
end

endPoints = [endPoints';length_audio];
audio_clips = [startPoints endPoints];