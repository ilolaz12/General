%% Example 1: FM Spectrum from First Principles
% samples
N = 400;
% beta value
beta = 6.0;
% starting point
n = 1;
t = linspace(0, pi, N);
dt = t(2)-t(1);
Jarg = cos(beta*sin(t)-n*t);
Jcalc = (1/pi)*sum(Jarg*dt);
JMatlab = besselj(n, beta);