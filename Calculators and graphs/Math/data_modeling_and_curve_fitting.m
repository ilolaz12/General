% This script covers various aspects of data modeling, error analysis,
% and curve fitting. 
% Author: Ilona Date: 19 July 2024
% Version: 1.0

%% Functions
% Define a function for linear fitting
function p = linearFit(x, y)
    p = polyfit(x, y, 1);
end

% Define a function for polynomial fitting
function p = polynomialFit(x, y, degree)
    p = polyfit(x, y, degree);
end

% Define a function for exponential fitting
function f = exponentialFit(x, y)
    f = fit(x, y, 'exp1');
end

% Define a function for power fitting
function f = powerFit(x, y)
    f = fit(x, y, 'power1');
end

% Define a function for logarithmic fitting
function f = logarithmicFit(x, y)
    f = fit(log(x), y, 'poly1');
end

% Define a function for sinusoidal fitting
function f = sinusoidalFit(x, y)
    f = fit(x, y, 'sin1');
end

% Define a function to calculate R-Square
function R2 = calculateRSquare(y, yfit)
    SSresid = sum((y - yfit).^2);
    SStotal = (length(y) - 1) * var(y);
    R2 = 1 - SSresid/SStotal;
end

%% Variables
% Example data (Change these values to test different datasets)
x = linspace(1, 10, 10);  % Independent variable
y = 2 * x + 3 + randn(1, 10);  % Dependent variable with noise

%% Data Modeling
% Linear fit
p_linear = linearFit(x, y);
yfit_linear = polyval(p_linear, x);

% Polynomial fit
degree = 2;  % Change degree for different polynomial fits
p_poly = polynomialFit(x, y, degree);
yfit_poly = polyval(p_poly, x);

% Exponential fit
f_exp = exponentialFit(x', y');
yfit_exp = f_exp(x);

% Power fit
f_power = powerFit(x', y');
yfit_power = f_power(x);

% Logarithmic fit
f_log = logarithmicFit(x', y');
yfit_log = f_log(log(x));

%% Error Analysis
% Calculate residuals for each fit
residuals_linear = y - yfit_linear;
residuals_poly = y - yfit_poly;
residuals_exp = y - yfit_exp';
residuals_power = y - yfit_power';
residuals_log = y - yfit_log';

%% Variance and Standard Deviation
variance_y = var(y);
stddev_y = std(y);

%% R-Square Calculation
R2_linear = calculateRSquare(y, yfit_linear);
R2_poly = calculateRSquare(y, yfit_poly);
R2_exp = calculateRSquare(y, yfit_exp');
R2_power = calculateRSquare(y, yfit_power');
R2_log = calculateRSquare(y, yfit_log');

%% Plot
% Plot original data and fits
figure;
subplot(3, 2, 1);
scatter(x, y); hold on;
plot(x, yfit_linear);
title(['Linear Fit, R^2 = ', num2str(R2_linear)]);
legend('Data', 'Linear Fit');

subplot(3, 2, 2);
scatter(x, y); hold on;
plot(x, yfit_poly);
title(['Polynomial Fit (degree = ', num2str(degree), '), R^2 = ', num2str(R2_poly)]);
legend('Data', 'Polynomial Fit');

subplot(3, 2, 3);
scatter(x, y); hold on;
plot(x, yfit_exp);
title(['Exponential Fit, R^2 = ', num2str(R2_exp)]);
legend('Data', 'Exponential Fit');

subplot(3, 2, 4);
scatter(x, y); hold on;
plot(x, yfit_power);
title(['Power Fit, R^2 = ', num2str(R2_power)]);
legend('Data', 'Power Fit');

subplot(3, 2, 5);
scatter(x, y); hold on;
plot(log(x), yfit_log);
title(['Logarithmic Fit, R^2 = ', num2str(R2_log)]);
legend('Data', 'Logarithmic Fit');

%% Additional Controls
% Display variance and standard deviation
disp('Variance of y:');
disp(variance_y);
disp('Standard Deviation of y:');
disp(stddev_y);