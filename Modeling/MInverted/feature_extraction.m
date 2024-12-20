clear,clc, close all
datapath='D:\Datasets RS\SIRI-WHU\SIRI_WHU_Complete\Testing1';
imds=imageDatastore(datapath,  'IncludeSubfolders',true, 'LabelSource','foldernames');
% total_split=countEachLabel(imds)

net=load('TrainedMInvertedSiri.mat');
net=net.TrainedMInvertedSiri;

net.Layers(1)
net.Layers(end)
% Number of class names for ImageNet classification task
imageSize = net.Layers(1).InputSize;
% augmentedTrainingSet = augmentedImageDatastore(imageSize, imds, 'ColorPreprocessing', 'gray2rgb');
augmentedTestSet = augmentedImageDatastore(imageSize, imds, 'ColorPreprocessing', 'gray2rgb');

featureLayer = 'gapool1d';

% trainFeatures = activations(net, augmentedTrainingSet, featureLayer, ...
%     'MiniBatchSize', 32, 'OutputAs', 'columns');
% trainLabels = imdsTrain.Labels;

testFeatureNWPMI = activations(net, augmentedTestSet, featureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');
testLabelNWPoMI = imds.Labels;



 % save('testFeaturessiri','testFeaturessiri');
% save('testLabelssiri','testLabelssiri');


feat=im2double(testFeatureNWPMI);
 feat=feat';
feat=array2table(feat);
feat.type=testLabelNWPoMI;