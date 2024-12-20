% Read an image
originalImage = imread('13.bmp');

% Convert the image to grayscale if it's not already
if size(originalImage, 3) == 3
    originalImage = rgb2gray(originalImage);
end

% Compute the histogram of the image
histogram = imhist(originalImage);

% Determine the threshold to separate the histogram into two parts
threshold = graythresh(originalImage);

% Divide the histogram into two parts based on the threshold
histogram_low = histogram(1 : round(threshold * 255));
histogram_high = histogram(round(threshold * 255) + 1 : end);

% Perform histogram equalization separately on each part
result_low = histeq(originalImage, histogram_low);
result_high = histeq(originalImage, histogram_high);

% Combine the results
resultImage = zeros(size(originalImage));
resultImage(originalImage <= round(threshold * 255)) = result_low(originalImage <= round(threshold * 255));
resultImage(originalImage > round(threshold * 255)) = result_high(originalImage > round(threshold * 255));

% Display the original and resulting images
subplot(1, 2, 1), imshow(originalImage), title('Original Image');
subplot(1, 2, 2), imshow(resultImage), title('Bi-Histogram Equalized Image');
