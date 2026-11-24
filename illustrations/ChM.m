clc; clear; close all;

% Parameter Chebyshev Map
k = 2;                % Orde (k ≥ 2, semakin tinggi semakin kompleks)
x0 = 0.2;             % Seed awal dalam [-1,1]
N = 50;               % Jumlah iterasi
x = zeros(1, N+1);
x(1) = x0;

% Definisi fungsi Chebyshev Map (orde k)
% Chebyshev polinomial: x_{n+1} = cos(k * arccos(x_n))
f = @(x) cos(k * acos(x));

% Simulasi iterasi
for n = 1:N
    x(n+1) = f(x(n));
end

% Grid untuk kurva f(x) dan garis y=x
xgrid = linspace(-1,1,500);
ygrid = f(xgrid);

% Plot Cobweb
figure('Position',[100 100 800 600]); hold on;
plot(xgrid, ygrid, 'b', 'LineWidth',1.5);       % Kurva f(x)
plot(xgrid, xgrid, 'k--', 'LineWidth',1);       % Garis y = x
title(sprintf('Chebyshev Map (k = %d)', k));
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
axis([-1 1 -1 1]);