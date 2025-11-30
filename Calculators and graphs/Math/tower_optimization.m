% Tower Optimization Library
% File Name: tower_optimization.m
% Description: This library includes functions for optimizing the size of a tower to minimize cost,
% calculating the cost and height of a tower given its volume, and other related operations.
% This library includes functions for various advanced mathematical operations,
% such as trigonometric calculations, logarithmic calculations, calculus operations,
% complex number operations, and linear algebra operations.
% Author: Ilona Lazareva (U1551168)
% Date: 1 July 2024
% Version: 1.0


%% Functions

% Function to calculate the cost of the tower given its radius
function [cost] = tower(r)
    % r: Radius of the tower (m)
    % V: Volume of the tower (m^3), predefined as 500m^3
    V = 500;
    h = V / (pi * r^2); % Calculate height
    material_cost = 100 * pi * r^2; % Cost based on radius
    labor_cost = 50 * h; % Cost based on height
    cost = material_cost + labor_cost; % Total cost
end

% Function to calculate the height of the tower given its volume and radius
function [h] = height(V, r)
    % V: Volume of the tower (m^3)
    % r: Radius of the tower (m)
    h = V / (pi * r^2); % Calculate height
end
% Function to calculate the safety factor of the tower
function [safety_factor] = calculate_safety_factor(material_strength, load)
    % material_strength: Material strength (Pa)
    % load: Load on the tower (N)
    safety_factor = material_strength / load;
end

% Function to calculate the structural integrity of the tower
function [is_safe] = check_structural_integrity(height, radius, wind_speed, material_strength)
    % height: Height of the tower (m)
    % radius: Radius of the tower (m)
    % wind_speed: Wind speed (m/s)
    % material_strength: Material strength (Pa)
    wind_load = calculate_wind_load(height, radius, wind_speed);
    safety_factor = calculate_safety_factor(material_strength, wind_load);
    is_safe = safety_factor > 1.5; % Assuming a minimum safety factor of 1.5 for safety
end

% Function to calculate the line impedance per unit length
function [Z] = line_impedance(R, L, G, C, f)
    % R: Resistance per unit length (Ohms/m)
    % L: Inductance per unit length (H/m)
    % G: Conductance per unit length (S/m)
    % C: Capacitance per unit length (F/m)
    % f: Frequency (Hz)
    omega = 2 * pi * f;
    Z = sqrt((R + 1i * omega * L) / (G + 1i * omega * C));
end

% Function to calculate the power loss in the line
function [P_loss] = power_loss(V, I, R)
    % V: Voltage (V)
    % I: Current (A)
    % R: Resistance (Ohms)
    P_loss = I^2 * R;
end

% Function to calculate the voltage drop across the line
function [V_drop] = voltage_drop(I, Z, length)
    % I: Current (A)
    % Z: Impedance per unit length (Ohms/m)
    % length: Length of the line (m)
    V_drop = I * Z * length;
end

% Function to calculate the efficiency of the powerline
function [efficiency] = transmission_efficiency(P_input, P_loss)
    % P_input: Input power (W)
    % P_loss: Power loss (W)
    efficiency = (P_input - P_loss) / P_input * 100;
end

% Function to calculate the optimal current for minimizing power loss
function [I_opt] = optimal_current(V, R, P_input)
    % V: Voltage (V)
    % R: Resistance (Ohms)
    % P_input: Input power (W)
    I_opt = sqrt(P_input / R);
end

% Function to calculate the height of the tower for optimal transmission
function [h] = optimal_height(V, I, L, G, C, f, length)
    % V: Voltage (V)
    % I: Current (A)
    % L: Inductance per unit length (H/m)
    % G: Conductance per unit length (S/m)
    % C: Capacitance per unit length (F/m)
    % f: Frequency (Hz)
    % length: Length of the line (m)
    Z = line_impedance(0, L, G, C, f); % Assume R=0 for simplification
    V_drop = voltage_drop(I, Z, length);
    h = V / V_drop; % Simplified height calculation based on voltage drop
end

%% Variables

% Define the volume of the tower
V = 500; % Volume in cubic meters

% Determine the optimal radius for the tower (between 0m and 100m)
optimum_r = fminbnd(@tower, 0, 100);

% Calculate the cost of the tower for the optimal radius
min_cost = tower(optimum_r);

% Calculate the height of the tower for the optimal radius
optimum_h = height(V, optimum_r);

% Check the structural integrity of the tower
is_safe = check_structural_integrity(optimum_h, optimum_r, wind_speed, material_strength);

% Define electrical parameters
R = 0.05; % Resistance per unit length (Ohms/m)
L = 2e-6; % Inductance per unit length (H/m)
G = 1e-9; % Conductance per unit length (S/m)
C = 1e-9; % Capacitance per unit length (F/m)
f = 60; % Frequency (Hz)
V = 230; % Voltage (V)
length = 1000; % Length of the line (m)
P_input = 1e6; % Input power (W)

% Calculate the line impedance
Z = line_impedance(R, L, G, C, f);

% Calculate the optimal current
I_opt = optimal_current(V, R, P_input);

% Calculate the power loss
P_loss = power_loss(V, I_opt, R);

% Calculate the voltage drop
V_drop = voltage_drop(I_opt, Z, length);

% Calculate the transmission efficiency
efficiency = transmission_efficiency(P_input, P_loss);

% Calculate the optimal height of the tower for optimal transmission
optimum_h = optimal_height(V, I_opt, L, G, C, f, length);

%% Display

% Output results
disp(['For a volume of ', num2str(V), 'm^3,'])
disp(['the optimal radius is: ', num2str(optimum_r), 'm,'])
fprintf('which costs: $%d.\n', ceil(min_cost))
disp(['The height of this tower is: ', num2str(optimum_h), 'm.'])
disp(['The tower is ', num2str(is_safe), ' (1 if safe, 0 if not safe) for a wind speed of ', num2str(wind_speed), ' m/s.'])
disp(['For an input power of ', num2str(P_input), 'W,'])
disp(['the optimal current is: ', num2str(I_opt), 'A,'])
disp(['the power loss is: ', num2str(P_loss), 'W,'])
disp(['the voltage drop is: ', num2str(V_drop), 'V,'])
disp(['the transmission efficiency is: ', num2str(efficiency), '%'])
disp(['the optimal height of the tower is: ', num2str(optimum_h), 'm.'])