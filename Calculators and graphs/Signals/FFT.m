% Time vector: 1 second at 8000 Hz %max samples allowed by hardware (allegedly) over a second
t = 0:1/8000:1;
x=2*sin(2*pi*5*t)/256+4*sin(2*pi*8*t)/256;
X = fft(x);
N = length(x_b);
X_b = fft(x_b);
% Frequency axis (single-sided)
f = (0:N/2-1)*(fs/N);
X_magnitude = abs(X_b(1:N/2));  % One-sided magnitude

figure;
subplot(2,1,1);
% The wave itself
plot(t,x);
xlabel('Time(s)');
ylabel('Amplitude');
title('Sine Wave');
%saveas(gcf, 'timewave', 'png');
%figure;
subplot(2,1,2);
% FFT
stem(abs(X));
xlabel('Fourier Index');
ylabel('Fourier Amplitude');
title('Fourier Transform');
%saveas(gcf, 'FFTresult', 'png');

figure;
subplot(3,1,1);
plot(x_b);
xlabel('Sample Index');
ylabel('Amplitude');
title('Unknown Waveform');
subplot(3,1,2);
stem(abs(X_b));
xlabel('Fourier Index');
ylabel('Fourier Amplitude');
title('Fourier Transform');
subplot(3,1,3);
plot(f, X_magnitude);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
title('FFT Magnitude');
%saveas(gcf, 'FFTunknown', 'png'); 