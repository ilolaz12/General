% This script covers basic mathematical concepts, analytical and numerical 
% differentiation, numerical integration methods, and the use of MATLAB 
% functions for solving differential equations. 

%% Functions

% Function to calculate the analytical derivative
function dy = analytical_derivative(f, x)
    syms y(x);
    y(x) = f(x);
    dy = diff(y, x);
end

% Function to calculate the numerical derivative (Forward Difference)
function dy_num = forward_difference(f, x, h)
    dy_num = (f(x + h) - f(x)) / h;
end

% Function to calculate the numerical derivative (Central Difference)
function dy_num = central_difference(f, x, h)
    dy_num = (f(x + h) - f(x - h)) / (2 * h);
end

% Function to calculate the Taylor series expansion
function taylor_exp = taylor_series(f, x, n)
    syms y(x);
    y(x) = f(x);
    taylor_exp = taylor(y, x, 'Order', n);
end

% Function to calculate numerical integration (Trapezoidal Rule)
function integral_val = trapezoidal_rule(f, a, b, n)
    x = linspace(a, b, n+1);
    y = f(x);
    h = (b - a) / n;
    integral_val = h * (sum(y) - (y(1) + y(end)) / 2);
end

% Function to solve differential equation using ode45
function [t, y] = solve_ode45(odefun, tspan, y0)
    [t, y] = ode45(odefun, tspan, y0);
end

%% Variables

% Example function for differentiation and integration
f = @(x) sin(x);

% Point of differentiation
x0 = pi / 4;

% Step size for numerical differentiation
h = 0.01;

% Interval for integration
a = 0;
b = pi;

% Number of subintervals for integration
n = 100;

% Differential equation example for ode45
odefun = @(t, y) -2 * y + t;
tspan = [0 5];
y0 = 1;

%% Analytical and Numerical Differentiation

% Analytical derivative
dy_analytical = analytical_derivative(f, x0);

% Numerical derivative (Forward Difference)
dy_forward = forward_difference(f, x0, h);

% Numerical derivative (Central Difference)
dy_central = central_difference(f, x0, h);

% Taylor series expansion
taylor_exp = taylor_series(f, x0, 5);

%% Numerical Integration

% Trapezoidal Rule
integral_trap = trapezoidal_rule(f, a, b, n);

% Solving differential equation using ode45
[t, y] = solve_ode45(odefun, tspan, y0);

%% Error Analysis

% Error in numerical differentiation (Forward Difference)
error_forward = abs(dy_analytical - dy_forward);

% Error in numerical differentiation (Central Difference)
error_central = abs(dy_analytical - dy_central);

%% Display

disp('Analytical and Numerical Differentiation:');
disp(['Analytical derivative at x0: ', char(dy_analytical)]);
disp(['Numerical derivative (Forward Difference) at x0: ', num2str(dy_forward)]);
disp(['Numerical derivative (Central Difference) at x0: ', num2str(dy_central)]);
disp(' ');

disp('Taylor Series Expansion:');
disp(taylor_exp);
disp(' ');

disp('Numerical Integration:');
disp(['Trapezoidal Rule integral: ', num2str(integral_trap)]);
disp(' ');

disp('Error Analysis:');
disp(['Error in numerical differentiation (Forward Difference): ', num2str(error_forward)]);
disp(['Error in numerical differentiation (Central Difference): ', num2str(error_central)]);
disp(' ');

%% Plot

% Plot the function and its Taylor series expansion
figure;
fplot(f, [a b]);
hold on;
fplot(matlabFunction(taylor_exp), [a b], '--');
title('Function and Taylor Series Expansion');
xlabel('x');
ylabel('y');
legend('Original Function', 'Taylor Series Expansion');

% Plot the numerical integration result
figure;
fplot(f, [a b]);
hold on;
fill([a linspace(a, b, n+1) b], [0 arrayfun(f, linspace(a, b, n+1)) 0], 'r', 'FaceAlpha', 0.3, 'EdgeColor', 'none');
title('Numerical Integration using Trapezoidal Rule');
xlabel('x');
ylabel('y');
legend('Original Function', 'Trapezoidal Rule');

% Plot the solution of the differential equation
figure;
plot(t, y, '-o');
title('Solution of the Differential Equation using ode45');
xlabel('t');
ylabel('y');
legend('ode45 Solution');

% End of the script
