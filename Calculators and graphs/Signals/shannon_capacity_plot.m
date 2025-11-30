%% Parameters
% SNR range in dB
SNR_dB = 0:20;
% 1 MHz bandwidth in Hz
B = 1e6;

%% Calculations
% Convert SNR from dB to linear:
SNR_lin = 10.^(SNR_dB/10);

% Compute capacity in bits/s:
C_bits_s = B .* log2(1 + SNR_lin);

% Convert to Mbps:
C_Mbps = C_bits_s / 1e6;

%% Graphs
% Plot channel capacity vs. SNR (linear):
figure;
plot(SNR_lin, C_Mbps, 'LineWidth', 2);
xlabel('SNR (linear)');
ylabel('Channel Capacity (Mbps)');
title('Channel Capacity vs Linear SNR (B = 1 MHz)');
grid on;

% Plot channel capacity vs. SNR (dB):
figure;
plot(SNR_dB, C_Mbps, 'LineWidth', 2);
xlabel('SNR (dB)');
ylabel('Channel Capacity (Mbps)');
title('Channel Capacity vs dB SNR (B = 1 MHz)');
grid on;