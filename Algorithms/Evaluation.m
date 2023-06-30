clc
clearvars
close all

GT = imread('/Users/thaweesaktrongtirakul/Library/CloudStorage/OneDrive-RajamangalaUniversityofTechnologyPhranakhon/AGAIAN/SolarPanel/Ground Truths/00.jpg');
SG = imread('/Users/thaweesaktrongtirakul/Library/CloudStorage/OneDrive-RajamangalaUniversityofTechnologyPhranakhon/AGAIAN/SolarPanel/Segmented Regions/00.jpg');
SG = rgb2gray(SG);
GT = imresize(GT,[size(SG,1) size(SG,2)]);
SG = imbinarize(SG);
GT = imbinarize(GT);

Jaccard_similarity = jaccard(SG,GT)
Dice_similarity = dice(SG,GT)
[BF_score,precision,recall] = bfscore(SG,GT)