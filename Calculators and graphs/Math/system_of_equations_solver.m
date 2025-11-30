% This script provides methods for solving different types of systems of
% linear equations, including over-determined, under-determined, and
% ill-conditioned systems.  
% Author: Ilona Date: 19 July 2024
% Version: 1.0

%% Functions
% Define a function to solve determinate systems using Gaussian elimination
function x = solveDeterminateGaussianElimination(A, b)
    x = A\b;  % Using MATLAB's backslash operator for Gaussian elimination
end

% Define a function to solve over-determined systems using least squares
function x_ls = solveOverDetermined(A, b)
    x_ls = A\b;  % Least squares solution
end

% Define a function to solve under-determined systems using pseudoinverse
function x_ud = solveUnderDetermined(A, b)
    x_ud = pinv(A) * b;  % Pseudoinverse solution
end

% Define a function to check the condition number for ill-conditioned
% systems
function cond_number = checkConditionNumber(A)
    cond_number = cond(A);
end

%% Variables
% Define the over-determined system (Change these values to test different
% systems)
A_over = [1 1; 1 2; 1 3];  % More rows than columns
b_over = [3; 5; 7];  % Right-hand side vector

% Define the under-determined system (Change these values to test different systems)
A_under = [1 0 -0.5; 0 1 -1.5];  % Fewer rows than columns
b_under = [1.6071; 1.4643];  % Right-hand side vector

% Define the ill-conditioned system (Change these values to test different systems)
A_ill = [1 1; 1 1.0001];  % Nearly singular matrix
b_ill = [2; 2.0001];  % Right-hand side vector

% Define a determinate system (Change these values to test different systems)
A_det = [2 1; 1 -1];  % Non-singular square matrix
b_det = [1; 0];  % Right-hand side vector

% Define a homogeneous system (Change these values to test different systems)
A_hom = [2 1; 1 -1];  % Non-singular square matrix
b_hom = [0; 0];  % Right-hand side vector (homogeneous case)

%% Solve Systems
% Solve the determinate system using Gaussian elimination
x_det = solveDeterminateGaussianElimination(A_det, b_det);
disp('Gaussian elimination solution for the determinate system:');
disp(x_det);

% Solve the over-determined system
x_ls = solveOverDetermined(A_over, b_over);
disp('Least squares solution for the over-determined system:');
disp(x_ls);

% Calculate and display the residuals for the least squares solution
residuals_ls = A_over * x_ls - b_over;
disp('Residuals for the least squares solution:');
disp(residuals_ls);

% Solve the under-determined system
x_ud = solveUnderDetermined(A_under, b_under);
disp('Pseudoinverse solution for the under-determined system:');
disp(x_ud);

% Solve the ill-conditioned system
cond_number = checkConditionNumber(A_ill);
disp('Condition number of the ill-conditioned matrix:');
disp(cond_number);

x_ill = A_ill\b_ill;
disp('Solution for the ill-conditioned system:');
disp(x_ill);

% Solve the homogeneous system
x_hom = solveDeterminateGaussianElimination(A_hom, b_hom);
disp('Solution for the homogeneous system:');
disp(x_hom);

%% Plot
% Create a plot to visualize the results

% Plot over-determined system solution
figure;
subplot(3, 1, 1);
plot(A_over * x_ls, 'o-', 'DisplayName', 'Over-Determined Solution');
title('Over-Determined System');
legend;

% 3D Plot for under-determined system solution
figure;
subplot(2, 1, 1);
plot3(1, 0, -0.5, 'ro'); hold on;
plot3(0, 1, -1.5, 'bo');
grid on;
xlabel('x');
ylabel('y');
zlabel('z');
title('Under-Determined System Equations');
legend('Eq. (1)', 'Eq. (2)');

subplot(2, 1, 2);
plot3(x_ud(1), x_ud(2), 0, 'g+', 'MarkerSize', 10); hold on;
plot3(x_ud(1), x_ud(2), x_ud(3), 'gx', 'MarkerSize', 10);
grid on;
xlabel('x');
ylabel('y');
zlabel('z');
title('Under-Determined System Solutions');
legend('Solution', 'Solution (specific point)');

% Plot ill-conditioned system solution
figure;
subplot(3, 1, 3);
plot(A_ill * x_ill, 'o-', 'DisplayName', 'Ill-Conditioned Solution');
title('Ill-Conditioned System');
legend;

%% Transpose or Other Important Controls
% Example of transposing a matrix
disp('Transpose of the over-determined matrix:');
disp(A_over');
