%% Example 1: Power transfer

V_s = 10;
R_src = 100;
R_load = [0:2:1000];

P = (V_s.^2)./((R_src+R_load).^2).*R_load;

plot(R_load, P);
axis([0 1000 0 0.5]);
grid('on');
grid('minor');
xlabel('$R_{load}\, \Omega$', 'interpreter', 'LaTeX');
ylabel('Power W', 'interpreter', 'LaTeX');
title("Power Transfer")

%% Example 2: DFT Calculations
% Define input waveform.
w = 2*pi/40;
N = 1000;
n = 0:N1;
x = sin(n*w);
% Perform Fourier Transform.
plot(abs(fft(x)));
% Interpret output.
stem(abs(fft(x)), '.');

%% Example 3: RMS value
% waveform parameters
dt = 0.01;
tmax = 2;
t = 0:dt:tmax;
f = 2;
% generate the signal
x = 1*sin(2*pi*f*t);
plot(t,x);
% calculate the signal's RMS value
sqrt((sum(x.*x)*dt)/tmax)
