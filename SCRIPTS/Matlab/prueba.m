clear all
clc

[b,a] = butter(2,[0.125 1]/0.5); 

hd = design(fdesign.lowpass, 'butter')
fvtool(hd)


fs=0.5;
t=1:600;
dim=length(ts_anteriorcingulatedcortexmask_func);
ejefreq = [0:1/dim:(length(ts_anteriorcingulatedcortexmask_func)-1)/dim];
espectro = abs(fft(ts_anteriorcingulatedcortexmask_func));
espectro_norm = espectro./norm(espectro);
plot(ejefreq,espectro_norm)
a=fft(ts_csfmask_func); figure, plot(a)
a=fft(ts_csfmask_func); figure, plot(ejefreq,a)





Y=fft(j,NFFT)/L;

