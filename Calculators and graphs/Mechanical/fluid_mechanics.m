% Fluid Mechanics Library
% File Name: fluid_mechanics.m
% Description: This library includes functions for various fluid mechanics calculations,
% such as fluid flow rates, Reynolds number, pressure drops, Bernoulli's equation,
% and other related calculations.
% Author: Ilona
% Date: 1 July 2024
% Version: 1.0


%% Functions
% Fluid flow rate
function [flow_rate] = calculate_flow_rate(area, velocity)
    flow_rate = area * velocity;
end

% Reynolds number: dimensionless quantity in fluid mechanics used to
% predict the flow regime in a fluid system, such as laminar or turbulent
% flow.
function [Re] = calculate_reynolds_number(density, velocity, characteristic_length, viscosity)
    Re = (density * velocity * characteristic_length) / viscosity;
end

% Pressure drop using Darcy-Weisbach equation - relates the pressure drop
% (or head loss) due to friction along a given length of pipe to the
% physical properties of the fluid and the pipe
function [pressure_drop] = calculate_pressure_drop(friction_factor, length, diameter, density, velocity)
    pressure_drop = friction_factor * (length / diameter) * (density * velocity^2 / 2);
end

% Friction factor using Colebrook equation (implicit form) -  determine the
% friction factor in turbulent flow through pipes
function [friction_factor] = calculate_friction_factor(Re, relative_roughness)
    f = @(f) 1/sqrt(f) + 2*log10(relative_roughness/3.7 + 2.51/(Re*sqrt(f)));
    friction_factor = fzero(f, 0.02); % Initial guess of 0.02
end

% Bernoulli's equation - principle of fluid dynamics that describes the
% conservation of energy in a flowing fluid. It states that the sum of the
% static pressure, dynamic pressure, and hydrostatic pressure is constant
% along a streamline.
function [pressure2] = calculate_bernoullis_equation(pressure1, density, velocity1, velocity2, height1, height2)
    pressure2 = pressure1 + 0.5 * density * (velocity1^2 - velocity2^2) + density * 9.81 * (height1 - height2);
end

% Dynamic viscosity of water as a function of temperature (Celsius) -
% formula accounts for the decrease in viscosity with increasing
% temperature
function [viscosity] = dynamic_viscosity_water(temperature)
    viscosity = 2.414e-5 * 10^(247.8 / (temperature + 133.15)); % Sutherland's formula
end

% Kinematic viscosity -  ratio of dynamic viscosity (𝜇) to fluid density
% (𝜌)
function [kinematic_viscosity] = calculate_kinematic_viscosity(dynamic_viscosity, density)
    kinematic_viscosity = dynamic_viscosity / density;
end

% Volumetric flow rate in a pipe - he volume of fluid passing through a
% cross-section per unit time
function [volumetric_flow_rate] = calculate_volumetric_flow_rate(diameter, velocity)
    area = pi * (diameter / 2)^2;
    volumetric_flow_rate = calculate_flow_rate(area, velocity);
end

% Flow velocity in a pipe - the speed at which the fluid flows through the
% pipe
function [velocity] = calculate_flow_velocity(volumetric_flow_rate, diameter)
    area = pi * (diameter / 2)^2;
    velocity = volumetric_flow_rate / area;
end

% Pressure loss due to friction in a pipe
function [pressure_loss] = calculate_pressure_loss(friction_factor, length, diameter, velocity, density)
    pressure_loss = friction_factor * (length / diameter) * (density * velocity^2 / 2);
end

%% Variables (User Input)
% Interchangeable variables for calculations

area = 0.05; % Cross-sectional area in square meters
velocity = 2; % Flow velocity in meters per second
density = 1000; % Density of the fluid in kg/m^3
characteristic_length = 0.1; % Characteristic length in meters
viscosity = 0.001; % Dynamic viscosity in Pa.s
friction_factor = 0.02; % Friction factor (dimensionless)
length = 10; % Length of the pipe in meters
diameter = 0.1; % Diameter of the pipe in meters
relative_roughness = 0.0001; % Relative roughness (dimensionless)
pressure1 = 200000; % Pressure at point 1 in Pascals
velocity1 = 2; % Velocity at point 1 in meters per second
velocity2 = 1.5; % Velocity at point 2 in meters per second
height1 = 10; % Height at point 1 in meters
height2 = 5; % Height at point 2 in meters
temperature = 25; % Temperature in degrees Celsius

%% Display

% Fluid flow rate calculation
flow_rate = calculate_flow_rate(area, velocity);
disp('The fluid flow rate is:')
disp(flow_rate)

% Reynolds number calculation
Re = calculate_reynolds_number(density, velocity, characteristic_length, viscosity);
disp('The Reynolds number is:')
disp(Re)

% Pressure drop calculation
pressure_drop = calculate_pressure_drop(friction_factor, length, diameter, density, velocity);
disp('The pressure drop is:')
disp(pressure_drop)

% Friction factor calculation
friction_factor = calculate_friction_factor(Re, relative_roughness);
disp('The friction factor is:')
disp(friction_factor)

% Bernoulli's equation calculation
pressure2 = calculate_bernoullis_equation(pressure1, density, velocity1, velocity2, height1, height2);
disp('The pressure at point 2 is:')
disp(pressure2)

% Dynamic viscosity of water calculation
dynamic_viscosity = dynamic_viscosity_water(temperature);
disp('The dynamic viscosity of water at 25 degrees Celsius is:')
disp(dynamic_viscosity)

% Kinematic viscosity calculation
kinematic_viscosity = calculate_kinematic_viscosity(dynamic_viscosity, density);
disp('The kinematic viscosity is:')
disp(kinematic_viscosity)

% Volumetric flow rate calculation
volumetric_flow_rate = calculate_volumetric_flow_rate(diameter, velocity);
disp('The volumetric flow rate is:')
disp(volumetric_flow_rate)

% Flow velocity calculation
flow_velocity = calculate_flow_velocity(volumetric_flow_rate, diameter);
disp('The flow velocity is:')
disp(flow_velocity)

% Pressure loss due to friction calculation
pressure_loss = calculate_pressure_loss(friction_factor, length, diameter, velocity, density);
disp('The pressure loss due to friction is:')
disp(pressure_loss)