%% image load
% im=imread('pond.tif');
% imshow(im)
% imgSize = size(im);
% imgSize = imgSize(1:2);
[filename, pathname] = uigetfile({'*.*';'*.bmp';'*.jpg';'*.gif'}, 'Pick a Leaf Image File');
im = imread([pathname,filename]);
%% Trained Network Load 
% load('TrainedMInvertedNWPU.mat');
% net=TrainedMInvertedNWPU;
net=load('TrainedMInvertedSiri1.mat')
net=net.TrainedMInvertedSiri1;
im=resize(im,[227,227]);
%% Activations of First Convolutional LayerTrainedMInvertedSiri1
act1 = activations(net,im,'conv');
sz = size(act1);
act1 = reshape(act1,[sz(1) sz(2) 1 sz(3)]);
I1 = imtile(mat2gray(act1),'GridSize',[8 8]);
figure,imshow(I1)
% % %% Activations in Specific Channels
% act1ch22 = act1(:,:,:,16);
% act1ch22 = mat2gray(act1ch22);
% act1ch22 = imresize(act1ch22,[227,227]);
% 
% I = imtile({im,act1ch22});
% imshow(I)
%% Investigate a Deeper Layer
% act6 = activations(net,im,'conv_30');
% sz = size(act6);
% act6 = reshape(act6,[sz(1) sz(2) 1 sz(3)]);
% 
% I = imtile(imresize(mat2gray(act6),[64 64]),'GridSize',[6 8]);
% imshow(I)

%%
act6 = activations(net,im,'swish');
sz = size(act6);
act6 = reshape(act6,[sz(1) sz(2) 1 sz(3)]);

I2 = imtile(imresize(mat2gray(act6),[64 64]),'GridSize',[6 8]);
figure, imshow(I2)
% %% 7
act6 = activations(net,im,'conv_28');
sz = size(act6);
act6 = reshape(act6,[sz(1) sz(2) 1 sz(3)]);

I3 = imtile(imresize(mat2gray(act6),[64 64]),'GridSize',[6 8]);
figure, imshow(I3)
%%
act6 = activations(net,im,'conv_32');
sz = size(act6);
act6 = reshape(act6,[sz(1) sz(2) 1 sz(3)]);

I4 = imtile(imresize(mat2gray(act6),[64 64]),'GridSize',[6 8]);
figure, imshow(I4)
%%
% act1 = activations(net,im,'conv');
% sz = size(act1);
% act1 = reshape(act1,[sz(1) sz(2) 1 sz(3)]);
% I1 = imtile(mat2gray(act1),'GridSize',[8 8]);
% figure,imshow(I1)
%%
