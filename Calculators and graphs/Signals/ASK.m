%% Transmitting ASK_RF signal
% Bit pattern pre-determined
%bits = [0, 1, 0, 1, 1, 1, 1, 1, 0];
% Bit pattern - <n_bits> number of random bits
n_bits = 1000;
bits = round(rand(1, n_bits)); 
% Samples per carrier cycle
N = 50;
% Phase defined in radiant-steps per sample
omega = 2*pi/N;
% Carrier cycle per symbol or n
C = 3;
% Output waveform array placeholder
ASK_store=[];
% Start function to adjust for variant A
for i = 1:length(bits)
    if bits(i) == 0     % Case 1 for bit == 0
        A = 1;
    else                % Case 2 for bit == 1 (or any other)
        A = 0.5;
    end
    % Sample indexes
    t = 0:N-1;
    % Generate waveform
    ASK_wave = A*sin(C*omega*t);
    %Append data to graph
    ASK_store= [ASK_store ASK_wave];
end 
% Plot the stored waveform data
plot (ASK_store);
title ('ASK Modulated waveform');
xlabel ('Sample number');
ylabel ('Amplitude');
grid on;

%% Asynchronous decoder for ASK modulated signal