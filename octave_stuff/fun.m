function result = fun(x, constant);
%calculates various function values for a given real value and returns a vector
result = [];
result = [result; constant .* log(x)];
for i = [1: 10];
value = x .^ 2;
result = [result; 0.01 .* i .* value];
end;
end;
