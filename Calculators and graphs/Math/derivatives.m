% MATLAB Script for Numerical Differentiation of Periodic Function
% Input:
% - Set of uniformly distributed data points over one period; 2xN matrix 'A1_input.txt'
% Output:
% - Plots of the original function and its derivatives.
% - 'results.txt': An ASCII file containing the time values, first-order derivative, and second-order derivative.
% Usage:
% 1. Ensure the input data file 'A1_input.txt' is in the correct format and accessible.
% 2. Adjust the file path in the script to point to the correct location of 'A1_input.txt'.
% 3. Run the script in MATLAB.
% Author: Ilona Lazareva (U1551168)
% Date: 1 July 2024
% Version: 1.0

% Open the file and read its contents
fileID = fopen('G:/My Drive/Study/UQS/ENG3104 - Engineering Simulations and Computations/ass/1/A1_input.txt', 'r');


% Check if the file is opened correctly
if fileID == -1
    error('File could not be opened. Check the file path.');
end

% Skip the non-numeric header lines
headerLines = 3; % Adjusted to match the file structure
for i = 1:headerLines
    fgetl(fileID); % Read and discard the header lines
end

% Read the numeric data
data = textscan(fileID, '%f %f', 'Delimiter', ' ', 'MultipleDelimsAsOne', true);
fclose(fileID);

% Convert the cell array to a matrix and print the data for debugging
data = cell2mat(data); % Convert the cell array to a matrix
disp('Data read from the file:');
disp(data);

% Check if the data was read correctly
if isempty(data)
    error('Data could not be read. Ensure the file format is correct.');
end

% Extract t and f from the data
t = data(:, 1);
f = data(:, 2);
N = length(t);

% Print t and f for debugging
disp('t values:');
disp(t);
disp('f values:');
disp(f);

% Check if dataset has at least 10 points
if N < 10
    error('The dataset is too small. Ensure the dataset has at least 10 points.');
end

h = t(2) - t(1);

% Manual calculations
df1_dt = (f(2) - f(N)) / (2 * h);
df10_dt = (f(11) - f(9)) / (2 * h);
fprintf('Manual calculation for df/dt at t1 is: %.4f\n', df1_dt);
fprintf('Manual calculation for df/dt at t10 is: %.4f\n', df10_dt);

% Estimate df/dt at every grid point using scalar-based computation
df_dt = zeros(N, 1);
df_dt(1) = (f(2) - f(N)) / (2 * h);
for i = 2:N-1
    df_dt(i) = (f(i+1) - f(i-1)) / (2 * h);
end
df_dt(N) = (f(2) - f(N-1)) / (2 * h);

% Print df/dt for debugging
disp('First-order derivative (df/dt):');
disp(df_dt);

% Plot the original function and its first-order derivative
figure;
subplot(2, 1, 1);
plot(t, f);
title('Original Function');
xlabel('t (seconds)');
ylabel('f(t) (metres)');

subplot(2, 1, 2);
plot(t, df_dt);
title('First-Order Derivative');
xlabel('t (seconds)');
ylabel('df/dt (metres/second)');

% Construct the differentiation matrix D using loops
D = zeros(N, N);
D(1, 2) = 1; D(1, N) = -1;
for i = 2:N-1
    D(i, i+1) = 1;
    D(i, i-1) = -1;
end
D(N, 2) = 1; D(N, N-1) = -1;
D = D / (2 * h);

% Compute df/dt using the matrix D
df_dt_matrix = D * f;

% Verify the results from Requirement 4
fprintf('Max difference for scalar vs. matrix is: %.4e\n', max(abs(df_dt - df_dt_matrix)));

% Construct the differentiation matrix D without using loops (vectorized)
D_vectorized = diag(ones(N-1, 1), 1) - diag(ones(N-1, 1), -1);
D_vectorized(1, N) = -1;
D_vectorized(N, 1) = 1;
D_vectorized = D_vectorized / (2 * h);

% Compute df/dt using the vectorized matrix D
df_dt_vectorized = D_vectorized * f;

% Verify the results from Requirement 6
fprintf('Max difference for matrix vs. vectorized is: %.4e\n', max(abs(df_dt_matrix - df_dt_vectorized)));

% Estimate d^2f/dt^2
d2f_dt2 = D_vectorized * df_dt_vectorized;

% Plot the first- and second-order derivatives
figure;
subplot(2, 1, 1);
plot(t, df_dt_vectorized);
title('First-Order Derivative');
xlabel('t (seconds)');
ylabel('df/dt (metres/second)');

subplot(2, 1, 2);
plot(t, d2f_dt2);
title('Second-Order Derivative');
xlabel('t (seconds)');
ylabel('d^2f/dt^2 (metres/second^2)');

% Produce an ASCII file with the results
results = [t, df_dt_vectorized, d2f_dt2];
dlmwrite('results.txt', results, 'delimiter', '\t', 'precision', '%.2f');