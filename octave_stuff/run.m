input = linspace(-10, 10, 100);
[output, original] = fun(input);

scatter(input, output);
hold on;
plot(input, original);

rbf_start = -8;
rbf_end = 8;
how_many = 10;
width = 0.5;

weights = regression(rbf_start, rbf_end, how_many, width, input, output);
