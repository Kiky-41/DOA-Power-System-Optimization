clc; clear; close all;

% Panjang sisi awal dan jumlah iterasi
L0 = 1;             % Panjang sisi awal segitiga sama sisi
numIter = 5;        % Jumlah iterasi (bisa ubah jadi 3-6 untuk detail berbeda)

% Titik awal segitiga sama sisi (orientasi ke atas)
theta = pi/3;  % sudut 60 derajat
p1 = [0, 0];
p2 = [L0, 0];
p3 = [L0/2, L0*sin(theta)];
points = [p1; p2; p3; p1]; % Tutup segitiga

% Iterasi Koch Snowflake
for iter = 1:numIter
    newPoints = [];
    for i = 1:size(points,1)-1
        A = points(i,:);
        B = points(i+1,:);

        % Bagi segmen menjadi 3 bagian
        v = (B - A)/3;
        P1 = A + v;
        P2 = A + 2*v;

        % Buat titik puncak segitiga kecil
        R = [cos(pi/3) -sin(pi/3); sin(pi/3) cos(pi/3)]; % Rotasi 60 derajat
        peak = P1 + (R * v')';

        % Tambahkan ke daftar titik
        newPoints = [newPoints; A; P1; peak; P2];
    end
    points = [newPoints; points(end,:)]; % Tambah titik terakhir
end

% Plot hasil Koch Snowflake
figure('Color','w');
plot(points(:,1), points(:,2), 'b-', 'LineWidth', 1);
axis equal;
xlabel('X-axis'); ylabel('Y-axis');
title(sprintf('Koch Snowflake (Iteration = %d)', numIter));
grid on;
xlim([-0.5 1.5]);  % Sesuaikan agar mirip skala Barnsley Fern
ylim([-0.2 1.2]);