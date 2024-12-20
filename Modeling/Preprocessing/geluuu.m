% Read an image
originalImage = imread('111.bmp');

% Convert the image to double precision for calculations
originalImage = im2double(originalImage);

% Get the size of the image
[m, n] = size(originalImage);

% Initialize result image
resultImage = zeros(m, n);

% Apply hyperbolic tangent function to each pixel
for i = 1:m
    for j = 1:n
        resultImage(i, j) = tanh(originalImage(i, j));
    end
end

% Display the original and resulting images
subplot(1,2,1), imshow(originalImage), title('Original Image');
subplot(1,2,2), imshow(resultImage), title('Resulting Image (tanh)');
