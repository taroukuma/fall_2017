function result = fun(image);
original = imread(image);
result = zeros(size(original, 1), size(original, 2));
for i = [1: size(original, 3)];
result = result + original(:, :, i);
end;
imshow(result);
end;
