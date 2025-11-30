% particle_motion.m
% This script calculates the work done by a force on a particle over specified intervals
% using the trapezoidal method. 
% Author: Ilona (U1551168)
% Date: 11 Aug 2024
% Version: 3.0

%% Functions
% Loop-based trapezoidal method
function U = calc_work_trapezoidal(positions, forces)
    delta_r = positions(2, :) - positions(1, :);
    F_avg = 0.5 * (forces(1, :) + forces(2, :));
    U = dot(F_avg, delta_r);
end

%% Variables and Data Loading
% Load data from file
tbl = readtable('G:/My Drive/Study/UQS/ENG3104 - Engineering Simulations and Computations/ass/3/A3Q2_input.csv'); 
time = tbl.Time;            % Extract time data
positions = [tbl.x tbl.y];  % Extract positions
forces = [tbl.Fx tbl.Fy];   % Extract forces

% Calculate p and q
p = round(1 + 5.7756);  % Example: p = 7
q = round(85 + 6.6729); % Example: q = 92

% Ensure that q does not exceed the length of the data
max_index = length(time);
if q > max_index
    q = max_index;
    fprintf('q exceeds data length. Setting q to %d\n', q);
end

% Display the calculated values
fprintf('Calculated values:\n p = %d\n q = %d\n', p, q);

%% Loop-based Work Calculation
U_loop_total = 0.0;
work_values_loop = zeros(1, q-p);  % Initialize array to store loop-based work values

for i = p:(q-1)
    work_values_loop(i-p+1) = calc_work_trapezoidal(positions(i:i+1, :), forces(i:i+1, :));
    U_loop_total = U_loop_total + work_values_loop(i-p+1);
end
% Display loop-based result
fprintf('Total work (loop-based) from t_%d to t_%d: %.3f J\n', p, q, U_loop_total);

%% Vectorized Work Calculation
delta_r = positions(p+1:q, :) - positions(p:q-1, :);  % Vector of all displacements
F_avg = 0.5 * (forces(p:q-1, :) + forces(p+1:q, :));  % Vector of average forces
dU_vector = sum(F_avg .* delta_r, 2);  % Compute dot products for each interval
U_vector_total = sum(dU_vector);       % Sum all the works
% Display vectorized result
fprintf('Total work (vectorized) from t_%d to t_%d: %.3f J\n', p, q, U_vector_total);

%% Manual Verification Work Calculation (Specific Intervals)
% Calculate work for specified intervals
p_to_p1 = calc_work_trapezoidal(positions(p:p+1, :), forces(p:p+1, :));
p1_to_p2 = calc_work_trapezoidal(positions(p+1:p+2, :), forces(p+1:p+2, :));
p2_to_p3 = calc_work_trapezoidal(positions(p+2:p+3, :), forces(p+2:p+3, :));

% Display intermediate results
fprintf('Work for 7 to 8 interval: %.3f J\n', p_to_p1);
fprintf('Work for 8 to 9 interval: %.3f J\n', p1_to_p2);
fprintf('Work for 9 to 10 interval: %.3f J\n', p2_to_p3);

% Sum work
U_total = p_to_p1 + p1_to_p2 + p2_to_p3;
% Display results
fprintf('Total work from t_%d to t_%d: %.3f J\n', p, p+3, U_total);

%% Plotting Specific Intervals (Manual Verification)
% Time intervals corresponding to the specified intervals
time_intervals = time(p:p+3);  % Extract time points for intervals p to p+3

% Work values for each interval
work_values_manual = [p_to_p1, p1_to_p2, p2_to_p3];

% Plotting the work done in each interval
figure;
plot(time_intervals(1:end-1), work_values_manual, '-o', 'LineWidth', 2, 'MarkerSize', 8);
title('Work done by the force over specified intervals (Manual Verification)');
xlabel('Time (s)');
ylabel('Work (Joules)');
grid on;

% Annotating the plot
for i = 1:length(work_values_manual)
    text(time_intervals(i), work_values_manual(i), sprintf('%.3f J', work_values_manual(i)), ...
        'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');
end

%% Plotting Work for p to q (Loop-based Calculation)
% Plotting the work done in each interval from p to q
figure;
plot(time(p:q-1), work_values_loop, '-o', 'LineWidth', 2, 'MarkerSize', 8);
title('Work done by the force from p to q (Loop-based Calculation)');
xlabel('Time (s)');
ylabel('Work (Joules)');
grid on;