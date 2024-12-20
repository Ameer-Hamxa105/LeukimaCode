%% DatasetLoad

%% import Dataset
digitDatasetPath = fullfile('E:\Leukemia paper\C-NMC_Leukemia\training update');
 imds = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders',true,'LabelSource','foldernames');
 %% split data into training and validation
% numTrainFiles = 0.8;
% [imdsTrain,imdsValidation] = splitEachLabel(imds,numTrainFiles,"randomize");
[imdsTrain,imdsValidation,imdsTest] = splitEachLabel(imds,0.7,0.15);
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
%% View the ClassesName
classNames = categories(imds.Labels);
numClasses = numel(categories(imds.Labels))
%% Vision Transformer
net = visionTransformer("tiny-16-imagenet-384");
lgraph = layerGraph(net); % Extract the layer graph from the trained network and plot the layer graph.
 net.Layers(1); % Getting 1st layer information
inputSize = net.Layers(1).InputSize; % getting image size info
lgraph = removeLayers(lgraph, {'cls_index','head','softmax'});

newLayers = [  
    globalAveragePooling1dLayer('Name','gap1')
    fullyConnectedLayer(numClasses,'Name','fc','WeightLearnRateFactor',10,'BiasLearnRateFactor',10)
    softmaxLayer('Name','softmax')
    classificationLayer('Name','classoutput')];

lgraph = addLayers(lgraph,newLayers);
 lgraph = connectLayers(lgraph,'encoder_norm' ,'gap1');
%% Augmentor

augmenter = imageDataAugmenter( ...
    RandXReflection=true, ...
    RandRotation=[-90 90], ...
    RandScale=[1 2]);
augimdsTrain = augmentedImageDatastore(inputSize(1:2),imdsTrain,DataAugmentation=augmenter);

%% %% apply augmentator
augimdsValidation = augmentedImageDatastore(inputSize(1:2),imdsValidation);
augimdsTest = augmentedImageDatastore(inputSize(1:2),imdsTest);
%% training Options 
miniBatchSize = 64;

numObservationsTrain = numel(augimdsTrain.Files);
numIterationsPerEpoch = floor(numObservationsTrain/miniBatchSize);

options = trainingOptions("sgdm", ...
    'ExecutionEnvironment','gpu',...
    MaxEpochs=200, ...
    InitialLearnRate=0.0001, ...
    MiniBatchSize=miniBatchSize, ...
    ValidationData=augimdsValidation, ...
    ValidationFrequency=numIterationsPerEpoch, ...
    Plots="training-progress", ...
    Verbose=true);

%% Train network

  netTransformerbertlk1=trainNetwork(augimdsTrain,lgraph,options);
  % netTransformerbert = trainnet(augimdsTrain,lgraph,"crossentropy",options);
save('netTransformerbertlk1','netTransformerbertlk1');
