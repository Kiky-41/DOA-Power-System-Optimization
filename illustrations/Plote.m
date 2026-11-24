% Bersihkan environment
clear; clc;

% Rentang output daya (MW)
P = linspace(20, 100, 500);

% Koefisien fungsi biaya kuadratik (tanpa VPE)
a = 1.8;  % Koefisien kuadrat
b = 120;  % Koefisien linear
c = 0;    % Konstanta

% Koefisien efek valve-point (VPE)
e = 2500;        % Amplitudo ripple
f = 0.1 * pi;    % Frekuensi ripple

% Fungsi biaya tanpa VPE
Cost_base = a * P.^2 + b * P + c;

% Fungsi biaya dengan VPE
Cost_vpe = Cost_base + e * abs(sin(f * (P - 20)));  % Offset dari Pmin agar ripple terdistribusi

% Batas daya
Pmin = 20;
Pmax = 100;
Cost_min = a * Pmin^2 + b * Pmin + c;
Cost_max = a * Pmax^2 + b * Pmax + c;

% Plot kurva biaya
figure;
plot(P, Cost_base, 'k', 'LineWidth', 1.5); hold on;
plot(P, Cost_vpe, 'b', 'LineWidth', 1.5);

% Garis vertikal Pmin dan Pmax
plot([Pmin Pmin], [0 Cost_min], 'k--', 'LineWidth', 1.2);
plot([Pmax Pmax], [0 Cost_max], 'k--', 'LineWidth', 1.2);

% Legend untuk membedakan kurva
legend('Biaya tanpa VPE', 'Biaya dengan VPE', 'Location', 'northwest');

% Label sumbu
xlabel('Power Output (MW)', 'FontSize', 11);
ylabel('Cost $/h', 'FontSize', 11);

% Batas sumbu
xlim([10 110]);
ylim([0 3.5e4]);

% Format tampilan
set(gca, 'FontName', 'Times New Roman', 'FontSize', 11);
box on;

% ========================
% Tambahkan anotasi panah (opsional)
% ========================
ax = gca;
Pmin_norm = (Pmin - ax.XLim(1)) / diff(ax.XLim);
Pmax_norm = (Pmax - ax.XLim(1)) / diff(ax.XLim);
Cmin_norm = (Cost_min - ax.YLim(1)) / diff(ax.YLim);
Cmax_norm = (Cost_max - ax.YLim(1)) / diff(ax.YLim);

% (Anotasi panah dan teks bisa ditambahkan di sini jika diinginkan)