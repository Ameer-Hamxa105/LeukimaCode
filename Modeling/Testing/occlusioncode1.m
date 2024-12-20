clc;
close all;
clear all;

% Load or define your trained Tiny16 Vision Transformer model
modelData = load('netTransformerbertlk1.mat'); % Replace with your model file
net = modelData.netTransformerbertlk1;

[filename, pathname] = uigetfile({'*.*';'*.bmp';'*.jpg';'*.gif'}, 'Pick a Leaf Image File');
img = imread([pathname,filename]);

inputSize = net.Layers(1).InputSize(1:2);
img = imresize(img,inputSize);

figure, imshow(img)

label = classify(net,img);

scoreMap = occlusionSensitivity(net,img,label);
% Plot the result over the original image with transparency to see which areas of the image affect the classification score.

figure
imshow(img)
hold on
imagesc(scoreMap,'AlphaData',0.5);
colormap jet