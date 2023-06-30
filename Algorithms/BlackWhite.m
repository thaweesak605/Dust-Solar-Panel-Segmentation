clc
clearvars
close all
img = imread('/Users/thaweesaktrongtirakul/Downloads/6.png');
img(img>0) = 255;
img = 255 - img;
imshow(img)