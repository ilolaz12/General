% curve_fitting_analysis.m
% This script analyzes a set of data points to find the best-fit curve using
% linear, exponential, and power functions. It involves hand calculations,
% data verification, and regression analysis using MATLAB.
% Author: Ilona Lazareva (U1551168)
% Date: 24 July 2024
% Version: 4.0

%% Functions
function coeffs = linearFit(x, y)
    % linearFit performs linear regression to find coefficients for y = a + bx
    % Inputs:
    %   x - independent variable
    %   y - dependent variable
    % Outputs:
    %   coeffs - coefficients [a, b]

    A = [ones(length(x), 1), x];
    coeffs = A\y;
end

function coeffs = exponentialFit(x, y)
    % exponentialFit performs exponential regression to find coefficients for y = ae^(bx)
    % Inputs:
    %   x - independent variable
    %   y - dependent variable
    % Outputs:
    %   coeffs - coefficients [a, b]

    A = [ones(length(x), 1), x];
    logy = log(y);
    log_coeffs = A\logy;
    coeffs = [exp(log_coeffs(1)), log_coeffs(2)];
end

function coeffs = powerFit(x, y)
    % powerFit performs power regression to find coefficients for y = ax^2 + bx + c
    % Inputs:
    %   x - independent variable
    %   y - dependent variable
    % Outputs:
    %   coeffs - coefficients [a, b]

    % Ensure all x are positive for power fit
    positive_indices = x > 0;
    x_positive = x(positive_indices);
    y_positive = y(positive_indices);
    
    % Fit a quadratic polynomial y = ax^2 + bx + c
    p = polyfit(x_positive, y_positive, 2);
    coeffs = [p(1), p(2), p(3)];
end

function r2 = computeRSquared(y, y_fit)
    % computeRSquared calculates the coefficient of determination (r^2)
    % Inputs:
    %   y - actual y values
    %   y_fit - fitted y values
    % Outputs:
    %   r2 - coefficient of determination

    SS_res = sum((y - y_fit).^2);
    SS_tot = sum((y - mean(y)).^2);
    r2 = 1 - (SS_res / SS_tot);
end

function excelCalcResults = excelCalculations(x_k, y_k, x_k1, y_k1)
    % excelCalculations performs calculations for linear, exponential, and
    % power fits comparison to store it to excel
    % Inputs:
    %   x_k - independent variable at k
    %   y_k - dependent variable at k
    %   x_k1 - independent variable at k+1
    %   y_k1 - dependent variable at k+1
    % Outputs:
    %   handCalcResults - table with hand calculation results
    
    % Linear Fit
    a_linear = (y_k * x_k1 - y_k1 * x_k) / (x_k1 - x_k);
    b_linear = (y_k1 - y_k) / (x_k1 - x_k);

    % Exponential Fit
    log_y_k = log(y_k);
    log_y_k1 = log(y_k1);
    log_a_exp = (log_y_k * x_k1 - log_y_k1 * x_k) / (x_k1 - x_k);
    b_exp = (log_y_k1 - log_y_k) / (x_k1 - x_k);
    a_exp = exp(log_a_exp);

    % Power Fit
    log_x_k = log(x_k);
    log_x_k1 = log(x_k1);
    log_a_power = (log_y_k * log_x_k1 - log_y_k1 * log_x_k) / (log_x_k1 - log_x_k);
    b_power = (log_y_k1 - log_y_k) / (log_x_k1 - log_x_k);
    a_power = exp(log_a_power);

    % Round the coefficients to three significant figures
    a_linear = round(a_linear, 3);
    b_linear = round(b_linear, 3);
    a_exp = round(a_exp, 3);
    b_exp = round(b_exp, 3);
    a_power = round(a_power, 3);
    b_power = round(b_power, 3);

    % Create a table for hand calculation results
    excelCalcResults = table([x_k; x_k1], [y_k; y_k1], ...
                             [a_linear; NaN], [b_linear; NaN], ...
                             [a_exp; NaN], [b_exp; NaN], ...
                             [a_power; NaN], [b_power; NaN], ...
                             'VariableNames', {'x', 'y', 'a_lin', 'b_lin', 'a_exp', 'b_exp', 'a_pow', 'b_pow'});
