% Load or define your trained Tiny16 Vision Transformer model
modelData = load('netTransformerbertlk1.mat'); % Replace with your model file
model = modelData.netTransformerbertlk1; % Adjust based on your saved structure

% Load and preprocess the input image
inputImage = imread('100.bmp'); % Replace with your test image
inputImage = imresize(inputImage, [384, 384]); % Resize to model input size

% Ensure the input image is RGB
if size(inputImage, 3) == 1
    inputImageRGB = cat(3, inputImage, inputImage, inputImage); % Convert grayscale to RGB
else
    inputImageRGB = inputImage;
end

% Normalize the input image
inputImageRGB = im2double(inputImageRGB);

% Identify the layer to extract attention maps
layerName = 'encoderblock12_conv1d1'; % Replace with the actual layer name that produces attention maps
attentionMap = activations(model, inputImage, layerName, 'OutputAs', 'channels');

% Process the attention map
attentionMapResized = imresize(attentionMap, [size(inputImage, 1), size(inputImage, 2)]);
attentionMapNormalized = mat2gray(attentionMapResized);
figure,imshow(attentionMapNormalized);
% Convert attention map to a heatmap
colormapName = 'jet'; % Use a jet colormap for visualization
heatmapRGB = ind2rgb(im2uint8(attentionMapNormalized), colormap(colormapName));

% Overlay the heatmap on the original image
overlayAlpha = 0.5; % Transparency factor for blending
overlayImage = inputImageRGB * (1 - overlayAlpha) + heatmapRGB * overlayAlpha;

% Display the attention heatmap
figure;
imshow(overlayImage);
title('Attention Map Overlay as Heatmap');
