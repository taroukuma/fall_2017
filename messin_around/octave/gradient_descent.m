x_grid = linspace(-10, 10, 100);

%y_grid = linspace(-10, 10, 100);
%threshold = ;
%step_value = ;

%[x, y] = meshgrid(x_grid, y_grid);
%surf(x, y, func(x, y));

%3d parametric:
plot3(zeros(size(x_grid, 1), size(x_grid, 2)), x_grid.*4, sin(x_grid));
