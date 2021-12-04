% This scripts demonstrates how to apply a butterwoth filter to a signal

clear, clc

% Generate signal data
%  Desired signal content
%   Frequencies
freq1 = 1;
freq2 = 2;
freq3 = 3;
%   Amplitudes
ampl1 = 3;
ampl2 = 2;
ampl3 = 1;

% Generate signal
%  X data (time)
x = 0:0.01:5;
%  Y data (signal)
y = ampl1*sin(freq1*6.28.*x) + ampl2*sin(freq2*6.28.*x) + ampl3*cos(freq3*6.28.*x);
%  Add some noise to the signal
y = y + 1.5*rand(size(x));
    
% Design Butterworth filter (Toolbox required)
cutFreq = 3;                    % Desired cut-off frequency (Hz)
sampligFreq = 1/mean(diff(x));  % Signal sampling rate       
wn = cutFreq/(0.5*sampligFreq); % Cut off frequency (CutoffFreq/NQistFreq)
[b,a] = butter(5,wn,'low');     % Low pass 5th order butterwoth filter coeffs.

% Filter the signal
yFilt = filtfilt(b,a,y);

% Compute fft
L = length(x);
%  fft x data
df = sampligFreq/L;
f  = df*(0:floor(L/2)-1);
% fft y data
yFft = detrend(yFilt,0);
yFft = abs(fft(yFft))/L;
yFft = 2*yFft(1:length(f));

% Plot results
%  Raw vs filterd signal
figure;
plot(y);
hold on;
plot(yFilt);
title('Raw vs filterd signal')
grid on, grid minor;
%  FFT
figure;
plot(f,yFft)
xlim([0 5])
title('FFT')
grid on, grid minor;