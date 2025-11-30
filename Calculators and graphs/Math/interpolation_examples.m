% This script covers examples of linear and multi-linear interpolation
% using MATLAB. 
% Author: Ilona Date: 19 July 2024 Version: 1.0

%% Linear Interpolation Example
% Define the known data points
x = [1, 5];  % Independent variable
y = [2, 6];  % Dependent variable

% Point to interpolate
xi = 3;  

% Interpolate using interp1
yi = interp1(x, y, xi);

% Manual calculation for verification
m = (y(2) - y(1)) / (x(2) - x(1));  % Slope
y_chk1 = y(1) + m * (xi - x(1));    % y-value at xi using point-slope form
y_chk2 = y(2) + m * (xi - x(2));    % Another check using point-slope form

% Display the results
disp('Linear Interpolation Example:');
disp(['Interpolated value at xi = ', num2str(xi), ' is yi = ', num2str(yi)]);
disp(['Manual check value 1: ', num2str(y_chk1)]);
disp(['Manual check value 2: ', num2str(y_chk2)]);

% Plot the results
figure;
plot(x, y, 'o-', 'DisplayName', 'Data Points');
hold on;
plot(xi, yi, 'rx', 'MarkerSize', 10, 'DisplayName', 'Interpolated Point');
title('Linear Interpolation');
xlabel('x');
ylabel('y');
legend;

%% Multi-Linear Interpolation Example
% Define the known corner points and their values
x1 = [0, 2, 2, 0];
y1 = [0, 0, 4, 4];
z1 = [0, 15, 10, 5];

% Point to interpolate
xi = 1; 
yi = 2;

% Interpolation in x direction
z_x1 = interp1([x1(1), x1(2)], [z1(1), z1(2)], xi);
z_x2 = interp1([x1(3), x1(4)], [z1(3), z1(4)], xi);

% Interpolation in y direction using the results from x direction
zi = interp1([y1(1), y1(3)], [z_x1, z_x2], yi);

% Display the result
disp('Multi-Linear Interpolation Example:');
disp(['Interpolated value at (xi, yi) = (', num2str(xi), ', ', num2str(yi), ') is zi = ', num2str(zi)]);

% Plot the results
figure;
[X, Y] = meshgrid([x1(1), x1(2)], [y1(1), y1(3)]);
Z = [z1(1), z1(2); z1(4), z1(3)];
surf(X, Y, Z);
hold on;
plot3(xi, yi, zi, 'rx', 'MarkerSize', 10, 'DisplayName', 'Interpolated Point');
title('Multi-Linear Interpolation');
xlabel('x');
ylabel('y');
zlabel('z');
legend;

%% 2D Linear Interpolation Example
% Define the grid and corresponding values
x2 = [0, 1, 2];
y2 = [0, 1, 2];
[X2, Y2] = meshgrid(x2, y2);
Z2 = [0, 1, 4; 1, 2, 5; 4, 5, 10];

% Point to interpolate
xi2 = 1.5;
yi2 = 1.5;

% Interpolate using griddata
zi2 = griddata(X2, Y2, Z2, xi2, yi2);

% Display the result
disp('2D Linear Interpolation Example:');
disp(['Interpolated value at (xi2, yi2) = (', num2str(xi2), ', ', num2str(yi2), ') is zi2 = ', num2str(zi2)]);

% Plot the results
figure;
surf(X2, Y2, Z2);
hold on;
plot3(xi2, yi2, zi2, 'rx', 'MarkerSize', 10, 'DisplayName', 'Interpolated Point');
title('2D Linear Interpolation');
xlabel('x');
ylabel('y');
zlabel('z');
legend;

%% 3D Linear Interpolation Example
% Define scattered points and their values
x3 = [0, 1, 2, 1, 2, 0, 2, 1];
y3 = [0, 1, 0, 1, 2, 2, 1, 1];
z3 = [0, 2, 1, 3, 4, 5, 3, 2];
v3 = [0, 15, 10, 5, 20, 25, 30, 35];

% Point to interpolate
xi3 = 1.5;
yi3 = 1.5;
zi3 = 1.5;

% Interpolate using scatteredInterpolant
F = scatteredInterpolant(x3', y3', z3', v3');
vi3 = F(xi3, yi3, zi3);

% Display the result
disp('3D Linear Interpolation Example:');
disp(['Interpolated value at (xi3, yi3, zi3) = (', num2str(xi3), ', ', num2str(yi3), ', ', num2str(zi3), ') is vi3 = ', num2str(vi3)]);

% Plot the results
figure;
scatter3(x3, y3, z3, 100, v3, 'filled');
hold on;
plot3(xi3, yi3, zi3, 'rx', 'MarkerSize', 10, 'DisplayName', 'Interpolated Point');
title('3D Linear Interpolation');
xlabel('x');
ylabel('y');
zlabel('z');
colorbar;
legend;
