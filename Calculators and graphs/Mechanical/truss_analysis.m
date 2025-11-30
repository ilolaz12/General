% truss_analysis.m
% This script analyzes the reaction forces on a planar truss structure.
% The structure has pin connections at points A, B, and C.
% Given the coordinates of point B, the script calculates the reaction forces
% at points A and C, and plots the contour maps of these forces over a grid.
% Author: Ilona Lazareva (U1551168)
% Date: 23 July 2024
% Version: 4.0

%% Functions
function forces = solveEquilibrium(xB, yB, W, AC)
    % solveEquilibrium calculates the forces at the supports for a given point B
    % Inputs:
    %   xB, yB - coordinates of point B
    %   W - applied force at point B
    %   AC - distance between points A and C
    % Outputs:
    %   forces - vector of forces [F_Az, F_Ay, F_Cz, F_Cy]
    
    % Matrix A and vector b based on equilibrium equations
    A = [1, 0, 1, 0;
         0, 1, 0, 1;
         0, 0, -AC, 0;
         yB, -xB, 0, 0];

    b = [0; W; xB * W; 0];

    % Solve the system of equations
    forces = A\b;
end

function [F_A, F_C] = calculateMagnitudes(force)
    % calculateMagnitudes calculates the magnitudes of reaction forces
    % Inputs:
    %   forces - vector of forces [F_Az, F_Ay, F_Cz, F_Cy]
    % Outputs:
    %   F_A - magnitude of the reaction force at point A
    %   F_C - magnitude of the reaction force at point C
    
    % Extract forces
    F_Az = force(1);
    F_Ay = force(2);
    F_Cz = force(3);
    F_Cy = force(4);

    % Calculate magnitudes of the reaction forces
    F_A = sqrt(F_Az^2 + F_Ay^2);
    F_C = sqrt(F_Cz^2 + F_Cy^2);
end

function plotContours(X, Y, F_grid, title_str)
    % plotContours plots the contour map of the given force magnitudes
    % Inputs:
    %   X, Y - grid coordinates
    %   F_grid - matrix of force magnitudes
    %   title_str - title of the plot
    
    % Plot contour of the force magnitudes over the grid
    contourf(X, Y, F_grid);
    title(title_str);
    xlabel('x_B');
    ylabel('y_B');
    colorbar;
end

function displayForces(force, xB, yB)
    % displayForces displays the individual forces for debugging
    % Inputs:
    %   forces - vector of forces [F_Az, F_Ay, F_Cz, F_Cy]
    %   xB, yB - coordinates of point B (for debugging output)
    
    % Extract forces
    F_Az = force(1);
    F_Ay = force(2);
    F_Cz = force(3);
    F_Cy = force(4);

    % Display the forces
    fprintf('Sub forces for point B at (%.1f, %.1f):\n', xB, yB);
    fprintf('F_Az = %.3f\n', F_Az);
    fprintf('F_Ay = %.3f\n', F_Ay);
    fprintf('F_Cz = %.3f\n', F_Cz);
    fprintf('F_Cy = %.3f\n', F_Cy);
end

%% Variables
% Specific point
xB_specific = 2.4; % x-coordinate
yB_specific = 0.8; % y-coordinate

% Given values
W = 700 + 3.5861 * 30; % 700 + 3.5861 * 30 as provided in assignment
AC = 2; % Distance between points A and C

% Define the grid
x_grid = 0:0.2:2.4;
y_grid = -0.2:0.2:2.2;
[X, Y] = meshgrid(x_grid, y_grid);

% Initialize force magnitude grids
F_A_grid = zeros(size(X));
F_C_grid = zeros(size(X));

%% Display forces for specific point

% Solve for the specific point (xB_specific, yB_specific)
forces_specific = solveEquilibrium(xB_specific, yB_specific, W, AC);

% Calculate and display the magnitudes of the forces for the specific point
[F_A_specific, F_C_specific] = calculateMagnitudes(forces_specific);
fprintf('Resultant forces for point B at (%.1f, %.1f):\n', xB_specific, yB_specific);
fprintf('F_A = %.3f\n', F_A_specific);
fprintf('F_C = %.3f\n', F_C_specific);

% Display the individual forces for the specific point
displayForces(forces_specific, xB_specific, yB_specific);

%% Contour plots for all grid points

% Solve for all grid points and calculate force magnitudes
for i = 1:numel(X)
    xB = X(i);
    yB = Y(i);
    forces = solveEquilibrium(xB, yB, W, AC);
    [F_A, F_C] = calculateMagnitudes(forces);
    F_A_grid(i) = F_A;
    F_C_grid(i) = F_C;
end

% Plot contours for F_A and F_C
figure;
plotContours(X, Y, F_A_grid, 'Contour of F_A');

figure;
plotContours(X, Y, F_C_grid, 'Contour of F_C');

figure;
plotContours(X, Y, F_combined_grid, 'Contour of Combined Forces F_A and F_C');