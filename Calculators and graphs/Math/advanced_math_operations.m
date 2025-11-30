% Advanced Mathematical Operations Library
% File Name: advanced_math_operations.m
% Description: This library includes functions for various advanced mathematical operations,
% such as trigonometric calculations, logarithmic calculations, and complex mathematical operations.
% Author: Ilona Lazareva (U1551168)
% Date: 1 July 2024
% Version: 1.0

%% Functions
% Trigonometric Functions
% Function to calculate the expression 6*pi*atan(12.5) + 4
function [result] = calculate_a()
    result = 6 * pi * atan(12.5) + 4;
end
% Function to calculate the expression 5*tan(3*asin(13/5))
function [result] = calculate_b()
    result = 5 * tan(3 * asin(13 / 5));
end

% Logarithmic Functions
% Function to calculate the expression 5*log(7)
function [result] = calculate_c()
    result = 5 * log(7);
end
% Function to calculate the expression 5*log10(7)
function [result] = calculate_d()
    result = 5 * log10(7);
end

% Calculus Functions
% Function to calculate the derivative of a polynomial
function [derivative] = polynomial_derivative(coefficients)
    n = length(coefficients);
    derivative = coefficients(1:end-1) .* (n-1:-1:1);
end
% Function to calculate the integral of a polynomial
function [integral] = polynomial_integral(coefficients)
    n = length(coefficients);
    integral = [coefficients ./ (n:-1:1), 0];
end

% Complex Number Functions
% Function to calculate the magnitude of a complex number
function [magnitude] = complex_magnitude(real_part, imag_part)
    magnitude = sqrt(real_part^2 + imag_part^2);
end
% Function to calculate the argument of a complex number
function [argument] = complex_argument(real_part, imag_part)
    argument = atan2(imag_part, real_part);
end

% Linear Algebra Functions
% Function to calculate the determinant of a matrix
function [determinant] = matrix_determinant(matrix)
    determinant = det(matrix);
end
% Function to calculate the inverse of a matrix
function [inverse] = matrix_inverse(matrix)
    inverse = inv(matrix);
end

% Advanced Trigonometric Functions
% Function to calculate the hyperbolic sine of an angle
function [result] = hyperbolic_sine(angle)
    result = sinh(angle);
end
% Function to calculate the hyperbolic cosine of an angle
function [result] = hyperbolic_cosine(angle)
    result = cosh(angle);
end
% Function to calculate the hyperbolic tangent of an angle
function [result] = hyperbolic_tangent(angle)
    result = tanh(angle);
end

% Advanced Logarithmic Functions
% Function to calculate the natural logarithm of a complex number
function [result] = complex_logarithm(real_part, imag_part)
    magnitude = complex_magnitude(real_part, imag_part);
    argument = complex_argument(real_part, imag_part);
    result = log(magnitude) + 1i * argument;
end
% Function to calculate the logarithm base 2
function [result] = logarithm_base_2(value)
    result = log2(value);
end
% Function to calculate the logarithm base n
function [result] = logarithm_base_n(value, base)
    result = log(value) / log(base);
end

% Calculate (a)
a = calculate_a();
disp('The result of calculation (a) is:')
disp(a)

% Calculate (b)
b = calculate_b();
disp('The result of calculation (b) is:')
disp(b)

% Calculate (c)
c = calculate_c();
disp('The result of calculation (c) is:')
disp(c)

% Calculate (d)
d = calculate_d();
disp('The result of calculation (d) is:')
disp(d)

%% Variables
% Polynomial derivative
coefficients = [3, 2, 1]; % 3x^2 + 2x + 1
derivative = polynomial_derivative(coefficients);
disp('The derivative of the polynomial is:')
disp(derivative)

% Polynomial integral
integral = polynomial_integral(coefficients);
disp('The integral of the polynomial is:')
disp(integral)

% Complex number magnitude and argument
real_part = 3;
imag_part = 4;
magnitude = complex_magnitude(real_part, imag_part);
argument = complex_argument(real_part, imag_part);
disp('The magnitude of the complex number is:')
disp(magnitude)
disp('The argument of the complex number is:')
disp(argument)

% Matrix determinant and inverse
matrix = [1, 2; 3, 4];
determinant = matrix_determinant(matrix);
inverse = matrix_inverse(matrix);
disp('The determinant of the matrix is:')
disp(determinant)
disp('The inverse of the matrix is:')
disp(inverse)

% Hyperbolic functions
angle = pi / 4;
sinh_result = hyperbolic_sine(angle);
cosh_result = hyperbolic_cosine(angle);
tanh_result = hyperbolic_tangent(angle);
disp('The hyperbolic sine of the angle is:')
disp(sinh_result)
disp('The hyperbolic cosine of the angle is:')
disp(cosh_result)
disp('The hyperbolic tangent of the angle is:')
disp(tanh_result)

% Advanced logarithmic functions
complex_log_result = complex_logarithm(real_part, imag_part);
log2_result = logarithm_base_2(8);
logn_result = logarithm_base_n(8, 3);
disp('The natural logarithm of the complex number is:')
disp(complex_log_result)
disp('The logarithm base 2 of 8 is:')
disp(log2_result)
disp('The logarithm base 3 of 8 is:')
disp(logn_result)