clc; clear; close all;

% Parameter Cantor Set
level = 10;             % Tingkat iterasi (semakin besar semakin detail)
x_start = -6;          % Menyamakan rentang X dengan Barnsley Fern
x_end = 6;
y = 10;                % Menyamakan posisi atas agar vertikal proporsional
gap = 2;               % Jarak antar level vertikal (disesuaikan agar setara tinggi Fern)

figure('Color', 'w'); hold on;

% Panggil fungsi rekursif untuk menggambar Cantor Set
drawCantor(x_start, x_end, y, level, gap);

% Tambahkan sumbu X dan Y
xlabel('X-axis');
ylabel('Y-axis');
title(sprintf('Cantor Set (Level = %d)', level));
grid on;
axis equal;

% Sesuaikan agar skalanya mirip Barnsley Fern (X: -6 s/d 6, Y: 0 s/d 10)
xlim([x_start x_end]);
ylim([0 y+2]);

% --- Fungsi rekursif untuk menggambar Cantor Set ---
function drawCantor(x1, x2, y, level, gap)
    if level == 0
        return;
    end
    
    % Gambar garis horizontal untuk level saat ini
    plot([x1 x2], [y y], 'k', 'LineWidth', 2);
    
    % Hitung panjang sepertiga
    len = (x2 - x1) / 3;
    
    % Rekursi untuk dua segmen (kiri dan kanan)
    drawCantor(x1, x1 + len, y - gap, level - 1, gap);
    drawCantor(x2 - len, x2, y - gap, level - 1, gap);
end