clc; clear; close all;

% Jumlah iterasi (semakin besar semakin detail)
N = 100000;

% Inisialisasi vektor koordinat
x = zeros(1, N);
y = zeros(1, N);

% Probabilitas untuk setiap transformasi
p = [0.01, 0.85, 0.07, 0.07];
cum_p = cumsum(p); % Probabilitas kumulatif

% Iterasi Barnsley Fern
for i = 2:N
    r = rand; % Angka acak untuk memilih transformasi

    if r <= cum_p(1)
        % Batang utama
        x(i) = 0;
        y(i) = 0.16 * y(i-1);

    elseif r <= cum_p(2)
        % Transformasi utama daun
        x(i) = 0.85 * x(i-1) + 0.04 * y(i-1);
        y(i) = -0.04 * x(i-1) + 0.85 * y(i-1) + 1.6;

    elseif r <= cum_p(3)
        % Daun kanan
        x(i) = 0.20 * x(i-1) - 0.26 * y(i-1);
        y(i) = 0.23 * x(i-1) + 0.22 * y(i-1) + 1.6;

    else
        % Daun kiri
        x(i) = -0.15 * x(i-1) + 0.28 * y(i-1);
        y(i) = 0.26 * x(i-1) + 0.24 * y(i-1) + 0.44;
    end
end

% Plot Barnsley Fern dengan sumbu
figure('Color','w');
plot(x, y, '.', 'Color', [0 0.5 0], 'MarkerSize', 1);
axis equal;
xlabel('X-axis');
ylabel('Y-axis');
title('Barnsley Fern');
grid on;