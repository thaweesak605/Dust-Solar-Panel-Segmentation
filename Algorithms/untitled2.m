clc
clearvars
close all
img = imread('/Users/thaweesaktrongtirakul/Library/CloudStorage/OneDrive-RajamangalaUniversityofTechnologyPhranakhon/AGAIAN/SolarPanel/Images/PV/solar_Wed_Jun_14_9__34__29_2017_L_0.409451347546_I_0.317498039216.jpg');
img = rgb2gray(img);
[X,Y] = meshgrid(1:length(img));
stlwrite('Output.stl', X, Y, img);