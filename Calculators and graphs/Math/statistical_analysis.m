% Statistical Analysis Library
% File Name: statistical_analysis.m
% Description: This library includes functions for various statistical analysis calculations,
% such as mean, median, standard deviation, variance, correlation, and other related operations.
% Author: Ilona Lazareva (U1551168)
% Date: 1 July 2024
% Version: 2.0

%% Functions

% Function to calculate the mean of each column
function [col_mean] = col_mean_func(data)
    col_mean = mean(data, 1);
end

% Function to calculate the mean of each row
function [row_mean] = row_mean_func(data)
    row_mean = mean(data, 2);
end

% Function to calculate the median of each column
function [col_median] = col_median_func(data)
    col_median = median(data, 1);
end

% Function to calculate the median of each row
function [row_median] = row_median_func(data)
    row_median = median(data, 2);
end

% Function to calculate the standard deviation of each column
function [col_std] = col_std_func(data)
    col_std = std(data, 0, 1);
end

% Function to calculate the standard deviation of each row
function [row_std] = row_std_func(data)
    row_std = std(data, 0, 2);
end

% Function to calculate the variance of each column
function [col_var] = col_var_func(data)
    col_var = var(data, 0, 1);
end

% Function to calculate the variance of each row
function [row_var] = row_var_func(data)
    row_var = var(data, 0, 2);
end

% Function to calculate the correlation matrix
function [corr_matrix] = corr_matrix_func(data)
    corr_matrix = corrcoef(data);
end

% Function to calculate the mean
function mu = calculateMean(data)
    mu = mean(data);
end

% Function to calculate the median
function med = calculateMedian(data)
    med = median(data);
end

% Function to calculate the mode
function m = calculateMode(data)
    m = mode(data);
end

% Function to calculate the variance
function var_val = calculateVariance(data)
    var_val = var(data);
end

% Function to calculate the standard deviation
function stddev = calculateStandardDeviation(data)
    stddev = std(data);
end

% Function to calculate confidence intervals
function [ci_low, ci_high] = calculateConfidenceInterval(data, confidence_level)
    n = length(data);
    se = std(data) / sqrt(n);  % Standard error
    z = norminv(1 - (1 - confidence_level) / 2);  % Z-score
    mu = mean(data);
    ci_low = mu - z * se;
    ci_high = mu + z * se;
end

% Function to calculate the spread (range)
function spread_val = calculateSpread(data)
    spread_val = range(data);
end

% Function to reverse calculate mean given data and mean
function reversed_mean = reverseCalculateMean(data, new_mean)
    total_sum = sum(data);
    num_elements = length(data);
    additional_element = (new_mean * (num_elements + 1)) - total_sum;
    reversed_mean = [data, additional_element];
end

%% Variables

% Load text file
data = load('stat_data.txt');

% Confidence level for confidence intervals
confidence_level = 0.95;

%% Statistical Calculations

% Column-wise calculations
col_mean = col_mean_func(data);
col_median = col_median_func(data);
col_std = col_std_func(data);
col_var = col_var_func(data);

% Row-wise calculations
row_mean = row_mean_func(data);
row_median = row_median_func(data);
row_std = row_std_func(data);
row_var = row_var_func(data);

% Overall statistics
mean_val = calculateMean(data(:));
median_val = calculateMedian(data(:));
mode_val = calculateMode(data(:));
variance_val = calculateVariance(data(:));
stddev_val = calculateStandardDeviation(data(:));
spread_val = calculateSpread(data(:));
[corr_matrix] = corr_matrix_func(data);
[ci_low, ci_high] = calculateConfidenceInterval(data(:), confidence_level);

% Reverse calculations (example)
new_mean = mean_val + 1;
reversed_data_mean = reverseCalculateMean(data(:), new_mean);

%% Display

% Output the mean of the columns
disp('The mean of the columns is:')
disp(col_mean)
disp('This can also be calculated by:')
disp(mean(data, 1))
disp(' ')

% Output the mean of the rows
disp('The mean of the rows is:')
disp(row_mean)
disp('This can also be calculated by:')
disp(mean(data, 2))
disp(' ')

% Output the median of the columns
disp('The median of the columns is:')
disp(col_median)
disp(' ')

% Output the median of the rows
disp('The median of the rows is:')
disp(row_median)
disp(' ')

% Output the standard deviation of the columns
disp('The standard deviation of the columns is:')
disp(col_std)
disp(' ')

% Output the standard deviation of the rows
disp('The standard deviation of the rows is:')
disp(row_std)
disp(' ')

% Output the variance of the columns
disp('The variance of the columns is:')
disp(col_var)
disp(' ')

% Output the variance of the rows
disp('The variance of the rows is:')
disp(row_var)
disp(' ')

% Output the correlation matrix
disp('The correlation matrix is:')
disp(corr_matrix)
disp(' ')

% Output the overall statistics
disp('Overall Statistical Quantities:')
disp(['Mean: ', num2str(mean_val)])
disp(['Median: ', num2str(median_val)])
disp(['Mode: ', num2str(mode_val)])
disp(['Variance: ', num2str(variance_val)])
disp(['Standard Deviation: ', num2str(stddev_val)])
disp(['Spread (Range): ', num2str(spread_val)])
disp(['Confidence Interval (', num2str(confidence_level * 100), '%): [', num2str(ci_low), ', ', num2str(ci_high), ']'])
disp(' ')

% Output the reverse calculated mean data
disp('Reversed Data for new mean:')
disp(['Original Data: ', num2str(data(:)')])
disp(['Reversed Data for new mean (', num2str(new_mean), '): ', num2str(reversed_data_mean)])
disp(' ')

%% Plot

% Histogram of the data
figure;
subplot(2, 2, 1);
histogram(data(:), 'Normalization', 'probability');
hold on;

% Plot mean, median, mode
xline(mean_val, 'r', 'LineWidth', 2, 'DisplayName', ['Mean: ', num2str(mean_val)]);
xline(median_val, 'g', 'LineWidth', 2, 'DisplayName', ['Median: ', num2str(median_val)]);
xline(mode_val, 'b', 'LineWidth', 2, 'DisplayName', ['Mode: ', num2str(mode_val)]);
legend;

% Plot confidence interval
plot([ci_low, ci_high], [0.1, 0.1], 'k', 'LineWidth', 2, 'DisplayName', 'Confidence Interval');
scatter([ci_low, ci_high], [0.1, 0.1], 'k', 'filled');
legend;

title('Histogram and Statistical Quantities');
xlabel('Data Values');
ylabel('Probability');
legend('show');

% Simple Histogram
subplot(2, 2, 2);
histogram(data(:));
title('Simple Histogram');
xlabel('Data Values');
ylabel('Frequency');

% Normal Distribution Fit
subplot(2, 2, 3);
histfit(data(:));
title('Normal Distribution Fit');
xlabel('Data Values');
ylabel('Frequency');

% Reverse Calculation Example Plot
subplot(2, 2, 4);
histogram(reversed_data_mean);
title(['Reversed Data for New Mean: ', num2str(new_mean)]);
xlabel('Data Values');
ylabel('Frequency');