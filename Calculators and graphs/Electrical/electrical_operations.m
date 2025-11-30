% Electrical Operations Library
% File Name: electrical_operations.m
% Description: This library includes functions for various electrical engineering calculations,
% such as calculating Ohm's law, power, energy, impedance in AC circuits, and other related electrical operations.
% Author: Ilona Lazareva (U1551168)
% Date: 1 July 2024
% Version: 1.0

% Ohm's Law Calculations
current = 2; % Current in amperes
resistance = 10; % Resistance in ohms
voltage = calculate_voltage(current, resistance);
disp('The voltage is:')
disp(voltage)

voltage = 20; % Voltage in volts
current = calculate_current(voltage, resistance);
disp('The current is:')
disp(current)

% Power and Energy Calculations
power = calculate_power(voltage, current);
disp('The power is:')
disp(power)

time = 5; % Time in hours
energy = calculate_energy(power, time);
disp('The energy is:')
disp(energy)

% Impedance Calculations
R = 10; % Resistance in ohms
L = 0.1; % Inductance in henries
C = 100e-6; % Capacitance in farads
frequency = 50; % Frequency in hertz

impedance_series = calculate_impedance_series(R, L, C, frequency);
disp('The series impedance is:')
disp(impedance_series)

impedance_parallel = calculate_impedance_parallel(R, L, C, frequency);
disp('The parallel impedance is:')
disp(impedance_parallel)

% Resonant Frequency and Quality Factor
resonant_frequency = calculate_resonant_frequency(L, C);
disp('The resonant frequency is:')
disp(resonant_frequency)

Q_factor = calculate_quality_factor(R, L, C);
disp('The quality factor is:')
disp(Q_factor)

% Phase Angle Calculations
phase_angle_series = calculate_phase_angle_series(R, L, C, frequency);
disp('The phase angle in the series RLC circuit is:')
disp(phase_angle_series)

phase_angle_parallel = calculate_phase_angle_parallel(R, L, C, frequency);
disp('The phase angle in the parallel RLC circuit is:')
disp(phase_angle_parallel)

%% Functions

% Ohm's Law Functions

% Function to calculate voltage using Ohm's law
function [voltage] = calculate_voltage(current, resistance)
    voltage = current * resistance;
end

% Function to calculate current using Ohm's law
function [current] = calculate_current(voltage, resistance)
    current = voltage / resistance;
end

% Function to calculate resistance using Ohm's law
function [resistance] = calculate_resistance(voltage, current)
    resistance = voltage / current;
end

% Power and Energy Functions

% Function to calculate electrical power
function [power] = calculate_power(voltage, current)
    power = voltage * current;
end

% Function to calculate electrical energy
function [energy] = calculate_energy(power, time)
    energy = power * time;
end

% Impedance Functions

% Function to calculate impedance in a series RLC circuit
function [impedance] = calculate_impedance_series(R, L, C, frequency)
    omega = 2 * pi * frequency;
    impedance = sqrt(R^2 + (omega * L - 1 / (omega * C))^2);
end

% Function to calculate impedance in a parallel RLC circuit
function [impedance] = calculate_impedance_parallel(R, L, C, frequency)
    omega = 2 * pi * frequency;
    Z_R = R;
    Z_L = 1i * omega * L;
    Z_C = 1 / (1i * omega * C);
    impedance = 1 / (1 / Z_R + 1 / Z_L + 1 / Z_C);
end

% Function to calculate resonant frequency of an RLC circuit
function [resonant_frequency] = calculate_resonant_frequency(L, C)
    resonant_frequency = 1 / (2 * pi * sqrt(L * C));
end

% Function to calculate quality factor of an RLC circuit
function [Q_factor] = calculate_quality_factor(R, L, C)
    omega_0 = 1 / sqrt(L * C);
    Q_factor = omega_0 * L / R;
end

% Function to calculate the phase angle in a series RLC circuit
function [phase_angle] = calculate_phase_angle_series(R, L, C, frequency)
    omega = 2 * pi * frequency;
    phase_angle = atan((omega * L - 1 / (omega * C)) / R);
end

% Function to calculate the phase angle in a parallel RLC circuit
function [phase_angle] = calculate_phase_angle_parallel(R, L, C, frequency)
    omega = 2 * pi * frequency;
    Z_R = R;
    Z_L = 1i * omega * L;
    Z_C = 1 / (1i * omega * C);
    Z_total = 1 / (1 / Z_R + 1 / Z_L + 1 / Z_C);
    phase_angle = angle(Z_total);
end
