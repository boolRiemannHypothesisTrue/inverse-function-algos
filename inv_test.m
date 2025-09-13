f = @(x) sin(x);
xgrid = linspace(0, 2*pi, 1e4);

% Строим ветки обратной функции через интерполяцию
invBranches = inverse_function(f, xgrid);

yyq = linspace(-1, 1, 1e4);

figure;
set(gcf,'Color','white');

% --- Оригинальная функция ---
subplot(1,2,1);
plot(xgrid, f(xgrid), 'k','LineWidth',1.5);
grid on; axis tight;
title('f(x) = sin(x)','FontSize',14);

% --- Обратные ветки + сравнение с эталоном ---
subplot(1,2,2); hold on;
colors = lines(numel(invBranches));

for k = 1:numel(invBranches)
    % Интерполяция
    xx_interp = invBranches{k}(yyq);
    plot(xx_interp, yyq, 'Color', colors(k,:), 'LineWidth', 1.5, ...
        'DisplayName', sprintf('Ветка %d (interp)', k));
    
    % Эталон: арксин + сдвиг
    switch k
        case 1
            xx_true = asin(yyq);          % [-pi/2, pi/2]
        case 2
            xx_true = pi - asin(yyq);     % [pi/2, 3pi/2]
        otherwise
            xx_true = NaN(size(yyq));     % если появятся новые ветки
    end
    plot(xx_true, yyq, '--', 'Color', colors(k,:), 'LineWidth', 1.2, ...
        'DisplayName', sprintf('Ветка %d (эталон)', k));
end

grid on; axis tight;
title('Ветки обратной функции f^{-1}(y)','FontSize',14);
legend('Location','Best');
