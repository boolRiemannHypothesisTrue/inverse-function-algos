f = @(x) x.^3;
y_target = 2;

xgrid = linspace(0,pi, 1e6);  % сетка по x
ygrid = f(xgrid);

% Находим индексы, где функция пересекает y_target
cross_idx = find((ygrid(1:end-1)-y_target).*(ygrid(2:end)-y_target) <= 0);

roots = zeros(size(cross_idx));
for k = 1:length(cross_idx)
    % используем fzero на каждом маленьком интервале сетки
    x0_interval = xgrid(cross_idx(k):cross_idx(k)+1);
    roots(k) = fzero(@(x) f(x)-y_target, x0_interval);
end

disp(roots)
