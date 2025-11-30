%% Control Optimization for Temperature Control System (G(s) = 5*exp(-1*s)/(s+5))
% Continuous and discrete-time systems
s = tf('s');
% The continuous-time system with delay (τ = 1s delay)
G = 5*exp(-1*s)/(s+5);
% Delay-free system for analysis
G_nodelay = 5/(s+5);

%% Bode Analysis to get Cut-off frequency (wc) and Sampling Time (T)
% Evaluate Bode magnitude
[mag, phase, w] = bode(G_nodelay);
% Convert to dB
mag_db = 20*log10(squeeze(mag));
phase = squeeze(phase);
w = squeeze(w);
% Set reference magnitude
mag0_db = mag_db(1);
% Set cutoff frequency ≥ 3 dB
cutoff_db = find(mag_db <= mag0_db-3, 1);
% Find w_c
w_c = w(cutoff_db);
phase_c = phase(cutoff_db);
fprintf('Cut-off frequency (rad/s): %.3f\n', w_c);
% Apply sampling theorem
T = pi/w_c;
% Force K to be integer
k = ceil(1/T);
% adjust T
T = 1/k;
fprintf("Chosen integer T = %.4f s (k = %d)\n", T, k);

%% Discretize G(s) using ZOH (Z-transform model)
alpha = exp(-5*T);
g_hp_num = [zeros(1), 1-alpha];
g_hp_den = [1, -alpha];
G_hp = tf(g_hp_num, g_hp_den, T);

%% Optimize P Controller
% Initial P
P = 0.1;
% Step size
gamma = 0.1;
% Number of steps
N = 10;
% Unit step input
r = ones(1, N);
% Gradient step size
delta_p = 0.01;
max_iter = 50;

% Preallocation
IAE_log = zeros(1, max_iter);
P_log = zeros(1, max_iter);

% Simulate P response
for iter = 1:max_iter
    c = zeros(1, N);
    e = zeros(1, N);
    for n = k+2:N
        % Output before the controller
        m = (1-alpha)*e(n-k-1)+alpha*c(n-1);
        % Proportional controller output
        c(n) = P*m;
        e(n) = r(n)-c(n);
    end
    S1 = sum(abs(e));
    
    % Simulate P+dP response
    P_perturb = P+delta_p;
    c2 = zeros(1, N);
    e2 = zeros(1, N);
    for n = k+2:N
        % Output before the controller
        m2 = (1-alpha)*e2(n-k-1)+alpha*c2(n-1);
        % Proportional controller output
        c2(n) = P_perturb*m2;
        e2(n) = r(n)-c2(n);
    end
    S2 = sum(abs(e2));

    % Update finate descent
    dS_dP = (S2-S1)/delta_p;
    % Update gradient descent
    P = P-gamma*dS_dP;
    % fprintf('Optimized output (P = %.4f)', P);
    % Log data
    IAE_log(iter) = S1;
    P_log(iter) = P;
end

c_final = zeros(1, N);
for n = k+2:N
    m = (1-alpha)*(r(n-k-1)-c_final(n-k-1))+alpha*c_final(n-1);
    c_final(n) = P*m;
end

%% Optimize PIP Controller
% Guess  matrix
q = [0.1, 0.1, 0.1];
% Gradient step size
delta_q = 0.01;
grad = zeros(1,3);
S_base = sum(abs(e));
% Preallocation
IAE_pid_log = zeros(1, max_iter);
Q_log = zeros(max_iter, 3);

% Simulate PID response
for iter = 1:max_iter
    c_base = zeros(1, N);
    e_base = zeros(1, N);
    for n = k+3:N
        u = q(1)*e_base(n)+q(2)*e_base(n-1)+q(3)*e_base(n-2);
        m = (1-alpha)*u+alpha*c_base(n-1);
        c_base(n) = m;
        e_base(n) = r(n)-c_base(n);
    end
    S_base = sum(abs(e_base));

    % Gradient estimation
    for i=1:3
        q_perturb = q;
        q_perturb(i) = q(i)+delta_q;
    
        % Simulate
        c_pid = zeros(1, N);
        e_pid = zeros(1, N);
        for n = k+3:N
            u = q_perturb(1)*e_pid(n)+q_perturb(2)*e_pid(n-1)+q_perturb(3)*e_pid(n-2);
            m = (1-alpha)*u+alpha*c_pid(n-1);
            c_pid(n) = m;
            e_pid(n) = r(n)-c_pid(n);
        end
        S_perturbed = sum(abs(e_pid));
        grad(i) = (S_perturbed-S_base)/delta_q;    
    end
    % Normalize and update rule
    delta_norm = norm(grad);
    q = q-gamma*grad/delta_norm;

    % Log
    IAE_pid_log(iter) = S_base;
    Q_log(iter,:) = q;
end

% Simulate final optimized response
c_final = zeros(1, N);
for n = k+3:N
    u = q(1)*e_base(n-1) + q(2)*e_base(n-2) + q(3)*e_base(n-3);
    m = (1 - alpha)*u + alpha*c_final(n - 1);
    c_final(n) = m;
end

