clc; clear; close all;

% Parameter umum
steps = 1000;
dimensions = 2;
rng(42);  % Reproducibility

%% Random Walk
rw_positions = cumsum(randn(steps, dimensions), 1);

%% Brownian Motion
D = 0.5;             % Koefisien difusi (atur besar langkah)
dt = 1;              % Interval waktu
brownian_step = sqrt(2 * D * dt) * randn(steps, dimensions);
brownian_positions = cumsum(brownian_step, 1);

%% Plotting
figure('Position', [100 100 1200 500]);

% Random Walk
subplot(1,2,1);
plot(rw_positions(:,1), rw_positions(:,2), 'b');
title('Random Walk');
xlabel('X'); ylabel('Y');
grid on; axis equal;

% Brownian Motion
subplot(1,2,2);
plot(brownian_positions(:,1), brownian_positions(:,2), 'g');
title('Brownian Motion');
xlabel('X'); ylabel('Y');
grid on; axis equal;