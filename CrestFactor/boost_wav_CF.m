%Vboost , Vboost cap comparison on .wav

clear
clc
close all
 
%static variables
%Fs is loaded to workspace from .mat file above

Rl = 13;                                         %load resistance
eff_amp = 0.9;                                  %efficiency of amplifier
eff_boost = 0.9;                                %efficiency of boost converter
Vin = 2.5;                                        %set VBAT voltage in Volts
ILIM = 1.2;                                     %set central boost ILIM in Amps

boost_V_nom = 10;%10_6.5;                             %nominal boost output voltage in Volts, central boost
E_amp_gain = 1.5/0.08;
R_bat_trace = 0.5;
R_bat_source = 0.05;
Rdson_output = 0.1;
line_width = 1;
A_clip = 0.1;
clip_tolerance = 0.0001;

cap_array = [];
cap_array(1) = 3.92*10^-6;
cap_array(2) = cap_array(1) + 10*10^-6;
cap_array(3) = cap_array(1) + 22*10^-6;
% cap_array(4) = cap_array(1) + 33*10^-6;
% cap_array(5) = cap_array(1) + 47*10^-6;
% cap_array(6) = cap_array(1) + 56*10^-6;
% cap_array(7) = cap_array(1) + 68*10^-6;
% cap_array_size = nnz(cap_array);
cap=cap_array(3);
capuF=cap*1e6;
capuF=round(capuF);
Pout_array = [];

Fs = 0.5*10^6;                                  %Boost Fsw, supposed to be 2MHz (use 0.5MHz to save time)
Ts = 1/Fs;                                      %sample period in Seconds

%read .wav
[y,Fwav]=audioread('PostProcessed.wav');
CrestF=20*log10(max(y)/rms(y))

%CF windowing
CrestFarray=[];
%use windows of 50ms, find number of samples = 50ms
bb=1;
figure;
WindLeng=0.05*Fwav;
for ii=20e4:length(y)-WindLeng-1e4
    y1=y(ii:ii+WindLeng-1);    
    CrestF=20*log10(max(y1)/rms(y1));
    CrestFarray(bb)=CrestF;
    bb=bb+1;
%     plot(y1);        uncomment this to view CF video     
%     aa=sprintf('CrestFactor =%.2f dB',CrestF);
%     title(aa);
%     ylim([-1 1]);
%     pause(0.0001);
end
plot(CrestFarray);
aa=sprintf('CrestFactor for moving window length 50ms');
title(aa);

%find FFT
T = 1/Fwav;                     % Sample time
L = length(y);         % Length of signal
t = (0:L-1)*T;                % Time vector

NFFT = 2^15;%32768;%2^nextpow2(L); % Next power of 2 from length of y

y_window=y(1:NFFT);
Y = fft(y_window,NFFT)/length(y_window);
f = Fwav/2*linspace(0,1,NFFT/2+1);
Y_half=2*abs(Y(1:NFFT/2+1));

% Plot single-sided amplitude spectrum.
figure;
plot(f,Y_half); 
%semilogx(f,Y_half); 
hold on;
outputStringa=sprintf('Single-Sided Amplitude Spectrum of Voice .wav');
title(outputStringa);
xlabel('Frequency (Hz)');
ylabel('|Y(f)|');
