clc; clear; close all;

% Parameter
steps = 1000;
dimensions = 2;
rng(42);  % Set seed for reproducibility

%% Random Walk
rw_positions = cumsum(randn(steps, dimensions));

%% Levy Flight Function
beta = 1.5;
gamma1 = gamma(1 + beta);
gamma2 = gamma((1 + beta) / 2);
sigma_u = (gamma1 * sin(pi * beta / 2) / (gamma2 * beta * 2^((beta - 1) / 2)))^(1 / beta);

u = normrnd(0, sigma_u, steps, dimensions);
v = normrnd(0, 1, steps, dimensions);
step = u ./ abs(v).^(1 / beta);
levy_positions = cumsum(step);

%% Plotting
figure('Position', [100 100 1200 500]);

% Plot Random Walk
subplot(1,2,1);
plot(rw_positions(:,1), rw_positions(:,2), 'b');
title('Random Walk');
xlabel('X'); ylabel('Y');
grid on;
axis equal;

% Plot Levy Flight
subplot(1,2,2);
plot(levy_positions(:,1), levy_positions(:,2), 'r');
title('Levy Flight');
xlabel('X'); ylabel('Y');
grid on;
axis equal;