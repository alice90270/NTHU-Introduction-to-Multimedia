function [frequency, magnitude] = make_spectrum( y_signal , fs )

% Transform to frequency domain
L1 = 2^nextpow2(max(size(y_signal)));
FFT = fft(y_signal,L1);
xx = fs/2*linspace(0,1,L1/2+1);

magnitude = abs(FFT(1:L1/2+1));
frequency = xx;

end