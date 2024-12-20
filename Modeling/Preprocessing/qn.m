% Read the input image
input_image = imread('3.jpg');

% Convert the image to double precision for calculations
input_image = im2double(input_image);

% Define the parameters for sigmoid enhancement
a = 0.30; % Adjust this parameter for desired enhancement strength

% Compute the hyperbolic sine term
hyperbolic_sine = sinh(a * input_image);

% Compute the sigmoid function
sigmoid_output = 1 ./ (1 + exp(-hyperbolic_sine));

% Scale the output to the range [0, 1]
enhanced_image = mat2gray(sigmoid_output);

% Display the original and enhanced images
subplot(1,2,1);
imshow(input_image);
title('Original Image');

subplot(1,2,2);
imshow(enhanced_image);
title('Enhanced Image');
