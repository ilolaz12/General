% gauss_law.m
% This script estimates the charge density rho using Gauss's law for electric fields 
% for both 1D and 2D domains.
% Author: Ilona (U1551168)
% Date: 11 Aug 2024
% Version: 4.0

%% Functions
function [rho_forward, rho_backward, rho_central, errors] = estimateRho1d(x, delta)
    % Calculates rho at the specific point x using finite differences for the 1D problem
    rho_forward = (cos(x + delta) - cos(x)) / delta; % Forward difference
    rho_backward = (cos(x) - cos(x - delta)) / delta; % Backward difference
    rho_central = (cos(x + delta) - cos(x - delta)) / (2 * delta); % Central difference
    rho_exact = -sin(x);  % The derivative of cos(x) 
    % Calculate absolute errors for each finite difference method
    errors = struct('forward', abs(rho_forward - rho_exact), ...
                    'backward', abs(rho_backward - rho_exact), ...
                    'central', abs(rho_central - rho_exact));
end

function [rho, rho_x, rho_y, Dx_plus, Dx_minus, Dy_plus, Dy_minus] = estimateRho2d(x, y, delta)
    % Computes rho for 2D using central differences with detailed output
    Dx_plus = (1 + 7.6772) * exp(-(x + delta)) * sin(y);
    Dx_minus = (1 + 7.6772) * exp(-(x - delta)) * sin(y);
    Dy_plus = sin(x) * cos(y + delta);
    Dy_minus = sin(x) * cos(y - delta);
    rho_x = (Dx_plus - Dx_minus) / (2 * delta);
    rho_y = (Dy_plus - Dy_minus) / (2 * delta);
    rho = rho_x + rho_y;
    % Print intermediate results for 2D problem
    fprintf('Results for intermediate values for 2D problem:\n');
    fprintf('Dx_plus: %.4f\n', Dx_plus);
    fprintf('Dx_minus: %.4f\n', Dx_minus);
    fprintf('Dy_plus: %.4f\n', Dy_plus);
    fprintf('Dy_minus: %.4f\n', Dy_minus);
end

%% Variables
x_1d = 6;          % Specific point for 1D
x_2d = 3;          % Specific x-point for 2D
y_2d = 3;          % Specific y-point for 2D
delta = 0.5;       % Delta value

%% Calculations for 1D using finite differences
[rho_forward, rho_backward, rho_central, errors_1d] = estimateRho1d(x_1d, delta);
% Print results for 1D problem at x = 6
fprintf('1D Problem, estimates solutions at x = %.1f, Delta = %.1f :\n', x_1d, delta);
fprintf('Forward Difference: %.4f\n', rho_forward);
fprintf('Backward Difference: %.4f\n', rho_backward);
fprintf('Central Difference: %.4f\n\n', rho_central);

%% Calculations for 2D
[rho_2d, rho_x_2d, rho_y_2d, Dx_plus, Dx_minus, Dy_plus, Dy_minus] = estimateRho2d(x_2d, y_2d, delta);
% Print results for 2D problem
fprintf('2D Problem, estimates solutions at (x, y) = (%.1f, %.1f), Delta = %.1f :\n', x_2d, y_2d, delta);
fprintf('Rho: %.4f\n\n', rho_2d);

%% Display and Analysis
% Display errors and details
fprintf('1D Problem - Errors: Forward: %.4f, Backward: %.4f, Central: %.4f\n', ...
        errors_1d.forward, errors_1d.backward, errors_1d.central);

%% Visualization for 1D Problem
% Assuming `estimateRho1d_vectorized` calculates rho for a vector of x-values
fine_x_1d = 1:delta:10;  % Define a range for x
[rho_1Dvectorized, ~, ~, ~] = arrayfun(@(x) estimateRho1d(x, delta), fine_x_1d);

%% Grid Refinement for 1D (Loop-Based Approach)
delta = 0.5; % Starting grid size
fine_x_1d = 1:delta:10; % Initial fine grid
max_error = inf; % Initialize maximum error
iteration_count = 0;
max_iterations = 20; % Set a limit for the maximum number of iterations
rho_1Dloop = zeros(1, length(fine_x_1d)); % Preallocate
% Loop through each point in the current grid (fine_x_1d) to calculate rho using central differences
while max_error >= 0.0001 && iteration_count < max_iterations
    for i = 1:length(fine_x_1d)
        [rho_forward, rho_backward, rho_central, errors] = estimateRho1d(fine_x_1d(i), delta);
        % Store the central difference result for the current grid point in the loop-based results array
        rho_1Dloop(i) = rho_central;
    end
    % Determine the maximum error
    max_error = max([errors.forward, errors.backward, errors.central]);
    % Check if the maximum error is below the desired threshold, if so-break loop
    if max_error < 0.0001
        break;
    end
    delta = delta / 2; % Reduce grid size
    fine_x_1d = 1:delta:10; % Update grid
    iteration_count = iteration_count + 1; % Increment iteration counter
end

fprintf('Loop-based 1D Grid Delta: %.4f with Max Error: %.4f\n', delta, max_error);
figure;
plot(fine_x_1d, rho_1Dloop, 'b-', 'LineWidth', 2); 
title('Loop-based 1D Grid Visualization');
xlabel('x'); ylabel('ρ(x)');
grid on;

%% Grid Refinement for 1D (Vectorized Approach)
delta = 0.5; % Reset starting grid size
fine_x_1d = 1:delta:10; % Initial fine grid for vectorized
% Iterate until the maximum error is below the threshold or the maximum number of iterations is reached
while max_error >= 0.0001 && iteration_count < max_iterations
    [rho_forward, rho_backward, rho_central, ~] = arrayfun(@(x) estimateRho1d(x, delta), fine_x_1d);
    rho_1Dvectorized = rho_central; % Central difference for visualization
    max_error = max(abs(rho_central + sin(fine_x_1d))); % Direct error calculation
    % Check if the maximum error is below the desired threshold, if so-break loop
    if max_error < 0.0001
        break;
    end
    delta = delta / 2; % Reduce grid size
    fine_x_1d = 1:delta:10; % Update grid
    iteration_count = iteration_count + 1; % Increment iteration counter
end

fprintf('Vectorized 1D Grid Delta: %.4f with Max Error: %.4f\n', delta, max_error);
figure;
plot(fine_x_1d, rho_1Dvectorized, 'r-', 'LineWidth', 2); 
title('Vectorized 1D Grid Visualization');
xlabel('x'); ylabel('ρ(x)');
grid on;

%% Visualization for 2D Problem
[X_plot, Y_plot] = meshgrid(1:delta:10, 1:delta:10);
U = -7.6772 * exp(-X_plot) .* sin(Y_plot); % X-component of the electric field
V = -sin(X_plot) .* sin(Y_plot);           % Y-component of the electric field

figure;
quiver(X_plot, Y_plot, U, V); % Quiver plot to show electric field vectors
title('Vectorized 2D Electric Field Representation');
xlabel('x'); ylabel('y');
axis tight;
grid on;