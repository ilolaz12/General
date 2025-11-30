% This script covers the basic concepts, classification, boundary conditions,
% and numerical methods for solving PDEs. 

%% Functions

% Function to classify the PDE
function type = classify_pde(a, b, c)
    if b^2 - 4*a*c > 0
        type = 'Hyperbolic';
    elseif b^2 - 4*a*c == 0
        type = 'Parabolic';
    else
        type = 'Elliptic';
    end
end

% Function to apply Dirichlet boundary condition
function y = apply_dirichlet(y, value, position)
    y(position) = value;
end

% Function to apply Neumann boundary condition
function y = apply_neumann(y, value, position, h)
    y(position) = y(position - 1) + value * h;
end

% Function to apply Cauchy boundary condition
function y = apply_cauchy(y, value, position, h, alpha)
    y(position) = (y(position - 1) + alpha * value * h) / (1 + alpha * h);
end

% Function to solve parabolic PDE using FDM
function [x, t, u] = solve_parabolic_pde(f, a, b, c, L, T, Nx, Nt)
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

% Function to solve hyperbolic PDE using FDM
function [x, t, u] = solve_hyperbolic_pde(f, g, a, b, L, T, Nx, Nt)
    x = linspace(0, L, Nx+1);
    t = linspace(0, T, Nt+1);
    dx = L / Nx;
    dt = T / Nt;
    r = b * dt / dx;
    u = zeros(Nx+1, Nt+1);

    % Initial condition
    u(:,1) = f(x);
    u(:,2) = u(:,1) + dt * g(x);

    % Time stepping
    for n = 2:Nt
        for i = 2:Nx
            u(i,n+1) = 2 * u(i,n) - u(i,n-1) + r^2 * (u(i+1,n) - 2*u(i,n) + u(i-1,n));
        end
        % Apply boundary conditions
        u(1,n+1) = 0;  % Dirichlet condition at x=0
        u(Nx+1,n+1) = 0;  % Dirichlet condition at x=L
    end
end

% Function to solve elliptic PDE using FDM
function [x, y, u] = solve_elliptic_pde(f, g, Lx, Ly, Nx, Ny)
    x = linspace(0, Lx, Nx+1);
    y = linspace(0, Ly, Ny+1);
    dx = Lx / Nx;
    dy = Ly / Ny;
    u = zeros(Nx+1, Ny+1);

    % Apply boundary conditions
    u(:,1) = f(x);  % Dirichlet condition at y=0
    u(:,Ny+1) = g(x);  % Dirichlet condition at y=Ly

    % Iterative solution (Gauss-Seidel method)
    for iter = 1:1000
        for i = 2:Nx
            for j = 2:Ny
                u(i,j) = 0.25 * (u(i+1,j) + u(i-1,j) + u(i,j+1) + u(i,j-1));
            end
        end
    end
end

%% Variables

% Example PDE coefficients for classification
a = 1; b = 0; c = -1;  % Example: u_xx - u_tt = 0 (Wave equation)

% Example functions and parameters for solving PDEs
f = @(x) sin(pi * x);  % Initial condition
g = @(x) 0;  % Initial velocity (for hyperbolic PDE)
L = 1;  % Length of the domain
T = 1;  % Total time
Nx = 20;  % Number of spatial steps
Nt = 50;  % Number of time steps

% Elliptic PDE boundary conditions
f_elliptic = @(x) 0;  % Boundary condition at y=0
g_elliptic = @(x) sin(pi * x);  % Boundary condition at y=Ly
Lx = 1;  % Length of the domain in x-direction
Ly = 1;  % Length of the domain in y-direction
Ny = 20;  % Number of spatial steps in y-direction

%% PDE Classification

% Classify the PDE
pde_type = classify_pde(a, b, c);
disp(['The PDE is classified as: ', pde_type]);

%% Numerical Methods

% Solve Parabolic PDE
[x_parabolic, t_parabolic, u_parabolic] = solve_parabolic_pde(f, a, b, c, L, T, Nx, Nt);

% Solve Hyperbolic PDE
[x_hyperbolic, t_hyperbolic, u_hyperbolic] = solve_hyperbolic_pde(f, g, a, b, L, T, Nx, Nt);

% Solve Elliptic PDE
[x_elliptic, y_elliptic, u_elliptic] = solve_elliptic_pde(f_elliptic, g_elliptic, Lx, Ly, Nx, Ny);

%% Display

disp('Numerical solutions of PDEs:');
disp(' ');

disp('Parabolic PDE solution:');
disp(u_parabolic);
disp(' ');

disp('Hyperbolic PDE solution:');
disp(u_hyperbolic);
disp(' ');

disp('Elliptic PDE solution:');
disp(u_elliptic);
disp(' ');

%% Plot

% Plot Parabolic PDE solution
figure;
surf(x_parabolic, t_parabolic, u_parabolic');
title('Parabolic PDE Solution');
xlabel('x');
ylabel('t');
zlabel('u');
shading interp;

% Plot Hyperbolic PDE solution
figure;
surf(x_hyperbolic, t_hyperbolic, u_hyperbolic');
title('Hyperbolic PDE Solution');
xlabel('x');
ylabel('t');
zlabel('u');
shading interp;

% Plot Elliptic PDE solution
figure;
surf(x_elliptic, y_elliptic, u_elliptic');
title('Elliptic PDE Solution');
xlabel('x');
ylabel('y');
zlabel('u');
shading interp;

% End of the script
