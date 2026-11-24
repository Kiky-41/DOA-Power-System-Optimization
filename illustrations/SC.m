clc; clear; close all;

% Iterasi Sierpinski Carpet (semakin besar semakin detail, disarankan <= 5)
maxIter = 4;

% Fungsi rekursif untuk membangun Carpet
function drawCarpet(x, y, size, iter)
    if iter == 0
        % Gambar kotak penuh
        fill([x x+size x+size x], [y y y+size y+size], 'k', 'EdgeColor', 'none');
    else
        newSize = size / 3;
        for i = 0:2
            for j = 0:2
                % Lewati bagian tengah (kosong)
                if ~(i == 1 && j == 1)
                    drawCarpet(x + i * newSize, y + j * newSize, newSize, iter - 1);
                end
            end
        end
    end
end

% Plot Sierpinski Carpet
figure('Color','w'); hold on;
axis equal off;
drawCarpet(0, 0, 1, maxIter); % Bangun Carpet di area [0,1] x [0,1]

% Tampilkan sumbu seperti Barnsley Fern
axis on;
xlabel('X-axis');
ylabel('Y-axis');
title(sprintf('Sierpinski Carpet (Iterasi = %d)', maxIter));
grid on;