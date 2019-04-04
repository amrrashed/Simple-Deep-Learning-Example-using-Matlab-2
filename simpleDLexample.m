digitDatasetPath = fullfile('H:\image Dataset\101_ObjectCategories\modified');
imds = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders',true,'LabelSource','foldernames');

labelCount = countEachLabel(imds)
img = readimage(imds,1);
size(img)
[imdsTrain,imdsTest] = splitEachLabel(imds,0.7,'randomized');
layers = [
    imageInputLayer([145 145 1])
    
    convolution2dLayer(3,8,'Padding',1)
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding',1)
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding',1)
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(102)
    softmaxLayer
    classificationLayer];
    options = trainingOptions( 'sgdm','Plots', 'training-progress');
net = trainNetwork(imdsTrain,layers,options);
YPred = classify(net,imdsTest);
YTest = imdsTest.Labels;
accuracy = sum(YPred == YTest)/numel(YTest)
%%save Network
save simpleDL.mat net layers
%% Try to classify something else
img = readimage(imds,3);
actualLabel = imds.Labels(3);
predictedLabel = net.classify(img);
imshow(img);
title(['Predicted: ' char(predictedLabel) ', Actual: ' char(actualLabel)])
