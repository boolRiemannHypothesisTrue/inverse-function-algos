function invBranches = inverse_function(f, xgrid)
    % f       - функция @(x)
    % xgrid   - сетка по x
    % invBranches - ячейка с анонимными функциями для обратных веток
    
    y = f(xgrid);
    
    % Находим точки, где функция меняет монотонность
    dy = diff(y);
    changeIdx = find(dy(1:end-1).*dy(2:end) < 0);  % смена знака производной
    
    % Добавим начало и конец
    idx = [1, changeIdx+1, numel(xgrid)];
    
    invBranches = {};
    
    % Строим обратные на каждом отрезке монотонности
    for k = 1:numel(idx)-1
        xseg = xgrid(idx(k):idx(k+1));
        yseg = y(idx(k):idx(k+1));
        
        % проверим направление (чтобы y рос для interp1)
        if yseg(1) > yseg(end)
            xseg = fliplr(xseg);
            yseg = fliplr(yseg);
        end
        
        invBranches{end+1} = @(yy) interp1(yseg, xseg, yy, 'spline', 'extrap');
    end
end
