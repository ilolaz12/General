% Module 2 Problem 3 solution
% Dynamical Formulas Library
% File Name: dynamical_formulas.m
% Description: This library includes functions to calculate various properties 
% related to dynamics, such as projectile motion, time of flight, maximum height, 
% horizontal range, and other kinematic equations.
% This library includes functions to calculate various properties 
% related to dynamics, such as projectile motion, time of flight, maximum height, 
% horizontal range, free fall, circular motion, harmonic motion, energy calculations, 
% and collision analysis.
% Author: Ilona Lazareva (U1551168)
% Date: 1 July 2024
% Version: 1.0

% Define parameters:
v0 = 40; % Initial speed (m/s)
g = 9.81; % Gravitational acceleration (m/s^2)
theta = 30 * pi / 180; % Throwing angle (radians)

%% Functions
% Projectile Motion Functions
% Function to calculate the time of flight for projectile motion
function [t_flight] = time_of_flight(v0, theta, g)
    t_flight = 2 * v0 * sin(theta) / g;
end
% Function to calculate the maximum height for projectile motion
function [h_max] = max_height(v0, theta, g)
    h_max = (v0^2 * sin(theta)^2) / (2 * g);
end
% Function to calculate the horizontal range for projectile motion
function [range] = horizontal_range(v0, theta, g)
    range = (v0^2 * sin(2 * theta)) / g;
end
% Function to calculate the height of the projectile at time t
function [h] = projectile_height(v0, theta, g, t)
    h = v0 * t * sin(theta) - 0.5 * g * t.^2;
end
% Function to calculate the speed of the projectile at time t
function [v] = projectile_speed(v0, theta, g, t)
    v = sqrt(v0^2 - 2 * v0 * g * sin(theta) .* t + g^2 * t.^2);
end

% Free Fall Functions
% Function to calculate the time to fall from a height
function [t_fall] = time_to_fall(h, g)
    t_fall = sqrt(2 * h / g);
end
% Function to calculate the final velocity when falling from a height
function [v_final] = final_velocity(h, g)
    v_final = sqrt(2 * g * h);
end
% Circular Motion Functions
% Function to calculate centripetal force
function [F_c] = centripetal_force(m, v, r)
    F_c = m * v^2 / r;
end
% Function to calculate angular velocity
function [omega] = angular_velocity(v, r)
    omega = v / r;
end
% Function to calculate the period of rotation
function [T] = period_of_rotation(r, v)
    T = 2 * pi * r / v;
end

% Harmonic Motion Functions
% Function to calculate displacement in simple harmonic motion
function [x] = shm_displacement(A, omega, t)
    x = A * cos(omega * t);
end
% Function to calculate velocity in simple harmonic motion
function [v] = shm_velocity(A, omega, t)
    v = -A * omega * sin(omega * t);
end
% Function to calculate acceleration in simple harmonic motion
function [a] = shm_acceleration(A, omega, t)
    a = -A * omega^2 * cos(omega * t);
end

% Energy Calculations
% Function to calculate kinetic energy
function [KE] = kinetic_energy(m, v)
    KE = 0.5 * m * v^2;
end
% Function to calculate potential energy
function [PE] = potential_energy(m, g, h)
    PE = m * g * h;
end
% Function to calculate mechanical energy
function [ME] = mechanical_energy(KE, PE)
    ME = KE + PE;
end

% Collision Analysis Functions
% Function to calculate final velocities after elastic collision
function [v1_final, v2_final] = elastic_collision(m1, m2, v1_initial, v2_initial)
    v1_final = (v1_initial * (m1 - m2) + 2 * m2 * v2_initial) / (m1 + m2);
    v2_final = (v2_initial * (m2 - m1) + 2 * m1 * v1_initial) / (m1 + m2);
end
% Function to calculate final velocity after inelastic collision
function [v_final] = inelastic_collision(m1, m2, v1_initial, v2_initial)
    v_final = (m1 * v1_initial + m2 * v2_initial) / (m1 + m2);
end

% Additional Utility Functions
% Function to find times when the height is above a certain value
function [t_above] = times_above_height(h, height, t)
    t_above = t(h >= height);
end
% Function to find times when the height is above a certain value and speed is below a certain value
function [t_above_and_below] = times_above_height_and_below_speed(h, height, v, speed, t)
    t_above_and_below = t(h >= height & v <= speed);