%% Plotting
% Visualizing Open-loop Response to Unit Step Input
figure;
hold on; grid on;
[y_cont, t_out] = step(G, 0:0.01:10);
plot(t_out, y_cont, 'r', 'LineWidth', 2);
[y_nodelay, t_nodelay] = step(G_nodelay, 0:0.01:10);
plot(t_nodelay, y_nodelay, 'b--', 'LineWidth', 2);
legend('With Delay (\tau = 1s)', 'Without Delay');
xlabel('Time (s)'); ylabel('Response c(t)');
title('Open-loop Response to Unit Step Input');
grid on;

% Visualizing Bode Plot of G(s) without Delay
figure;
subplot(2,1,1);
semilogx(w, mag_db, 'b', 'LineWidth', 2); hold on;
% -3 dB line
yline(mag0_db - 3, 'r--', 'LineWidth', 1.5);
% cutoff freq
xline(w_c, 'k--', 'LineWidth', 1.5);      
text(w_c*1.1, mag0_db - 4.5, sprintf('\\omega_c = %.2f rad/s', w_c));
text(0.2, mag0_db - 2, '0 dB', 'Color', 'blue');
ylabel('Magnitude (dB)');
title('Bode Plot of G(s) without Delay');
grid on;
subplot(2,1,2);
semilogx(w, phase, 'b', 'LineWidth', 2); hold on;
% cutoff freq
xline(w_c, 'k--', 'LineWidth', 1.5);
% -45 degree line for first-order system cutoff frequency
yline(-45, 'r--', 'LineWidth', 1.2);
text(w_c*1.1, phase_c - 5, sprintf('Phase = %.1f°', phase_c));
xlabel('Frequency (rad/s)');
ylabel('Phase (deg)');
grid on;

% Visualizing G_hp
figure;
subplot(2,1,1);
step(G_hp)
title('Step Response of G_{HP}(z)')
xlabel('Time (s)')
ylabel('Amplitude')
grid on
subplot(2,1,2);
bode(G_hp)
title('Bode Plot of G_{HP}(z)')
grid on

% Visualizing Initial vs Optimized P Controller Response
figure;
subplot(3,1,1);
plot(0:T:(N-1)*T, r, 'k--'); hold on;
plot(0:T:(N-1)*T, c_final, 'b', 'LineWidth', 2);
xlabel('Time (s)'); ylabel('Output');
legend('Reference', sprintf('Optimized Output (P = %.4f)', P));
title('Optimized Response with P Controller');
subplot(3,1,2);
plot(P_log, 'LineWidth', 2); ylabel('P'); xlabel('Iteration');
title('P Value Over Iterations'); grid on;
subplot(3,1,3);
plot(IAE_log, 'LineWidth', 2); ylabel('IAE'); xlabel('Iteration');
title('IAE Over Iterations'); grid on;

% Visualizing Initial vs Optimized PID Controller Response
figure;
subplot(5,1,1);
plot(0:T:(N-1)*T, r, 'k--'); hold on;
plot(0:T:(N-1)*T, c_final, 'b', 'LineWidth', 2);
xlabel('Time (s)'); ylabel('Output');
legend('Reference', sprintf('Optimized PID Output'));
title('Optimized Response with PID Controller');
subplot(5,1,2);
plot(Q_log(:,1), 'LineWidth', 2);
ylabel('q_0'); xlabel('Iteration');
title('q_0 (Proportional Term) Over Iterations');
subplot(5,1,3);
plot(Q_log(:,2), 'LineWidth', 2);
ylabel('q_1'); xlabel('Iteration');
title('q_1 (Integral Term) Over Iterations');
subplot(5,1,4);
plot(Q_log(:,3), 'LineWidth', 2);
ylabel('q_2'); xlabel('Iteration');
title('q_2 (Derivative Term) Over Iterations');
subplot(5,1,5);
plot(IAE_log, 'LineWidth', 2); ylabel('IAE'); xlabel('Iteration');
title('IAE Over Iterations');
grid on;

% Grid setup
[q0_grid, q1_grid] = meshgrid(0:0.05:1, 0:0.05:1);
IAE_surface = zeros(size(q0_grid));

% Loop through grid
for i = 1:size(q0_grid, 1)
    for j = 1:size(q0_grid, 2)
        q_temp = [q0_grid(i,j), q1_grid(i,j), 0];  % fix q2 = 0

        % Simulate system for these q values
        c_temp = zeros(1, N);
        e_temp = zeros(1, N);
        for n = k+3:N
            u = q_temp(1)*e_temp(n-1) + q_temp(2)*e_temp(n-2);
            m = (1 - alpha)*u + alpha*c_temp(n - 1);
            c_temp(n) = m;
            e_temp(n) = r(n) - c_temp(n);
        end

        % Compute IAE at this point
        IAE_surface(i,j) = sum(abs(e_temp));
    end
end

% Plot the surface
figure;
surf(q0_grid, q1_grid, IAE_surface);
xlabel('q_0 (Proportional)');
ylabel('q_1 (Integral)');
zlabel('IAE');
title('IAE Surface over (q_0, q_1)');
