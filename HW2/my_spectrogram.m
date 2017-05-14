function s_image = my_spectrogram(audio_file_name, cut_duration)
% my_spectrogram: plot the spectrogram of the target audio file
% input:
% audio_file_name
% cut_duration
%
% output:
% s_image

%% Initialize
[y_input, samplerate] = audioread(audio_file_name);
y_input_cut = y_input(1 : samplerate * cut_duration);

segment_time = 50; % the time length of each divided short segment from the target audio is "split_time" ms
segment_duration = segment_time / 1000 * samplerate; % convert segment_time to segment_duration using samplerate
segment_overlap = segment_duration / 2; % each divided short segment would overlaps half of the previous segment

%% Plot the spectrogram
[S, F, T] = my_stft(y_input_cut, segment_duration, segment_overlap, samplerate); % you need to implement the details of "my_stft" function
log_s = log(abs(S)); % logarithm of the spectrogram

% Normalize the spectrogram
max_s = max(max(log_s));
min_s = min(min(log_s));
log_s = (log_s - min_s) / (max_s - min_s);

% Plot the spectrogram image
figure;
imagesc(T, F, log_s);
axis off;
set(gca, 'YDir', 'normal');
title(audio_file_name);

%% Get the frame from the figure
frame = getframe;
s_image = rgb2gray(frame.cdata);

