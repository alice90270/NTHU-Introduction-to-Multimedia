function [S, F, T] = my_stft(x, segment_duration, segment_overlap, fs)
% my_stft:
% input
% x: The target signal.
% segment_duration: The number of samples of each segment.
% segment_overlap: The number of samples overlapping on two adjacent segments.
%
% output
% S: Short-time Fourier transform, returned as a matrix. Time increases across the columns of S and frequency increases down the rows, starting from zero.
% F: Cyclical frequencies, returned as a vector. F has a length equal to the number of rows of S.
% T: Time instants, returned as a vector. The time values in T correspond to the midpoint of each segment.

%% Your implementation

N = segment_duration;
nfft = segment_duration; % number of FFT points 
x_len = length(x); % length of the signal
w_len = segment_duration;
% form the stft matrix by formula
row_num = ceil(nfft/2)+1 ;            
col_num = floor((x_len-w_len)/(w_len-segment_overlap))+1;
stft = zeros(row_num, col_num);           

%window
for n=1:N
    w(n)=0.42-0.5*cos(2*pi*n/(N-1))+0.08*cos(4*pi*n/(N-1));
end

index = 0;
col = 1;
while index + w_len <= x_len
    % window h_ideal(n)=h_ideal(n)*w(n); (slide #80)
    
    signal_w = x(index+1:index+w_len)*w; 
    %(index+1~index+w_len) = window length
    
    % FFT
    S = fft(signal_w, nfft);
    stft(:, col) = S(1:row_num);
    
    % move overlapped area to next window  
    col = col + 1;
    index = index + segment_overlap;
end

% calculate the time and frequency vectors
F = (0:row_num-1)*fs/nfft;
T = ( w_len/2 : segment_overlap : w_len/2+(col_num-1) * segment_overlap) /fs;
