% Load or define your trained Tiny16 Vision Transformer model
modelData = load('netTransformerbertlk1.mat'); % Replace with your model file
model = modelData.netTransformerbertlk1; % Adjust based on your saved structure

X = imread("100.bmp");
inputSize =[384 384];
X = imresize(X,inputSize);
figure,imshow(X);
scores = predict(model,single(X));
label = scores2label(scores)
scoreMap = gradCAM(model,X,label,ReductionLayer="prob");
figure
imshow(X)
hold on
imagesc(scoreMap,AlphaData=0.5)
colormap jet