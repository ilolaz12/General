% Trigonometric Functions in Degrees Library with Example
% File Name: trig_functions_degrees.m
% Description: This library includes trigonometric functions that operate on angles in degrees,
% along with an example usage section.
% Author: Ilona Lazareva (U1551168)
% Date: 1 July 2024
% Version: 1.0

%% Functions

% Function to calculate sine of an angle in degrees
function [y] = sindeg(x)
    y = sind(x);
end

% Function to calculate cosine of an angle in degrees
function [y] = cosdeg(x)
    y = cosd(x);
end

% Function to calculate tangent of an angle in degrees
function [y] = tandeg(x)
    y = tand(x);
end

% Function to calculate arcsine of a value, result in degrees
function [y] = asindeg(x)
    y = asind(x);
end

% Function to calculate arccosine of a value, result in degrees
function [y] = acosdeg(x)
    y = acosd(x);
end

% Function to calculate arctangent of a value, result in degrees
function [y] = atandeg(x)
    y = atand(x);
end

% Function to calculate arctangent of y/x, result in degrees
function [y] = atan2deg(y, x)
    y = atan2d(y, x);
end

%% Variables

% Test angles (degrees)
x = [0 30 45 60 90];

% Hand calculated results for sine
hand_calc_sin = [0 0.5 1/sqrt(2) sqrt(3)/2 1];

% Hand calculated results for cosine
hand_calc_cos = [1 sqrt(3)/2 1/sqrt(2) 0.5 0];

% Hand calculated results for tangent
hand_calc_tan = [0 sqrt(3)/3 1 sqrt(3) Inf];

% Values for arcsine test
asin_vals = [0 0.5 1/sqrt(2) sqrt(3)/2 1];

% Expected results for arcsine
expected_asin = [0 30 45 60 90];

% Values for arccosine test
acos_vals = [1 sqrt(3)/2 1/sqrt(2) 0.5 0];

% Expected results for arccosine
expected_acos = [0 30 45 60 90];

% Values for arctangent test
atan_vals = [0 sqrt(3)/3 1 sqrt(3) Inf];

% Expected results for arctangent
expected_atan = [0 30 45 60 90];

% Values for atan2 test
atan2_y_vals = [0 1 1 -1 -1];
atan2_x_vals = [1 1 -1 -1 1];

% Expected results for atan2
expected_atan2 = [0 45 135 -135 -45];

%% Display

% Calculate sine
y_sin = sindeg(x);
disp(['For the angles:  ', num2str(x), ' in degrees'])
disp(['the sine is:     ', num2str(y_sin)])
disp(['Hand calcs give: ', num2str(hand_calc_sin)])

% Calculate cosine
y_cos = cosdeg(x);
disp(['For the angles:  ', num2str(x), ' in degrees'])
disp(['the cosine is:   ', num2str(y_cos)])
disp(['Hand calcs give: ', num2str(hand_calc_cos)])

% Calculate tangent
y_tan = tandeg(x);
disp(['For the angles:  ', num2str(x), ' in degrees'])
disp(['the tangent is:  ', num2str(y_tan)])
disp(['Hand calcs give: ', num2str(hand_calc_tan)])

% Calculate arcsine
y_asin = asindeg(asin_vals);
disp(['For the values:  ', num2str(asin_vals)])
disp(['the arcsine is:  ', num2str(y_asin)])
disp(['Expected:        ', num2str(expected_asin)])

% Calculate arccosine
y_acos = acosdeg(acos_vals);
disp(['For the values:  ', num2str(acos_vals)])
disp(['the arccosine is:', num2str(y_acos)])
disp(['Expected:        ', num2str(expected_acos)])

% Calculate arctangent
y_atan = atandeg(atan_vals);
disp(['For the values:  ', num2str(atan_vals)])
disp(['the arctangent is:', num2str(y_atan)])
disp(['Expected:        ', num2str(expected_atan)])

% Calculate arctangent of y/x
y_atan2 = atan2deg(atan2_y_vals, atan2_x_vals);
disp(['For the values:  ', num2str(atan2_y_vals) ', ' num2str(atan2_x_vals)])
disp(['the atan2 is:    ', num2str(y_atan2)])
disp(['Expected:        ', num2str(expected_atan2)])
