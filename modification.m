clc;clear
%%resize all images to be 145*145*1
digitDatasetPath = fullfile('H:\image Dataset\101_ObjectCategories\modified2');
imds = imageDatastore(digitDatasetPath, ...
    'IncludeSubfolders',true,'LabelSource','foldernames');
for i=1:length(imds.Labels)
img=readimage(imds,i);
 [a b c]=size(img);
 switch(c)
     case (1)
img = imresize(readimage(imds,i),[145 145]);
     case (3)
  img = imresize(rgb2gray(readimage(imds,i)),[145 145]);         
 end
 imwrite(img,cell2mat(imds.Files(i)))
end

