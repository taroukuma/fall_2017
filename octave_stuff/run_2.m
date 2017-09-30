x_values = linspace(0, 1000, 1000);
constant = 1000;
result = [];

for x = x_values;
result = [result, fun(x, constant)];
end;

for r = [1: size(result, 1)];
plot(x_values, result(r, :));
hold on;
end;
