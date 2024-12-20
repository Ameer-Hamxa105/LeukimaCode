clc;
close all;
clear all;

% load('TrainedMInvertedNWPU.mat');
% net=TrainedMInvertedNWPU;

 % Load or define your trained Tiny16 Vision Transformer model
% modelData = load('netTransformerbertlk1.mat'); % Replace with your model file
% net = modelData.netTransformerbertlk1;
net=load('TrainedMInvertedSiri1.mat')
net=net.TrainedMInvertedSiri1;
[filename, pathname] = uigetfile({'*.*';'*.bmp';'*.jpg';'*.gif'}, 'Pick a Leaf Image File');
img = imread([pathname,filename]);

% img=cat(3,img,img,img);
img = imresize(img,[227 227]);

figure, imshow(img)

[label, score] = classify(net,img);

scoreMap = imageLIME(net,img,label);
% Plot the result over the original image with transparency to see which areas of the image affect the classification score.

figure
imshow(img)
hold on
imagesc(scoreMap,'AlphaData',0.5)
colormap jet