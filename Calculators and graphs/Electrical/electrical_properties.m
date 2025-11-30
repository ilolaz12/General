% Electrical Properties Library
% File Name: electrical_properties.m
% Description: This library includes functions for various electrical properties calculations,
% such as capacitance, inductance, resistance, and other related parameters.
% Author: Ilona Lazareva (U1551168)
% Date: 1 July 2024
% Version: 1.0

% Constants
epsilon0 = 8.854e-12; % Permittivity of free space (F/m)
mu0 = 4 * pi * 1e-7; % Permeability of free space (H/m)

%% Functions
% Function to calculate the capacitance of a coaxial cable
function [C] = capacitance_coaxial(L, r, d)
    % L: Length of the conductor (m)
    % r: Radius of the inner conductor (m)
    % d: Separation distance (outer conductor radius) (m)
    % C: Capacitance (F)

    % Calculate capacitance
    C = pi * epsilon0 * L / log((d - r) / r);
end

% Function to calculate the capacitance of a parallel plate capacitor
function [C] = capacitance_parallel_plate(A, d)
    % A: Area of one plate (m^2)
    % d: Separation distance between plates (m)
    % C: Capacitance (F)

    % Calculate capacitance
    C = epsilon0 * A / d;
end

% Function to calculate the inductance of a solenoid
function [L] = inductance_solenoid(N, A, l)
    % N: Number of turns
    % A: Cross-sectional area (m^2)
    % l: Length of the solenoid (m)
    % L: Inductance (H)

    % Calculate inductance
    L = (mu0 * N^2 * A) / l;
end

% Function to calculate the resistance of a wire
function [R] = resistance_wire(rho, L, A)
    % rho: Resistivity of the material (Ohm*m)
    % L: Length of the wire (m)
    % A: Cross-sectional area of the wire (m^2)
    % R: Resistance (Ohm)

    % Calculate resistance
    R = rho * L / A;
end

% Function to calculate the inductance of a coaxial cable
function [L] = inductance_coaxial(L, r, d)
    % L: Length of the conductor (m)
    % r: Radius of the inner conductor (m)
    % d: Separation distance (outer conductor radius) (m)
    % L: Inductance (H)

    % Calculate inductance
    L = (mu0 * L / (2 * pi)) * log(d / r);
end

% Function to calculate the capacitance of a spherical capacitor
function [C] = capacitance_spherical(r1, r2)
    % r1: Radius of the inner sphere (m)
    % r2: Radius of the outer sphere (m)
    % C: Capacitance (F)

    % Calculate capacitance
    C = 4 * pi * epsilon0 * (r1 * r2) / (r2 - r1);
end

% Function to calculate the capacitance of a cylindrical capacitor
function [C] = capacitance_cylindrical(L, r1, r2)
    % L: Length of the cylinders (m)
    % r1: Radius of the inner cylinder (m)
    % r2: Radius of the outer cylinder (m)
    % C: Capacitance (F)

    % Calculate capacitance
    C = (2 * pi * epsilon0 * L) / log(r2 / r1);
end

% Function to calculate the inductance of a toroidal coil
function [L] = inductance_toroidal(N, r, a)
    % N: Number of turns
    % r: Radius of the toroid (m)
    % a: Cross-sectional radius of the toroid (m)
    % L: Inductance (H)

    % Calculate inductance
    L = (mu0 * N^2 * pi * r^2) / (2 * pi * a);
end

%% Variables
% Capacitance of a coaxial cable
L = 1; % Length in meters
r = 0.01; % Radius of the inner conductor in meters
d = 0.05; % Radius of the outer conductor in meters
C_coaxial = capacitance_coaxial(L, r, d);
disp('The capacitance of the coaxial cable is:')
disp(C_coaxial)

% Capacitance of a parallel plate capacitor
A = 0.01; % Area of one plate in square meters
d = 0.001; % Separation distance in meters
C_parallel_plate = capacitance_parallel_plate(A, d);
disp('The capacitance of the parallel plate capacitor is:')
disp(C_parallel_plate)

% Inductance of a solenoid
N = 100; % Number of turns
A = 0.001; % Cross-sectional area in square meters
l = 0.1; % Length in meters
L_solenoid = inductance_solenoid(N, A, l);
disp('The inductance of the solenoid is:')
disp(L_solenoid)

% Resistance of a wire
rho = 1.68e-8; % Resistivity of copper in Ohm*m
L = 1; % Length in meters
A = 1e-6; % Cross-sectional area in square meters
R_wire = resistance_wire(rho, L, A);
disp('The resistance of the wire is:')
disp(R_wire)

% Inductance of a coaxial cable
L = 1; % Length in meters
r = 0.01; % Radius of the inner conductor in meters
d = 0.05; % Radius of the outer conductor in meters
L_coaxial = inductance_coaxial(L, r, d);
disp('The inductance of the coaxial cable is:')
disp(L_coaxial)

% Capacitance of a spherical capacitor
r1 = 0.01; % Radius of the inner sphere in meters
r2 = 0.02; % Radius of the outer sphere in meters
C_spherical = capacitance_spherical(r1, r2);
disp('The capacitance of the spherical capacitor is:')
disp(C_spherical)

% Capacitance of a cylindrical capacitor
L = 1; % Length in meters
r1 = 0.01; % Radius of the inner cylinder in meters
r2 = 0.05; % Radius of the outer cylinder in meters
C_cylindrical = capacitance_cylindrical(L, r1, r2);
disp('The capacitance of the cylindrical capacitor is:')
disp(C_cylindrical)

% Inductance of a toroidal coil
N = 100; % Number of turns
r = 0.1; % Radius of the toroid in meters
a = 0.01; % Cross-sectional radius of the toroid in meters
L_toroidal = inductance_toroidal(N, r, a);
disp('The inductance of the toroidal coil is:')
disp(L_toroidal)