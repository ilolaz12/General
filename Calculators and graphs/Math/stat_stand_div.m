%% Example 1: Generate N = 200 samples drawn from a Gaussian random distribution, with mean zero and variance unity.
N = 200;
scale = [1, 2, 4, 0.1];
n0 = randn(1,N);
n1 = randn(1,N);
n2 = randn(1,N);
n3 = randn(1,N);
stats0 = [mean(n0) std(n0) var(n0)];
stats1 = [mean(n1) std(n1) var(n1)];
stats2 = [mean(n2) std(n2) var(n2)];
stats3 = [mean(n3) std(n3) var(n3)];
histogram(n,BinWidth=.5);
histogram(n1,BinWidth=.5);
histogram(n2,BinWidth=.5);
histogram(n3,BinWidth=.5);
noise0 = scale*.n0;

%% Example 2: Same as 8 but for more samples
% Number of samples
N = 200;

% Repeat experiment 4 times and collect stats
Stats = zeros(4,3); % Columns: mean, std, var

for i = 1:4
    n0 = randn(1,N);
    Stats(i,1) = mean(n0);
    Stats(i,2) = std(n0);
    Stats(i,3) = var(n0);
    
    % visualize the histogram
    figure; 
    histogram(n0, 'BinWidth', 0.5); title(['Histogram Run ', num2str(i)]);
end

% Display stats
Stats_table = array2table(Stats, 'VariableNames', {'Mean', 'StdDev', 'Variance'}, 'RowNames', {'Stats0', 'Stats1', 'Stats2', 'Stats3'})

% Use the last generated set n0 for scaling test
scale = [1, 2, 4, 0.1];

% Preallocate variance array
scaled_var = zeros(size(scale));

for j = 1:length(scale)
    noise = scale(j) * n0;
    scaled_var(j) = var(noise);
end

% Create table for scaling results
Scale_table = table(scale', scaled_var', 'VariableNames', {'Alpha', 'Variance'})
