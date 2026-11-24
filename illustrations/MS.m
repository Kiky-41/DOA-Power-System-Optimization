clc; clear; close all;

% Parameter iterasi
maxIter = 2;      % Iterasi (0 = kubus penuh, 1 = hapus tengah, dst.)
cubeSize = 1;     % Panjang sisi kubus awal

% Fungsi rekursif untuk menghasilkan koordinat kubus Menger
function cubes = generateMenger(x, y, z, size, iter)
    if iter == 0
        cubes = [x, y, z, size];
    else
        newSize = size / 3;
        cubes = [];
        for i = 0:2
            for j = 0:2
                for k = 0:2
                    % Abaikan pusat dan kubus sumbu tengah (lubang)
                    if (i == 1 && j == 1) || (i == 1 && k == 1) || (j == 1 && k == 1)
                        continue;
                    end
                    newX = x + (i - 1) * newSize;
                    newY = y + (j - 1) * newSize;
                    newZ = z + (k - 1) * newSize;
                    cubes = [cubes; generateMenger(newX, newY, newZ, newSize, iter-1)];
                end
            end
        end
    end
end

% Hasilkan kubus Menger Sponge
cubes = generateMenger(0, 0, 0, cubeSize, maxIter);

% Visualisasi
figure('Color','w');
hold on;
for i = 1:size(cubes,1)
    [X, Y, Z] = ndgrid([-0.5 0.5]*cubes(i,4) + cubes(i,1), ...
                       [-0.5 0.5]*cubes(i,4) + cubes(i,2), ...
                       [-0.5 0.5]*cubes(i,4) + cubes(i,3));
    K = convhull(X(:), Y(:), Z(:));
    trisurf(K, X(:), Y(:), Z(:), 'FaceColor', [0.2 0.6 1], 'EdgeColor', 'k');
end
axis equal;
xlabel('X-axis'); ylabel('Y-axis'); zlabel('Z-axis');
title(sprintf('Menger Sponge (Iterasi = %d)', maxIter));
view(3);
grid on;