%% Continuous-Time System Definition
A = [0 1; -171 -101.71];
B = [0; 1];
C = [20.83 0];
% Identity matrix
I = eye(2);
% Constructing symbolic variable s.
syms s; 
% Sampling interval in seconds
T = 0.01; 
% Transfer function
Gs = C*(s*I-A)^-1*B; 
% Calculated matrices
Phi_calc = [0.2794 0.6366; 1.0702 -0.36626];
Gamma_calc = [0.0037;-0.0063];
W_c_calc = [0.0037 -0.0063;-0.0030 0.0033];
P_Phi_calc = [170.71 102.7];
%K_calc = [0 1] * inv(W_c_calc) * P_Phi_calc;
P_Phi_zero_calc = Phi_calc.*Phi_calc;

% Checks
Phi_der = expm(A*T);
fprintf('Calculated by matlab Phi \n');
disp(Phi_der);
Gamma_der = integral(@(s) expm(A*s)*B, 0, T, 'ArrayValued', true);
fprintf('Calculated by matlab Gamma \n');
disp(Gamma_der);
W_c_der = [Gamma_der (Phi_der*Gamma_der)];
fprintf('Calculated by matlab W_c \n');
disp(W_c_der);
P_Phi_der = Phi_der^2-Phi_der+0.25*I;
disp('Calculated by matlab P(Phi):');
disp(P_Phi_der);
K_der = [0 1] * inv(W_c_der) * P_Phi_der;
disp('Calculated by matlab gain K:');
disp(K_der);
obsverDB = place(Phi_der', C', [0.01, 0.001])';
P_Phi_zero_der = Phi_der^2;
disp('Calculated by matlab P_Phi_zero:');
disp(P_Phi_zero_der);
W_o_der = [C; C*Phi_der];
disp('Calculated by matlab W_o_der (observability matrix):');
disp(W_o_der);
K_e_der = P_Phi_zero_der.*inv(W_o_der).*[0; 1];
disp('Calculated by matlab K_e_der:');
disp(K_e_der);
%% Step Response Plot for Continuous System (Q1)
figure();
% Sampling size
dt1 = 0.001;
% Simulation time in seconds
SimTime = 4;
% Simulation steps
N1 = round(SimTime / dt1);
% Time vector
TimeVector = (0:N1-1) * dt1;
% Unit Inputs Matrix
UI1 = ones(1,N1);
% Output matrix
O1 = zeros(1,N1);
% State vector
SVX1 = cell(1,N1);
fprintf('For first graph: T %0.2f;    Number of samples %0.2f \n', dt1, N1);
for index = 1:N1
    if index == 1
        SVX1{1,index} = [0;0];
        O1(1,index) = C*SVX1{1,index};
    else
        SVX1{1,index} = SVX1{1,index-1} + 0.001 * (A * SVX1{1,index-1} + B * UI1(1,index-1));
        O1(1,index) = C*SVX1{1,index};
    end
end
plot(TimeVector, O1, '.-b');
title('Euler Approximation of Continuous-Time Step Response');
xlabel('Time (s)'); ylabel('Output');
grid on;

%% Discrete-Time Open-Loop Simulation with Unit Step (Q3)
% Sampling size
dt2 = 0.01; 
% Simulation time in seconds
SimTime2 = 5;
% Simulation steps
N2 = round(SimTime2 / dt2);
% Time vector
TimeVector2 = (0:N2-1) * dt2;

% Unit Inputs Matrix
UI3 = ones(1,N2);
% Output matrix
O3 = zeros(1,N2);
O3_manual = zeros(1,N2);
% State vector
SVX5 = cell(1,N2);
SVX_manual = cell(1,N2);

fprintf('For second graph onwards: T %0.2f;    Number of samples %0.2f \n', dt2, N2);

