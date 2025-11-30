% Function to calculate the side length of the square base (S) of a square-based pyramid given volume (V) and vertical height (H)

function S = pyramid_side_length(V, H)
    % Input: V - Volume of the pyramid; H - Vertical height of the pyramid
    % Output: S - Side length of the square base
    
    S = sqrt((3 * V) ./ H); % formular to find side length based on given values
end

% Test the pyramid_side_length function for the below values
v = [10, 2.586e6]; % Volume in m^3
h = [2, 146.6];  % Height in m
s = pyramid_side_length(v, h);

for i = 1:length(v)
    fprintf('Test Case %d: V = %.2f m^3, H = %.2f m, S = %.2f m\n', i, v(i), h(i), s(i));
end