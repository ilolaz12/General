% Define matrices
A = [56 32; 24 -16];
B = [14 -4; 6 -2]; 

% 1. Matrix multiplication
C = A * B;
disp('Matrix multiplication A * B:');
disp(C);

% 2. Element-by-element multiplication
D = A .* B;
disp('Element-by-element multiplication A .* B:');
disp(D);

% 3. Matrix right division
E = A / B;
disp('Matrix right division A / B:');
disp(E);

% 4. Element-by-element right division
F = A ./ B;
disp('Element-by-element right division A ./ B:');
disp(F);

% 5. Element-by-element power
G = B .^ 3;
disp('Element-by-element power B .^ 3:');
disp(G);