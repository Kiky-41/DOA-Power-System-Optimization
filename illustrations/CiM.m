clc; clear; close all;

% Parameter Circle Map
K = 0.5;               % Tingkat non-linearitas (0 untuk rotasi murni)
Omega = 0.3;           % Frekuensi alami/parameter rotasi
x0 = 0.2;              % Seed awal (0 <= x <= 1)
N = 50;                % Jumlah iterasi
x = zeros(1, N+1);
x(1) = x0;

% Definisi fungsi Circle Map (dengan mod 1 agar tetap di [0,1])
f = @(x) mod(x + Omega - (K/(2*pi))*sin(2*pi*x), 1);

% Simulasi iterasi
for n = 1:N
    x(n+1) = f(x(n));
end

% Grid untuk kurva f(x) dan garis y=x
xgrid = linspace(0,1,500);
ygrid = f(xgrid);

% Plot Cobweb
figure('Position',[100 100 800 600]); hold on;
plot(xgrid, ygrid, 'b', 'LineWidth',1.5);        % Kurva f(x)
plot(xgrid, xgrid, 'k--', 'LineWidth',1);        % Garis y = x
title(sprintf('Circle Map (K = %.2f, \\Omega = %.2f)', K, Omega));
xlabel('x_n'); ylabel('x_{n+1}');
grid on;

% Gambar lintasan cobweb
xn = x0;
for n = 1:N
    x_next = f(xn);
    % Garis vertikal (xn, xn) -> (xn, x_{n+1})
    plot([xn xn], [xn x_next], 'r', 'LineWidth',1);
    % Garis horizontal (xn, x_{n+1}) -> (x_{n+1}, x_{n+1})
    plot([xn x_next], [x_next x_next], 'r', 'LineWidth',1);
    xn = x_next;
end

legend({'f(x)','y = x','Cobweb Path'}, 'Location','NorthWest');
axis([0 1 0 1]);