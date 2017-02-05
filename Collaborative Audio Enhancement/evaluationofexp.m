function evaluationofexp

files=  dir('Songs/live*.wav');

r = 60;
[subseq,GT,SD,CM,EM,path] = experiment4(files(r).name);

fileName1 = ['subseq',num2str(r),'.txt'];
fileName2 = ['GT',num2str(r),'.txt'];
fileName3 = ['SD',num2str(r),'.txt'];
fileName4 = ['CM',num2str(r),'.txt'];
fileName5 = ['EM',num2str(r),'.txt'];
fileName6 = ['path',num2str(r),'.txt'];

fid = fopen(fileName1, 'wt'); % Open for writing
for i=1:size(subseq,1)
   fprintf(fid, '%d ', subseq(i,:));
   fprintf(fid, '\n');
end
fclose(fid);

fid = fopen(fileName2, 'wt'); % Open for writing
for i=1:size(GT,1)
   fprintf(fid, '%d ', GT(i,:));
   fprintf(fid, '\n');
end
fclose(fid);

fid = fopen(fileName3, 'wt'); % Open for writing
for i=1:size(SD,1)
   fprintf(fid, '%d ', SD(i,:));
   fprintf(fid, '\n');
end
fclose(fid);

fid = fopen(fileName4, 'wt'); % Open for writing
for i=1:size(CM,1)
   fprintf(fid, '%d ', CM(i,:));
   fprintf(fid, '\n');
end
fclose(fid);

fid = fopen(fileName5, 'wt'); % Open for writing
for i=1:size(EM,1)
   fprintf(fid, '%d ', EM(i,:));
   fprintf(fid, '\n');
end
fclose(fid);

fid = fopen(fileName6, 'wt'); % Open for writing
for i=1:size(path,1)
   fprintf(fid, '%d ', path(i,:));
   fprintf(fid, '\n');
end
fclose(fid);
