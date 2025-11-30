% Gas Laws Library
% File Name: gas_laws_library.m
% Description: This library includes functions for calculating the pressure of gases using the Ideal Gas Law
% and the van der Waals equation, and for comparing the results.
% Author: Ilona Lazareva (U1551168)
% Date: 3 July 2024
% Version: 1.0

%% Functions

% Function to calculate pressure using the Ideal Gas Law
function [P] = ideal_gas_law(n, R, T, V)
    % n: number of moles of gas
    % R: gas constant
    % T: temperature (K)
    % V: volume (L)
    P = (n * R * T) / V;
end

% Function to calculate pressure using the van der Waals equation
function [P] = van_der_waals(n, R, T, V, a, b)
    % n: number of moles of gas
    % R: gas constant
    % T: temperature (K)
    % V: volume (L)
    % a: van der Waals constant (L^2 atm / mol^2)
    % b: van der Waals constant (L / mol)
    P = (n * R * T) / (V - n * b) - (a * n^2) / V^2;
end

% Function to compare pressures calculated using the Ideal Gas Law and the van der Waals equation
function compare_pressures(n, R, T, V, a, b)
    P_ideal = ideal_gas_law(n, R, T, V);
    P_vdw = van_der_waals(n, R, T, V, a, b);
    
    disp('Comparison of Pressure Estimates:')
    disp(['Ideal Gas Law Pressure: ', num2str(P_ideal), ' atm'])
    disp(['van der Waals Pressure: ', num2str(P_vdw), ' atm'])
    disp(' ')
    
    if abs(P_ideal - P_vdw) < 0.1
        disp('The pressure estimates are very similar.')
    else
        disp('The pressure estimates are significantly different.')
    end
    
    disp('The main cause of the difference in the two pressure estimates:')
    if abs(P_ideal - P_vdw) > abs((n * R * T) / (V - n * b) - (n * R * T) / V)
        disp('Molecular attractions (a term) are the main cause of the difference.')
    else
        disp('Molecular volume (b term) is the main cause of the difference.')
    end
end

%% Variables

% Given data
n = 1; % number of moles of Cl2
R = 0.08206; % gas constant in L atm / (mol K)
T = 273.2; % temperature in K
V = 22.41; % volume in L
a = 6.49; % van der Waals constant for Cl2 (L^2 atm / mol^2)
b = 0.0562; % van der Waals constant for Cl2 (L / mol)

%% Display

% Compare the pressure estimates using the given data
compare_pressures(n, R, T, V, a, b)
