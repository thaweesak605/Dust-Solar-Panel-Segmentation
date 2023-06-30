clc
clearvars
close all
img = imread('/Users/thaweesaktrongtirakul/Library/CloudStorage/OneDrive-RajamangalaUniversityofTechnologyPhranakhon/AGAIAN/SolarPanel/Images/PV/solar_Wed_Jun_14_9__34__29_2017_L_0.409451347546_I_0.317498039216.jpg');
% I = double(rgb2gray(img));
% for i = 1:3
%     I = medfilt2(I, [5 5]);
% end
% 
% function stlwrite2(I,filename)
%     X = 1:size(I,1);
%     X = repmat(X',1,size(I,2));
%     Y = 1:size(I,2);
%     Y = repmat(Y',1,size(I,1))';
%     surf2stl(filename,X,Y,I);
% end
