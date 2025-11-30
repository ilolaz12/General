% Load the image
image = imread('g:/My Drive/Study/UQS/ENG1901 - Engineering Practice 1/Heat map/300mm45degAng.jpg');

% Convert to grayscale
grayImage = rgb2gray(image);

% Display the grayscale image
figure;
imshow(grayImage);
title('Grayscale Image');

% Define known readings
knownValues = [
    495, 1098, 647;
    1092, 1497, 1332;
    1590, 1458, 137.3;
    1584, 1050, 527;
    1923, 1377, 114.6;
    1992, 1761, 193.4
];

% Parameters
num_random_points = 100;  % Number of random points around each known point
radius = 10;  % Radius for random points

% Initialize arrays for the new points
new_x = [];
new_y = [];
new_v = [];

% Generate random points around each known point
for i = 1:size(knownValues, 1)
    x = knownValues(i, 1);
    y = knownValues(i, 2);
    v = knownValues(i, 3);
    
    for j = 1:num_random_points
        % Generate random offset within the radius
        theta = rand * 2 * pi;
        r = radius * sqrt(rand);
        offsetX = r * cos(theta);
        offsetY = r * sin(theta);
        
        % New coordinates
        new_x = [new_x; x + offsetX];
        new_y = [new_y; y + offsetY];
        new_v = [new_v; v];
    end
end

% Normalize intensity values to grayscale range (0-255)
new_v = rescale(new_v, 0, 255);

% Create a grid of the same size as the grayscale image
[gridX, gridY] = meshgrid(1:size(grayImage, 2), 1:size(grayImage, 1));

% Create the interpolate function
F = scatteredInterpolant(new_x, new_y, new_v, 'natural', 'none');

% Perform interpolation on the grid
gridZ = F(gridX, gridY);

% Handle any NaN values in the interpolated results
gridZ(isnan(gridZ)) = 0;

% Normalize the interpolated values to match grayscale range (0-255)
gridZ = uint8(rescale(gridZ, 0, 255));

% Display the interpolated intensity map
figure;
imshow(gridZ);
title('Interpolated Intensity Map');