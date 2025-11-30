% Electromagnetics Library
% File Name: electromagnetics.m
% Description: This library includes functions for various electromagnetics calculations,
% such as electric fields, magnetic fields, forces, potentials, and other related operations.
% Author: [Your Name]
% Date: [Date]

% Constants
mu0 = 4 * pi * 1e-7; % Permeability of free space (H/m)
epsilon0 = 8.854e-12; % Permittivity of free space (F/m)

% Electric Field Calculations
q = 1e-9; % Charge in coulombs
r = [0.01, 0.01, 0.01]; % Position vector in meters
E = electric_field_point_charge(q, r);
disp('The electric field due to the point charge is:')
disp(E)

% Electric Potential Calculations
V = electric_potential_point_charge(q, r);
disp('The electric potential due to the point charge is:')
disp(V)

% Magnetic Field Calculations
I = 10; % Current in amperes
dl = [0.01, 0, 0]; % Differential length vector in meters
B = magnetic_field_current_element(I, dl, r);
disp('The magnetic field due to the current element is:')
disp(B)

d = 0.01; % Distance from the wire in meters
B_wire = magnetic_field_straight_wire(I, r, d);
disp('The magnetic field due to the straight wire is:')
disp(B_wire)

% Force Calculations
F_charge = force_on_charge(E, q);
disp('The force on the charge in the electric field is:')
disp(F_charge)

L = [0.1, 0, 0]; % Length vector of the wire in meters
B_field = [0, 0, 1e-3]; % Magnetic field vector in tesla
F_wire = force_on_wire(I, L, B_field);
disp('The force on the current-carrying wire in the magnetic field is:')
disp(F_wire)

q1 = 1e-9; % Charge 1 in coulombs
q2 = -1e-9; % Charge 2 in coulombs
r12 = [0.01, 0, 0]; % Position vector between charges in meters
F_charges = force_between_charges(q1, q2, r12);
disp('The force between the two point charges is:')
disp(F_charges)

% Potential Energy Calculations
U_charges = potential_energy_two_charges(q1, q2, r12);
disp('The electric potential energy of the two point charges is:')
disp(U_charges)

mu = [1, 0, 0]; % Magnetic dipole moment vector in A*m^2
U_magnetic = magnetic_potential_energy(mu, B_field);
disp('The magnetic potential energy of the dipole in the magnetic field is:')
disp(U_magnetic)

%% Functions
% Electric Field Functions

% Function to calculate the electric field due to a point charge
function [E] = electric_field_point_charge(q, r)
    E = (q / (4 * pi * epsilon0 * norm(r)^3)) * r;
end

% Function to calculate the electric potential due to a point charge
function [V] = electric_potential_point_charge(q, r)
    V = q / (4 * pi * epsilon0 * norm(r));
end

% Magnetic Field Functions

% Function to calculate the magnetic field due to a current element (Biot-Savart Law)
function [B] = magnetic_field_current_element(I, dl, r)
    B = (mu0 / (4 * pi)) * (I * cross(dl, r) / norm(r)^3);
end

% Function to calculate the magnetic field due to a long straight current-carrying wire
function [B] = magnetic_field_straight_wire(I, r, d)
    B = (mu0 * I) / (2 * pi * d);
end

% Force Functions

% Function to calculate the force on a charge in an electric field
function [F] = force_on_charge(E, q)
    F = q * E;
end

% Function to calculate the force on a current-carrying wire in a magnetic field
function [F] = force_on_wire(I, L, B)
    F = I * cross(L, B);
end

% Function to calculate the force between two point charges
function [F] = force_between_charges(q1, q2, r)
    F = (q1 * q2) / (4 * pi * epsilon0 * norm(r)^3) * r;
end

% Potential Functions

% Function to calculate the electric potential energy of a system of two point charges
function [U] = potential_energy_two_charges(q1, q2, r)
    U = (q1 * q2) / (4 * pi * epsilon0 * norm(r));
end

% Function to calculate the magnetic potential energy of a magnetic dipole in a magnetic field
function [U] = magnetic_potential_energy(mu, B)
    U = -dot(mu, B);
end
