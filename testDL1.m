load simpleDL.mat
digitDatasetPath = fullfile('H:\image Dataset\101_ObjectCategories\modified');
imds = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders',true,'LabelSource','foldernames');
img = readimage(imds,3);
actualLabel = imds.Labels(3);
predictedLabel = net.classify(img);
imshow(img);
title(['Predicted: ' char(predictedLabel) ', Actual: ' char(actualLabel)])
