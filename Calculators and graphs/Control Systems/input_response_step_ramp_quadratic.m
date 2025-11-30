%% Parameters
% Differential equation as a function
ode_func = @(t, c, r) r - 3*c;
% Time range
tspan = [0 10];
% Initial condition
c0 = 0;
% Step input r1 = @(t) 1;
r1 = @(t) ones(size(t)); 
% Ramp input
r2 = @(t) t;
% Quadratic input
r3 = @(t) t.^2;
% Define a common time vector for plotting
t_common = linspace(0, 10, 1000);
%% Calculations
% Solve using ode45
[t1, c1] = ode45(@(t, c) ode_func(t, c, r1(t)), tspan, c0);
[t2, c2] = ode45(@(t, c) ode_func(t, c, r2(t)), tspan, c0);
[t3, c3] = ode45(@(t, c) ode_func(t, c, r3(t)), tspan, c0);

% Interpolate results to match common time vector
c1_interp = interp1(t1, c1, t_common, 'linear');
c2_interp = interp1(t2, c2, t_common, 'linear');
c3_interp = interp1(t3, c3, t_common, 'linear');

% Add for final system response
response = c1_interp + c2_interp + c3_interp;

%% Graphs
% Plot Results
figure;
plot(t_common, r1(t_common), 'y', 'LineWidth', 2); hold on;
plot(t_common, r2(t_common), 'b', 'LineWidth', 2);
plot(t_common, r3(t_common), 'g', 'LineWidth', 2);
plot(t_common, response, 'r', 'LineWidth', 3);
legend('r(t) = 1', 'r(t) = t', 'r(t) = t^2', 'r(s)');
xlabel('Time (s)');
ylabel('Response c(t)');
title('System Response for Different Inputs');
grid on;