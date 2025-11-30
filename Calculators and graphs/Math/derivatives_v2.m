%% MATLAB Script for Numerical Differentiation of Periodic Function
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
% Version: 2.0

%% Function
function numerical_differentiation()
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

    %% Variables
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

    %% Display
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

    % Plot the original function and its first-order derivative in one figure
    figure;
    ax1 = subplot(3,1,1);
    plot(ax1, t, f, 'DisplayName', 'f(t)');
    title(ax1, 'Original Function');
    xlabel(ax1, 't (seconds)');
    ylabel(ax1, 'f(t) (metres)');
    legend(ax1, 'show');

    ax2 = subplot(3,1,2);
    plot(ax2, t, df_dt_vectorized, 'DisplayName', 'f''(t)');
    title(ax2, 'First-Order Derivative');
    xlabel(ax2, 't (seconds)');
    ylabel(ax2, 'df/dt (metres/second)');
    legend(ax2, 'show');

    ax3 = subplot(3,1,3);
    plot(ax3, t, d2f_dt2, 'DisplayName', 'f''''(t)');
    title(ax3, 'Second-Order Derivative');
    xlabel(ax3, 't (seconds)');
    ylabel(ax3, 'd^2f/dt^2 (metres/second^2)');
    legend(ax3, 'show');

    % Combine all three plots into one figure with three y-axes
    figure;
    yyaxis left;
    plot(t, f, 'DisplayName', 'f(t)');
    ylabel('f(t) (metres)');
    hold on;
    yyaxis right;
    plot(t, df_dt_vectorized, 'DisplayName', 'f''(t)');
    ylabel('df/dt (metres/second)');
    yyaxis right;
    plot(t, d2f_dt2, 'DisplayName', 'f''''(t)');
    ylabel('d^2f/dt^2 (metres/second^2)');
    title('First and Second Order Derivative Evaluation');
    xlabel('t (seconds)');
    legend('show');
    hold off;

    % Manual calculations
    df1_dt = (f(2) - f(N)) / (2 * h);
    df10_dt = (f(11) - f(9)) / (2 * h);
    fprintf('Manual calculation for df/dt at t1 is: %.4f\n', df1_dt);
    fprintf('Manual calculation for df/dt at t10 is: %.4f\n', df10_dt);

    % Produce an ASCII file with the results
    results = [t, df_dt_vectorized, d2f_dt2];
    dlmwrite('results.txt', results, 'delimiter', '\t', 'precision', '%.2f');
end
