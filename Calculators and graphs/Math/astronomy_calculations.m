% Astronomy Calculations Library
% File Name: astronomy_calculations.m
% Description: This library includes functions for various astronomy calculations,
% such as celestial mechanics, orbital parameters, distances, magnitudes, and other related operations.
% Author: Ilona Lazareva (U1551168)
% Date: 1 July 2024
% Version: 1.0


% Constants
G = 6.67430e-11; % Gravitational constant (m^3 kg^-1 s^-2)
au = 1.496e+11; % Astronomical unit (m)
pc = 3.086e+16; % Parsec (m)
light_year = 9.461e+15; % Light-year (m)

% Celestial Mechanics Calculations
m1 = 5.972e24; % Mass of Earth in kg
m2 = 7.348e22; % Mass of Moon in kg
r = 3.844e8; % Distance between Earth and Moon in meters
F_gravity = gravitational_force(m1, m2, r);
disp('The gravitational force between Earth and Moon is:')
disp(F_gravity)

semi_major_axis = 1.496e11; % Semi-major axis in meters (1 AU)
central_mass = 1.989e30; % Mass of the Sun in kg
orbital_T = orbital_period(semi_major_axis, central_mass);
disp('The orbital period of the Earth around the Sun is:')
disp(orbital_T)

radius_earth = 6.371e6; % Radius of Earth in meters
v_escape_earth = escape_velocity(m1, radius_earth);
disp('The escape velocity from Earth is:')
disp(v_escape_earth)

% Distance and Magnitude Calculations
parallax = 0.1; % Parallax angle in arcseconds
distance_star = distance_from_parallax(parallax);
disp('The distance to the star is:')
disp(distance_star)

M_star = 4.83; % Absolute magnitude of the star
m_star = apparent_magnitude(M_star, distance_star);
disp('The apparent magnitude of the star is:')
disp(m_star)

m_star_obs = 5.0; % Observed apparent magnitude
distance_star_obs = 10 * pc; % Distance to the star in parsecs
M_star_obs = absolute_magnitude(m_star_obs, distance_star_obs);
disp('The absolute magnitude of the observed star is:')
disp(M_star_obs)

L_star = luminosity_from_magnitude(m_star_obs, distance_star_obs);
disp('The luminosity of the star is:')
disp(L_star)

% Orbital Parameter Calculations
period = 365.25 * 24 * 3600; % Orbital period of Earth in seconds
a_orbit = semi_major_axis(period, central_mass);
disp('The semi-major axis of the Earth''s orbit is:')
disp(a_orbit)

perihelion = 1.471e11; % Perihelion distance in meters
aphelion = 1.521e11; % Aphelion distance in meters
e_orbit = eccentricity(perihelion, aphelion);
disp('The eccentricity of the Earth''s orbit is:')
disp(e_orbit)

distance_orbit = 1.496e11; % Distance in meters (1 AU)
v_orbit = orbital_speed(central_mass, distance_orbit);
disp('The orbital speed of the Earth around the Sun is:')
disp(v_orbit)

%% Functions
% Celestial Mechanics Functions

% Function to calculate the gravitational force between two masses
function [F] = gravitational_force(m1, m2, r)
    F = G * m1 * m2 / r^2;
end

% Function to calculate the orbital period of a satellite
function [T] = orbital_period(semi_major_axis, central_mass)
    T = 2 * pi * sqrt(semi_major_axis^3 / (G * central_mass));
end

% Function to calculate the escape velocity from a celestial body
function [v_escape] = escape_velocity(mass, radius)
    v_escape = sqrt(2 * G * mass / radius);
end

% Distance and Magnitude Functions

% Function to calculate the distance to a star given its parallax angle
function [distance] = distance_from_parallax(parallax)
    distance = pc / parallax;
end

% Function to calculate the apparent magnitude of a star
function [m] = apparent_magnitude(M, distance)
    m = M + 5 * (log10(distance / 10));
end

% Function to calculate the absolute magnitude of a star
function [M] = absolute_magnitude(m, distance)
    M = m - 5 * (log10(distance / 10));
end

% Function to calculate the luminosity of a star given its apparent magnitude and distance
function [L] = luminosity_from_magnitude(m, distance)
    L = 10^((4.83 - m) / 2.5) * (distance / 10)^2;
end

% Orbital Parameter Functions

% Function to calculate the semi-major axis of an orbit
function [a] = semi_major_axis(period, central_mass)
    a = ((period^2 * G * central_mass) / (4 * pi^2))^(1/3);
end

% Function to calculate the eccentricity of an orbit
function [e] = eccentricity(perihelion, aphelion)
    e = (aphelion - perihelion) / (aphelion + perihelion);
end

% Function to calculate the orbital speed at a given distance
function [v] = orbital_speed(mass, distance)
    v = sqrt(G * mass / distance);
end