end
% Function to find times when the height is below a certain value or speed is above a certain value
function [t_below_or_above] = times_below_height_or_above_speed(h, height, v, speed, t)
    t_below_or_above = t(h < height | v > speed);
end
% Function to find times when the height is above a certain value
function [t_above] = times_above_height(h, height, t)
    t_above = t(h >= height);
end
% Function to find times when the height is above a certain value and speed is below a certain value
function [t_above_and_below] = times_above_height_and_below_speed(h, height, v, speed, t)
    t_above_and_below = t(h >= height & v <= speed);
end
% Function to find times when the height is below a certain value or speed is above a certain value
function [t_below_or_above] = times_below_height_or_above_speed(h, height, v, speed, t)
    t_below_or_above = t(h < height | v > speed);
end
% Function to calculate the time to fall from a height
function [t_fall] = time_to_fall(h, g)
    t_fall = sqrt(2 * h / g);
end
% Function to calculate centripetal force
function [F_c] = centripetal_force(m, v, r)
    F_c = m * v^2 / r;
end

% Function to calculate x-coordinate based on given equation
function [x] = x_coordinate(t)
    x = 5 .* t - 10;
end

% Function to calculate y-coordinate based on given equation
function [y] = y_coordinate(t)
    y = 25 .* t.^2 - 120 .* t + 144;
end

% Function to calculate distance from origin
function [d2] = distance_squared(x, y)
    d2 = x.^2 + y.^2;
end

% Function to find minimum distance from origin and corresponding time
function [min_distance, tmin] = minimum_distance_from_origin(t, x, y)
    d2 = distance_squared(x, y);
    [min_d2, idx] = min(d2);
    min_distance = sqrt(min_d2);
    tmin = t(idx);
end

% Calculate the length of time the ball is in the air
t_flight = time_of_flight(v0, theta, g);

% Set up array of times that spans the duration the ball is in the air
t = linspace(0, t_flight, 100);

% Calculate the height of the ball at all times
h = projectile_height(v0, theta, g, t);

% Calculate the speed of the ball at all times
v = projectile_speed(v0, theta, g, t);

%% Without vectorisation

% Part (a)
t1a = nan;
for i = 1:length(h)
    if h(i) >= 15
        if isnan(t1a)
            t1a = t(i);
        end
        t2a = t(i);
    end
end
disp(['The ball is at least 15m above the ground between ', num2str(t1a), ' and ', num2str(t2a), ' seconds'])

% Part (b)
t1b = nan;
for i = 1:length(h)
    if h(i) >= 15 && v(i) <= 36
        if isnan(t1b)
            t1b = t(i);
        end
        t2b = t(i);
    end
end
disp(['The ball is at least 15m above the ground and its speed is less than 36m/s between ', num2str(t1b), ' and ', num2str(t2b), ' seconds'])

% Part (c)
tc = [];
for i = 1:length(h)
    if h(i) < 5 || v(i) > 35
        tc = [tc, t(i)];
    end
end
disp(['The ball is no more than 5m above the ground or its speed is more than 35m/s at the following times (s)'])
disp(num2str(tc))

%% Use vectorisation

% Part (a)
ua = times_above_height(h, 15, t);
t1a = ua(1);
t2a = ua(end);
disp(['The ball is at least 15m above the ground between ', num2str(t1a), ' and ', num2str(t2a), ' seconds'])

% Part (b)
ub = times_above_height_and_below_speed(h, 15, v, 36, t);
t1b = ub(1);
t2b = ub(end);
disp(['The ball is at least 15m above the ground and its speed is less than 36m/s between ', num2str(t1b), ' and ', num2str(t2b), ' seconds'])

% Part (c)
uc = times_below_height_or_above_speed(h, 5, v, 35, t);
disp(['The ball is no more than 5m above the ground or its speed is more than 35m/s at the following times (s)'])
disp(num2str(uc))

%% Free Fall Calculations
height = 20; % Height (m)
t_fall = time_to_fall(height, g);
v_final = final_velocity(height, g);
disp(['Time to fall from ', num2str(height), 'm: ', num2str(t_fall), ' seconds'])
disp(['Final velocity when falling from ', num2str(height), 'm: ', num2str(v_final),