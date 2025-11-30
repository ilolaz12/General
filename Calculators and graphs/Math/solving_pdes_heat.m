% SOLVING AND PLOTTING A PARABOLIC PDE (HEAT EQUATION)
%
% This script solves a parabolic PDE (heat equation) using the finite difference
% method and plots the solution as a 3D surface plot.
%
% Author: [Your Name]
% Date: [Current Date]

%% Functions

% Function to solve parabolic PDE using FDM
function [x, t, u] = solve_parabolic_pde(f, a, L, T, Nx, Nt)
    x = linspace(0, L, Nx+1);
    t = linspace(0, T, Nt+1);
    dx = L / Nx;
    dt = T / Nt;
    r = a * dt / dx^2;
    u = zeros(Nx+1, Nt+1);

    % Initial condition
    u(:,1) = f(x);

    % Time stepping
    for n = 1:Nt
        for i = 2:Nx
            u(i,n+1) = u(i,n) + r * (u(i+1,n) - 2*u(i,n) + u(i-1,n));
        end
        % Apply boundary conditions
        u(1,n+1) = 0;  % Dirichlet condition at x=0
        u(Nx+1,n+1) = 0;  % Dirichlet condition at x=L
    end
end

%% Variables

% Example function for initial condition
f = @(x) sin(pi * x);  % Initial condition
a = 1;  % Diffusion coefficient
L = 1;  % Length of the domain
T = 1;  % Total time
Nx = 20;  % Number of spatial steps
Nt = 50;  % Number of time steps

%% Numerical Solution

% Solve Parabolic PDE
[x, t, u] = solve_parabolic_pde(f, a, L, T, Nx, Nt);

%% Plot

% Plot Parabolic PDE solution
figure;
surf(x, t, u');
title('Parabolic PDE Solution');
xlabel('x');
ylabel('t');
zlabel('u');
shading interp;
colormap jet;

% Adding annotation for lambda
lambda = a * (T / Nt) / (L / Nx);
annotation_text = sprintf('\\lambda = \\frac{a \\Delta t}{\\Delta x^2} = %.1f', lambda);
text(0.5, -0.2, annotation_text, 'FontSize', 14, 'HorizontalAlignment', 'center');

% End of the script
