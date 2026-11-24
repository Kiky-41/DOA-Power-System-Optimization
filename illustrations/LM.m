clc; clear; close all;

% Parameter Logistic Map
r = 3.9;              % Parameter chaos (3.57–4 untuk chaos)
x0 = 0.2;             % Seed awal dalam [0,1]
N = 50;               % Jumlah iterasi untuk cobweb
x = zeros(1, N+1);
x(1) = x0;

% Definisi fungsi Logistic Map
f = @(x) r * x .* (1 - x);

% Buat cobweb data iterasi
for n = 1:N
    x(n+1) = f(x(n));
end

% Grid untuk kurva f(x) dan garis y=x
xgrid = linspace(0,1,500);
ygrid = f(xgrid);

% Plot Cobweb
figure('Position',[100 100 800 600]); hold on;
plot(xgrid, ygrid, 'b', 'LineWidth',1.5);      % Kurva f(x)
plot(xgrid, xgrid, 'k--', 'LineWidth',1);      % Garis y=x
title(sprintf('Logistic Map (r = %.2f)', r));
xlabel('x_n'); ylabel('x_{n+1}');
grid on;

% Gambar lintasan cobweb
xn = x0;
for n = 1:N
    x_next = f(xn);
    % Garis vertikal: (xn, xn) ke (xn, x_{n+1})
    plot([xn xn], [xn x_next], 'r', 'LineWidth',1);
    % Garis horizontal: (xn, x_{n+1}) ke (x_{n+1}, x_{n+1})
    plot([xn x_next], [x_next x_next], 'r', 'LineWidth',1);
    xn = x_next;
end

legend({'f(x)','y = x','Cobweb Path'}, 'Location','NorthWest');
axis([0 1 0 1]);