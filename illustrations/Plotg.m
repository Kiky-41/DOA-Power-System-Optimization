% Bersihkan environment
clear; clc;

% Rentang output daya (MW)
P = linspace(20, 100, 500);

% Koefisien fungsi biaya kuadratik
a = 1.8;  % Koefisien kuadrat
b = 120;  % Koefisien linear
c = 0;    % Konstanta

% Koefisien efek valve-point (VPE)
e = 2500;        % Amplitudo ripple
f = 0.1 * pi;    % Frekuensi ripple

% Fungsi biaya dasar dan dengan VPE
Cost_base = a * P.^2 + b * P + c;
Cost_vpe = Cost_base + e * abs(sin(f * (P - 20)));

% Batas daya
Pmin = 20;
Pmax = 100;
Cost_min = a * Pmin^2 + b * Pmin + c;
Cost_max = a * Pmax^2 + b * Pmax + c;

% Prohibited Operating Zones (POZ)
POZ = [35 45; 65 75];  % Dua zona: 35-45 MW dan 65-75 MW

% Plot kurva biaya
figure;
hold on;

% Plot shading dan label untuk POZ (tidak masuk legend)
for i = 1:size(POZ, 1)
    x1 = POZ(i, 1);
    x2 = POZ(i, 2);
    P_poz = linspace(x1, x2, 100);
    Cost_poz = a * P_poz.^2 + b * P_poz + c + e * abs(sin(f * (P_poz - 20)));
    fill([P_poz fliplr(P_poz)], [Cost_poz zeros(size(Cost_poz))], ...
        [1 0 0], 'FaceAlpha', 0.2, 'EdgeColor', 'none');
    
    % Label POZ
    text(mean([x1 x2]), max(Cost_poz)+1000, sprintf('POZ %d', i), ...
        'HorizontalAlignment', 'center', 'FontSize', 10, 'Color', 'r');
end

% Plot kurva biaya
h1 = plot(P, Cost_base, 'k', 'LineWidth', 1.5);   % Simpan handle untuk legend
h2 = plot(P, Cost_vpe, 'b', 'LineWidth', 1.5);

% Garis vertikal Pmin dan Pmax
plot([Pmin Pmin], [0 Cost_min], 'k--', 'LineWidth', 1.2);
plot([Pmax Pmax], [0 Cost_max], 'k--', 'LineWidth', 1.2);

% Legend hanya untuk garis biaya
legend([h1, h2], {'Biaya tanpa VPE', 'Biaya dengan VPE'}, 'Location', 'northwest');

% Label sumbu
xlabel('Power Output (MW)', 'FontSize', 11);
ylabel('Cost $/h', 'FontSize', 11);

% Batas sumbu
xlim([10 110]);
ylim([0 3.5e4]);

% Format tampilan
set(gca, 'FontName', 'Times New Roman', 'FontSize', 11);
box on;

% Anotasi panah (opsional)
ax = gca;
Pmin_norm = (Pmin - ax.XLim(1)) / diff(ax.XLim);
Pmax_norm = (Pmax - ax.XLim(1)) / diff(ax.XLim);
Cmin_norm = (Cost_min - ax.YLim(1)) / diff(ax.YLim);
Cmax_norm = (Cost_max - ax.YLim(1)) / diff(ax.YLim);