figure();
for index = 1:N2
    if index == 1
        SVX5{1,index} = [0;0];
        SVX_manual{1,index} = [0;0];
        O3(1,index) = C*SVX5{1,index};
        %O3_manual(1,index) = C*SVX_manual{1,index};
    else
        u = UI3(index - 1);
        SVX5{1,index} = Phi_der * SVX5{1,index - 1} + Gamma_der * u;
        SVX_manual{1,index} = Phi_calc * SVX_manual{1,index - 1} + Gamma_calc * u;
        O3(1,index) = C * SVX5{1,index};
        %O3_manual(1,index) = C * SVX_manual{1,index};
    end
end
plot(TimeVector2, O3, '.-b');
hold on;
plot(TimeVector2, O3_manual, '.-r');
legend('Simulated (Phi, Gamma)', 'Manual Calculation');
title('Open-Loop Discrete-Time System Response Comparison');
xlabel('Time (s)'); ylabel('Output y(k)');
grid on;

%% Pole Variation Visualization for Feedback Gains (Q4)
% Desired poles: z = 0.5 ± 0.2j
char_poly = poly([0.5+0.2j, 0.5-0.2j]);
Phi_poles = [0 1; -char_poly(3) -char_poly(2)];
disp('Calculated by matlab Phi_poles:');
disp(Phi_poles);

k_max = 10;
X = zeros(2, k_max);
Y = zeros(1, k_max);
U = ones(1, k_max);

for k = 2:k_max
    X(:, k) = Phi_der * X(:, k-1) + Gamma_der * U(k-1);
    Y(k) = C * X(:, k);
end

figure();
CL_poles = eig(Phi_der);
plot(real(CL_poles), imag(CL_poles), 'b*', 'DisplayName', 'Closed-loop poles');
hold on;
plot(0.5, 0.2, 'ro', 'MarkerSize', 10, 'LineWidth', 1.5, 'DisplayName', 'Desired Pole');
plot(0.5, -0.2, 'ro', 'MarkerSize', 10, 'LineWidth', 1.5, 'HandleVisibility','off');
title('Closed-Loop Poles Placement');
xlabel('Real'); ylabel('Imaginary');
grid on;
axis equal;
xlim([-1.5 1]); ylim([-1 1]);
legend show;

% Unit Inputs Matrix
UI3 = ones(1,N2);
% Output matrix
O3 = zeros(1,N2);
% State vector
SVX5 = cell(1,N2);

figure();
for index = 1:N2
    if index == 1
        SVX5{1,index} = [0;0];
        O3(1,index) = C*SVX5{1,index};
        Phi_cl_der = Phi_der - Gamma_der * K_der;
        %Phi_cl_calc = Phi_calc - Gamma_calc * K_calc;
    else
        u = UI3(index - 1);
        SVX5{1,index} = Phi_cl_der * SVX5{1,index - 1} + Gamma_der * u;
        %SVX2{1,index} = Phi_cl_calc * SVX2{1,index - 1} + Gamma_calc * u;
        O3(1,index) = C * SVX5{1,index};
    end
end
plot(TimeVector2, O3, '.-b');
title('Closed-Loop Response with State Feedback');
xlabel('Time (s)'); ylabel('Output y(k)');
grid on;

%% Simulate observer & Regulator (Q5)
% Initial true state (non-zero)
x_obs = [0.001; -0.001];
% Initial observer state (zero)
x_obs_hat = [0; 0];
% State vector
SVX5 = cell(1,N2);

for k = 1:N2
    % Control using estimate
    u = -K_der * x_obs_hat;
    % Real system dynamics
    x_obs = Phi_der * x_obs + Gamma_der * u;          
    y = C * x_obs;
    y_hat = C * x_obs_hat;
    % Observer
    x_obs_hat = Phi_der * x_obs_hat + Gamma_der * u + obsverDB * (y - y_hat); 
    SVX5{1, k} = y;
end
figure();
plot(TimeVector2, SVX5, '.-b');
title('Closed-Loop System with Dead-Beat Observer');
xlabel('Time (s)');
ylabel('Output y(k)');
grid on;