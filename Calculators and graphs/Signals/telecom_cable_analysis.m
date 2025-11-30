% Module 2 Problem 6 solution
% Cable Tension Calculations Library
% File Name: cable_tension_calculations.m
% Description: This library includes functions to calculate the angles and tensions
% in cables given certain parameters, and to find the shortest possible cable length
% that satisfies specific tension criteria.
% This library includes functions for telecommunications and cable
% analysis, such as signal analysis, cable length calculations, network checking,
% interference analysis, and other related calculations.
% Author: Ilona Lazareva (U1551168)
% Date: 1 July 2024
% Version: 1.0

% Initialise values
D = 6; % Distance between anchors (ft)
LAB = 3; % Length of one of the cables (ft)
W = 2000; % Weight of mass (lb)
max_tension = 2000; % Maximum allowed tension (lb)

% Cable Length Calculation
anchor_distance = 100; % Distance between anchors (ft)
sag = 10; % Sag (ft)
cable_length = calculate_cable_length(anchor_distance, sag);
disp(['Cable Length: ', num2str(cable_length), ' ft'])

% Signal Analysis
power_initial = 100; % Initial power (W)
power_final = 10; % Final power (W)
distance = 50; % Distance (m)
attenuation = calculate_signal_attenuation(power_initial, power_final, distance);
disp(['Signal Attenuation: ', num2str(attenuation), ' dB/m'])

signal_power = 50; % Signal power (W)
noise_power = 5; % Noise power (W)
SNR = calculate_SNR(signal_power, noise_power);
disp(['Signal-to-Noise Ratio (SNR): ', num2str(SNR), ' dB'])

% Network Checking
min_SNR = 20; % Minimum required SNR (dB)
meets_SNR = check_network_SNR(SNR, min_SNR);
disp(['Network meets SNR requirements: ', num2str(meets_SNR)])

% Cable Type Calculation
frequency = 5e6; % Signal frequency (Hz)
distance = 200; % Distance (m)
cable_type = determine_cable_type(frequency, distance);
disp(['Appropriate Cable Type: ', cable_type])

% Electromagnetic Force Calculation
I1 = 10; % Current in first cable (A)
I2 = 15; % Current in second cable (A)
distance = 0.1; % Distance between cables (m)
force = calculate_electromagnetic_force(I1, I2, distance);
disp(['Electromagnetic Force: ', num2str(force), ' N'])

% Resonant Frequency Calculation
cable_length = 10; % Length of cable (m)
velocity = 3e8; % Velocity of signal (m/s)
resonant_frequency = calculate_resonant_frequency(cable_length, velocity);
disp(['Resonant Frequency: ', num2str(resonant_frequency), ' Hz'])

% Interference Analysis
SNR = 30; % Signal-to-Noise Ratio (dB)
signal_power = 100; % Signal power (W)
max_interference = calculate_max_allowed_interference(SNR, signal_power);
disp(['Max Allowed Interference: ', num2str(max_interference), ' W'])

power = 100; % Power of interference source (W)
threshold = 1; % Threshold power (W)
interference_area = calculate_interference_area(power, threshold);
disp(['Area of Interference: ', num2str(interference_area), ' m^2'])

%% Functions
% Function to calculate the angle of cable AB
function [theta] = angle_cable_AB(D, LAB, LAC)
    theta = acos((D^2 + LAB^2 - LAC^2) / (2 * D * LAB));
end

% Function to calculate the angle of cable BC
function [phi] = angle_cable_BC(D, LAB, LAC, theta)
    phi = asin(LAB * sin(theta) / LAC);
end

% Function to calculate the tension in cable AC
function [TAC] = tension_cable_AC(W, theta, phi)
    TAC = W * cos(theta) / (cos(phi) * sin(theta) + sin(phi) * cos(theta));
end

% Function to calculate the tension in cable AB
function [TAB] = tension_cable_AB(TAC, phi, theta)
    TAB = TAC * cos(phi) / cos(theta);
end

% Function to find the shortest possible length of LAC that satisfies the tension criteria
function [LAC_ans, TAB_ans, TAC_ans] = shortest_cable_length(D, LAB, W, max_tension)
    LAC_ans = nan;
    TAB_ans = nan;
    TAC_ans = nan;

    for LAC = 6.7:-0.001:3.01
        theta = angle_cable_AB(D, LAB, LAC);
        phi = angle_cable_BC(D, LAB, LAC, theta);
        TAC = tension_cable_AC(W, theta, phi);
        TAB = tension_cable_AB(TAC, phi, theta);

        if (TAB <= max_tension) && (TAC <= max_tension)
            LAC_ans = LAC;
            TAB_ans = TAB;
            TAC_ans = TAC;
            break;
        end
    end
end

% Cable Length Calculations

% Function to calculate the length of a cable using the distance between anchors and the sag
function [cable_length] = calculate_cable_length(anchor_distance, sag)
    cable_length = sqrt(anchor_distance^2 + (4 * sag^2)) / 2;
end

% Signal Analysis

% Function to calculate signal attenuation over distance
function [attenuation] = calculate_signal_attenuation(power_initial, power_final, distance)
    attenuation = 10 * log10(power_initial / power_final) / distance;
end

% Function to calculate signal-to-noise ratio (SNR)
function [SNR] = calculate_SNR(signal_power, noise_power)
    SNR = 10 * log10(signal_power / noise_power);
end

% Network Checking

% Function to check if a network meets minimum SNR requirements
function [meets_SNR] = check_network_SNR(SNR, min_SNR)
    meets_SNR = SNR >= min_SNR;
end

% Cable Type Calculations

% Function to determine the appropriate cable type based on signal frequency and distance
function [cable_type] = determine_cable_type(frequency, distance)
    if frequency < 1e6
        if distance < 100
            cable_type = 'Twisted Pair';
        else
            cable_type = 'Coaxial';
        end
    else
        if distance < 500
            cable_type = 'Coaxial';
        else
            cable_type = 'Fiber Optic';
        end
    end
end

% Electromagnetic Force Calculations

% Function to calculate the electromagnetic force between two parallel currents
function [force] = calculate_electromagnetic_force(I1, I2, distance)
    mu0 = 4 * pi * 1e-7; % Permeability of free space
    force = (mu0 * I1 * I2) / (2 * pi * distance);
end

% Resonant Frequency Calculations

% Function to calculate the resonant frequency of a cable
function [resonant_frequency] = calculate_resonant_frequency(length, velocity)
    resonant_frequency = velocity / (2 * length);
end

% Interference Analysis

% Function to calculate maximum allowed interference based on SNR
function [max_interference] = calculate_max_allowed_interference(SNR, signal_power)
    max_interference = signal_power / (10^(SNR / 10));
end

% Function to calculate area of interference
function [interference_area] = calculate_interference_area(power, threshold)
    interference_area = pi * (power / threshold)^2;
end

% Find the shortest possible value of LAC
[LAC_ans, TAB_ans, TAC_ans] = shortest_cable_length(D, LAB, W, max_tension);

disp('TAB is:')
disp(TAB_ans)
disp('TAC is:')
disp(TAC_ans)
disp('LAC is:')
disp(LAC_ans)