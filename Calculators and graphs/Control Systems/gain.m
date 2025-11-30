A = [0 1; -2 -3];
B = [0; 1];
C = [2 0];
% Identity matrix
I = eye(2);
% Constructing symbolic variable s.
syms s; 

% Calculated matrices
Phi_calc = [0 1; -0.3 -1.1];
Gamma_calc = [0; 1];
% Sampling interval in seconds
T = 0.01;

% Corrected controllability matrix (horizontal stacking):
W_c_der = [Gamma_calc, Phi_calc * Gamma_calc];
fprintf('Calculated by matlab W_c \n');
disp(W_c_der);

P_Phi_der = Phi_calc^2 - Phi_calc + 0.5*I;
disp('Calculated by matlab P(Phi):');
disp(P_Phi_der);

K_der = [0 1] * inv(W_c_der) * P_Phi_der;
disp('Calculated by matlab gain K:');
disp(K_der);