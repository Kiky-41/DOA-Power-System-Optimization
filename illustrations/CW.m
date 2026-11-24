clc; clear; close all;

% Parameter umum
steps = 1000;
dimensions = 2;
rng(42);  % Reproducibility

%% Random Walk (Gaussian)
rw_positions = cumsum(randn(steps, dimensions), 1);

%% Cauchy Walk
gamma = 0.5;  % Parameter skala Cauchy (atur agresivitas lompatan)
% Gunakan transformasi inverse CDF untuk sampling distribusi Cauchy
u = rand(steps, dimensions) - 0.5;
cauchy_steps = gamma * tan(pi * u);  % Distribusi Cauchy
cauchy_positions = cumsum(cauchy_steps, 1);

%% Plotting
figure('Position', [100 100 1200 500]);

% Plot Random Walk
subplot(1,2,1);
plot(rw_positions(:,1), rw_positions(:,2), 'b');
title('Random Walk');
xlabel('X'); ylabel('Y');
grid on; axis equal;

% Plot Cauchy Walk
subplot(1,2,2);
plot(cauchy_positions(:,1), cauchy_positions(:,2), 'm');
title('Cauchy Walk');
xlabel('X'); ylabel('Y');
grid on; axis equal;