function result = rbf(centers, widths, weights, x_value, y_value);
for c = [1: size(centers, 2)];
distances_multiplied = ((x_value - center(1, c)) .^ 2) .* ((y_value - center(2, c)) .^ 2);
function = weight(exp(distances_multiplied ./ (
