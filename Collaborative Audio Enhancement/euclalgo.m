function D = euclalgo(X,x,Fs)

X = abs(spectrogram(X,4096));
x = abs(spectrogram(x,4096));

vpc1 = FeatureSpectralPitchChroma(X,Fs);
vpc2 = FeatureSpectralPitchChroma(x,Fs);

D = pdist2(vpc2',vpc1');    
 
        
            
        
        
        