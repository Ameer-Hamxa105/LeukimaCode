clc;close all;clear;
%% import Dataset
digitDatasetPath = fullfile('E:\Leukemia paper\C-NMC_Leukemia\training update');
 imds = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders',true,'LabelSource','foldernames');
 %% split data into training and validation
numTrainFiles = 0.7;
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,"randomize");
%% Visualization of Dataset Random 6 samples
% num_images=length(imds.Labels);
% perm=randperm(num_images,6);
% for idx=1:length(perm)
% 
%     subplot(2,3,idx);
%     imshow(imread(imds.Files{perm(idx)}));
%     title(sprintf('%s',imds.Labels(perm(idx))))
% 
% end

 %% load the Res2leyered architecture
    % ResBlock Architecture 
%     net=dlnetwork(lgraph_1);

    net=load('MInvertedCNN.mat');
    net=net.MInvertedCNN;
    %% convert network into layer graph
    lgraph = layerGraph(net);
    clear net;
    %% transfer learning by fine-tuned the last three layers
    numClasses = numel(categories(imdsTrain.Labels));    
newFCLayer = fullyConnectedLayer(numClasses,'Name','NewFc','WeightLearnRateFactor',10,'BiasLearnRateFactor',10);
lgraph = replaceLayer(lgraph,'fc',newFCLayer);
newClassLayer = softmaxLayer('Name','NewSoftmax');
lgraph = replaceLayer(lgraph,'softmax',newClassLayer);

newClassLayer1 = classificationLayer('Name','classification');
lgraph = addLayers(lgraph,newClassLayer1);
lgraph = replaceLayer(lgraph,'classification',newClassLayer1);
lgraph = connectLayers(lgraph,'NewSoftmax','classification');


    %% Augmenter
    augmenter = imageDataAugmenter( ...
        'RandRotation',[-5 5],'RandXReflection',1,...
        'RandYReflection',1,'RandXShear',[-0.05 0.05],'RandYShear',[-0.05 0.05]);
    %% Resize training and testing data according to network
    auimds = augmentedImageDatastore([227 227 3],imdsTrain,'ColorPreprocessing','gray2rgb','DataAugmentation',augmenter);
    auimdsVali = augmentedImageDatastore([227 227 3],imdsValidation,'ColorPreprocessing','gray2rgb','DataAugmentation',augmenter);
    
%% Training Options 

    options = trainingOptions('sgdm',...
        'ExecutionEnvironment','gpu',...
        'MaxEpochs',200,'MiniBatchSize',128,...
        'Shuffle','every-epoch', ...
        'ValidationData',auimdsVali,...
        'InitialLearnRate',0.00016, ...
        'Verbose',true, ...
        'Plots','training-progress');
%% train Network
    TrainedMInvertedSiri1 = trainNetwork(auimds,lgraph,options);
    %% save Trained Network
    save('TrainedMInvertedSiri1','TrainedMInvertedSiri1');
    