end
%% Variables
% Load data from CSV file
data = readtable('G:/My Drive/Study/UQS/ENG3104 - Engineering Simulations and Computations/ass/2/A2Q2_input.csv');
x = data{:, 1};
y = data{:, 2};

% Define the specific data points for hand/excel calculations
k = round(20 + 4.1986); % Nearest integer
x_k = x(k);
y_k = y(k);
x_k1 = x(k+1);
y_k1 = y(k+1);

% Display the data points
fprintf('Data points used for hand calculations:\n');
fprintf('Point 1: (x = %.3f, y = %.3f)\n', x_k, y_k);
fprintf('Point 2: (x = %.3f, y = %.3f)\n', x_k1, y_k1);

% Perform hand calculations
excelCalcResults = excelCalculations(x_k, y_k, x_k1, y_k1);

% Display hand calculation results
disp('Manual Calculation Coefficients (rounded to three significant figures):');
disp(excelCalcResults);

%% Fit Models
% Fit linear model
p_linear = linearFit(x, y);

% Fit exponential model
coeffs_exp = exponentialFit(x, y);

% Use provided coefficients for power fit
coeffs_power = powerFit(x, y);

%% Predict Function Value
x_star = 2 + 3.5028 / 10;
y_pred_power = coeffs_power(1) * (x_star^2) + coeffs_power(2) * x_star + coeffs_power(3);

disp('Predicted y value at x* = 2 + 3.5028 / 10:');
disp(y_pred_power);

%% Write Results to CSV
writetable(excelCalcResults, 'G:/My Drive/Study/UQS/ENG3104 - Engineering Simulations and Computations/ass/2/A2Q2_matlab.csv');

%% Plot Best Fit
figure;
plot(x, y, 'bo'); % Plot original data points as blue circles
hold on;

% Plot linear fit as -
y_linear = p_linear(1) + p_linear(2) * x;
plot(x, y_linear, '-'); 

% Plot exponential fit as --
y_exp = coeffs_exp(1) * exp(coeffs_exp(2) * x);
plot(x, y_exp, '--'); 

% Plot power fit as -.
positive_indices = x > 0;
x_positive = x(positive_indices);
y_power = coeffs_power(1) * (x_positive.^2) + coeffs_power(2) * x_positive + coeffs_power(3);
plot(x_positive, y_power, '-.'); 

legend('Data', 'Linear Fit', 'Exponential Fit', 'Power Fit');
xlabel('x');
ylabel('y');
title('Curve Fitting');
hold off;

%% Find x* in range of -2 to -1 for max R-squared
x_star_range = -2:0.01:-1;
r2_values = zeros(length(x_star_range), 1);

for i = 1:length(x_star_range)
    x_star = x_star_range(i);
    y_power_fit = coeffs_power(1) * (x_star.^2) + coeffs_power(2) * x_star + coeffs_power(3);
    r2_values(i) = computeRSquared(y, y_power_fit);
end

[max_r2, max_idx] = max(r2_values);
best_x_star = x_star_range(max_idx);

disp('Best x* for maximum R-squared:');
disp(best_x_star);

% Plot R-squared as a function of x*
figure;
plot(x_star_range, r2_values, '-');
xlabel('x*');
ylabel('R-squared');
title('R-squared as a function of x*');

%% Determine best fit and estimate function value at x*
if max_r2 > computeRSquared(y, coeffs_exp(1) * exp(coeffs_exp(2) * x))
    best_fit = 'Power Fit';
    y_estimate = coeffs_power(1) * (best_x_star^2) + coeffs_power(2) * best_x_star + coeffs_power(3);
else
    best_fit = 'Exponential Fit';
    y_estimate = coeffs_exp(1) * exp(coeffs_exp(2) * best_x_star);
end

disp('Best fit model:');
disp(best_fit);

disp('Estimated function value at x*:');
disp(y_estimate);