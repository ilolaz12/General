% Number of samples
N = 8;

% Input: unit impulse
x = zeros(1, N);
% impulse at n = 0
x(1) = 1; 

% Output initialization
y = zeros(1, N);

% Compute the response
for n = 1:N
    xn   = 1; 
    xn1  = (n-1 >= 1) * x(n-1);
    xn3  = (n-3 >= 1) * x(n-3);
    yn1  = (n-1 >= 1) * y(n-1);
    yn3  = (n-3 >= 1) * y(n-3);
    
    y(n) = 0.5*xn + 0.8*xn1 + 1.2*xn3 + 0.2*yn1 - 0.4*yn3;
end

% Display result
fprintf('%.4f', y(1));
for k = 2:N
    fprintf(',%.4f', y(k));
end
fprintf('\n');
