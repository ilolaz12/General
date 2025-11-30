% Module 2 Problem 1 solution
% Geometry Calculations Library
% File Name: geometry_calculations.m
% Description: This library includes functions to calculate various properties 
% such as volume, surface area, perimeter, and density for different shapes 
% including sphere, cylinder, cone, square, and triangle.
% This script calculates the volume, surface area, perimeter, 
% and density for various shapes using the geometry_calculations library.
% Author: Ilona Lazareva (U1551168)
% Date: 1 July 2024
% Version: 1.0

% Volume Library - volume.m
% Script to use the volume library

% Given Parameters
r = 0:0.01:3; % Radii
h = 5; % Height
b = 4; % Base
l = 3; % Length
w = 2; % Width
m = 10; % Mass

% Sphere calculations
V_sphere = sphere_volume(r);
A_sphere = sphere_surface_area(r);

% Cylinder calculations
V_cylinder = cylinder_volume(r, h);
A_cylinder = cylinder_surface_area(r, h);

% Cone calculations
V_cone = cone_volume(r, h);
A_cone = cone_surface_area(r, h);

% Square calculations
A_square = square_area(l);
P_square = square_perimeter(l);

% Triangle calculations
A_triangle = triangle_area(b, h);
P_triangle = triangle_perimeter(l);

% Density calculation for a sphere
d_sphere = density(m, sphere_volume(1)); % assuming radius of 1 for example

% Rectangular Prism calculations
V_rect_prism = rectangular_prism_volume(l, w, h);
A_rect_prism = rectangular_prism_surface_area(l, w, h);

% Ellipsoid calculations
a = 2; b = 1.5; c = 1; % semi-axes lengths
V_ellipsoid = ellipsoid_volume(a, b, c);
A_ellipsoid = ellipsoid_surface_area(a, b, c);

% Torus calculations
R = 4; r_torus = 1; % major and minor radii
V_torus = torus_volume(R, r_torus);
A_torus = torus_surface_area(R, r_torus);

% Pyramid calculations
slant_height = 6; % for surface area calculation
V_pyramid = pyramid_volume(b, h);
A_pyramid = pyramid_surface_area(b, h, slant_height);

% Parallelepiped calculations
V_parallelepiped = parallelepiped_volume(l, w, h);
A_parallelepiped = parallelepiped_surface_area(l, w, h);

% Density calculation for a sphere
d_sphere = density(m, sphere_volume(1)); % assuming radius of 1 for example

% Center of Mass calculation (example)
masses = [5, 10, 15]; % masses of the objects
positions = [1, 2, 3]; % positions of the objects
com = center_of_mass(masses, positions);


% Function to calculate the volume of a sphere
function [V] = sphere_volume(r)
    V = (4/3) * pi * r.^3;
end

% Function to calculate the surface area of a sphere
function [A] = sphere_surface_area(r)
    A = 4 * pi * r.^2;
end

% Function to calculate the volume of a cylinder
function [V] = cylinder_volume(r, h)
    V = pi * r.^2 * h;
end

% Function to calculate the surface area of a cylinder
function [A] = cylinder_surface_area(r, h)
    A = 2 * pi * r * (r + h);
end

% Function to calculate the volume of a cone
function [V] = cone_volume(r, h)
    V = (1/3) * pi * r.^2 * h;
end

% Function to calculate the surface area of a cone
function [A] = cone_surface_area(r, h)
    l = sqrt(r^2 + h^2); % slant height
    A = pi * r * (r + l);
end

% Function to calculate the area of a square
function [A] = square_area(l)
    A = l^2;
end

% Function to calculate the perimeter of a square
function [P] = square_perimeter(l)
    P = 4 * l;
end

% Function to calculate the area of a triangle
function [A] = triangle_area(b, h)
    A = 0.5 * b * h;
end

% Function to calculate the perimeter of a triangle (assuming it is an equilateral triangle)
function [P] = triangle_perimeter(a)
    P = 3 * a;
end

% Function to calculate the density of an object
function [d] = density(m, V)
    d = m / V;
end
% Rectangular Prism Functions
function [V] = rectangular_prism_volume(l, w, h)
    V = l * w * h;
end

function [A] = rectangular_prism_surface_area(l, w, h)
    A = 2 * (l*w + l*h + w*h);
end

% Ellipsoid Functions
function [V] = ellipsoid_volume(a, b, c)
    V = (4/3) * pi * a * b * c;
end

function [A] = ellipsoid_surface_area(a, b, c)
    p = 1.6075; % approximation parameter
    A = 4 * pi * ((a^p * b^p + a^p * c^p + b^p * c^p)/3)^(1/p);
end

% Torus Functions
function [V] = torus_volume(R, r)
    V = 2 * pi^2 * R * r.^2;
end

function [A] = torus_surface_area(R, r)
    A = 4 * pi^2 * R * r;
end

% Pyramid Functions
function [V] = pyramid_volume(b, h)
    V = (1/3) * b * h;
end

function [A] = pyramid_surface_area(b, h, slant_height)
    A = b + (1/2) * b * slant_height;
end

% Parallelepiped Functions
function [V] = parallelepiped_volume(l, w, h)
    V = l * w * h;
end

function [A] = parallelepiped_surface_area(l, w, h)
    A = 2 * (l*w + l*h + w*h);
end

% Density Function
function [d] = density(m, V)
    d = m / V;
end

% Center of Mass Function
function [com] = center_of_mass(masses, positions)
    total_mass = sum(masses);
    com = sum(masses .* positions) / total_mass;
end


% Display the results
disp('Sphere Volume:');
disp(V_sphere);
disp('Sphere Surface Area:');
disp(A_sphere);

disp('Cylinder Volume:');
disp(V_cylinder);
disp('Cylinder Surface Area:');
disp(A_cylinder);

disp('Cone Volume:');
disp(V_cone);
disp('Cone Surface Area:');
disp(A_cone);

disp('Square Area:');
disp(A_square);
disp('Square Perimeter:');
disp(P_square);

disp('Triangle Area:');
disp(A_triangle);
disp('Triangle Perimeter:');
disp(P_triangle);

disp('Rectangular Prism Volume:');
disp(V_rect_prism);
disp('Rectangular Prism Surface Area:');
disp(A_rect_prism);

disp('Ellipsoid Volume:');
disp(V_ellipsoid);
disp('Ellipsoid Surface Area:');
disp(A_ellipsoid);

disp('Torus Volume:');
disp(V_torus);
disp('Torus Surface Area:');
disp(A_torus);

disp('Pyramid Volume:');
disp(V_pyramid);
disp('Pyramid Surface Area:');
disp(A_pyramid);

disp('Parallelepiped Volume:');
disp(V_parallelepiped);
disp('Parallelepiped Surface Area:');
disp(A_parallelepiped);

disp('Density of Sphere:');
disp(d_sphere);

disp('Center of Mass:');
disp(com);