%%% HW2_Q1.m - Complete the procedure of separating HW2_mix.wav into 3 songs

%% Clean variables and screen
close all;
clear;
clc;

%% Visualization parameters (Change it if you want)
% Some Tips:
% (Tip 1) You can change the axis range to make the plotted result more clearly 
% (Tip 2) You can use subplot function to show multiple spectrums / shapes in one figure
titlefont = 15;
fontsize = 13;
LineWidth = 1.5;

%% 1. Read in input audio file ( audioread )
% y_input: input signal, fs: sampling rate
[y_input, fs] = audioread('audio/HW2_Mix.wav');

%%% Plot example : plot the input audio
% The provided function "make_spectrum" generates frequency
% and magnitude. Use the following example to plot the spectrum.
[frequency, magnitude] = make_spectrum(y_input, fs);
plot(frequency, magnitude, 'LineSmoothing', 'on', 'LineWidth', LineWidth);
axis([0, 1750, -inf, inf]); 
% change the x-axis range to 1750
title('Oringinal Mix Input', 'fontsize', titlefont);
set(gca, 'fontsize', fontsize);

%% 2. Filtering 
% (Hint) Implement my_filter here
N=1000;
[out_low, fltr_low] = my_filter(y_input, fs, N, 'Blackman', 'low-pass', 350);
[out_band, fltr_band] = my_filter(y_input, fs, N, 'Blackman', 'high-pass', 800);
[out_high, fltr_high] = my_filter(y_input, fs, N, 'Blackman', 'bandpass', [400,800]);

%%play the audio%%
%sound(out_low, fs);sound(out_band, fs);sound(out_high, fs);

%%% Plot the shape of filters in Time domain
time_low=(1:length(fltr_low))/fs; 
time_band=(1:length(fltr_band))/fs; 
time_high=(1:length(fltr_high))/fs; 
figure;
subplot(3,1,1), plot(time_low, fltr_low); 
title('Shape of low-pass filter (time domain)', 'fontsize', titlefont);    
subplot(3,1,2), plot(time_band, fltr_band);
title('Shape of high-pass filter (time domain)', 'fontsize', titlefont);
subplot(3,1,3), plot(time_high, fltr_high);    
title('Shape of bandpass filter (time domain)', 'fontsize', titlefont);
    
%%% Plot the spectrum of filters (Frequency Analysis)
[fqc_low, mag_low] = make_spectrum(fltr_low, fs);
[fqc_band, mag_band] = make_spectrum(fltr_band, fs);
[fqc_high, mag_high] = make_spectrum(fltr_high, fs);
figure;
subplot(3,1,1), plot(fqc_low, mag_low); axis([0, 1750, -inf, inf]);
title('Spectrum of low-pass filter', 'fontsize', titlefont);
subplot(3,1,2), plot(fqc_band, mag_band); axis([0, 1750, -inf, inf]);
title('Spectrum of high-pass filter', 'fontsize', titlefont);
subplot(3,1,3), plot(fqc_high, mag_high); axis([0, 1750, -inf, inf]);
title('Spectrum of bandpass filter', 'fontsize', titlefont);
    


%% 3. Save the filtered audio (audiowrite)
% Name the file 'FilterName_para1_para2.wav'
% para means the cutoff frequency that you set for the filter
audiowrite('low-pass_350.wav', out_low, fs);
audiowrite('bandpass_400_800.wav', out_band, fs);
audiowrite('high-pass_800.wav', out_high, fs);

%%% Plot the spectrum of filtered signals
[out_fqc_low, out_mag_low] = make_spectrum(out_low, fs);
[out_fqc_band, out_mag_band] = make_spectrum(out_band, fs);
[out_fqc_high, out_mag_high] = make_spectrum(out_high, fs);
figure;
subplot(3,1,1), plot(out_fqc_low, out_mag_low); axis([0, 1750, -inf, inf]);
title('Spectrum of low-pass output', 'fontsize', titlefont);
subplot(3,1,2), plot(out_fqc_band, out_mag_band); axis([0, 1750, -inf, inf]);
title('Spectrum of high-pass output', 'fontsize', titlefont);
subplot(3,1,3), plot(out_fqc_high, out_mag_high); axis([0, 1750, -inf, inf]);
title('Spectrum of bandpass output', 'fontsize', titlefont);

