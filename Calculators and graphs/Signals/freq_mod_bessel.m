%% Parameters
A = 5.6;        % Carrier amplitude
beta = 3;       % Modulation index
fc = 100e3;     % Carrier frequency (100 kHz for example)
fm = 1e3;       % Modulating frequency (1 kHz)
Fs = 10*fc;     % Sampling rate ~ 10x carrier (1 MHz)
t = 0 : 1/Fs : (1/fm);  % One period of the modulating signal

%% Calculations
% Create the FM signal
s = A*cos(2*pi*fc*t + beta*sin(2*pi*fm*t));

% Measure instantaneous amplitude
inst_amp = abs(hilbert(s));  % or sqrt(s.^2 + some_quadrature^2)

% Find the peak amplitude
peak_amp = max(inst_amp);

% Compute peak power
peak_power = peak_amp^2;

fprintf('Time-Domain Approach:\n');
fprintf('  Peak Amplitude = %.4f\n', peak_amp);
fprintf('  Peak Power     = %.4f\n', peak_power);


% Bessel expansion approach
N = 10;  % Sum sidebands from -10 to +10
nVec = -N:N; 

% Bessel coefficients for each sideband
Jn = besselj(nVec, beta);  % Evaluate J_n(beta) at n = -10..+10

% Frequency-phase approach:
% s(t) ~ A * sum_{n=-N to N} Jn * cos(2*pi(fc+n*fm)*t + n*pi/2)
% We'll just do it numerically:

s_approx = zeros(size(t));
for idx = 1:length(nVec)
    n = nVec(idx);
    s_approx = s_approx + Jn(idx)*cos( 2*pi*(fc + n*fm)*t + n*pi/2 );
end

% Multiply by A to get actual amplitude
s_approx = A * s_approx;

% Check instantaneous amplitude
inst_amp_approx = abs(hilbert(s_approx));
peak_amp_approx = max(inst_amp_approx);
peak_power_approx = peak_amp_approx^2;

fprintf('\nFrequency-Domain (Bessel) Approach:\n');
fprintf('  Peak Amplitude = %.4f\n', peak_amp_approx);
fprintf('  Peak Power     = %.4f\n', peak_power_approx);
