clc
clearvars
close all
img = imread('/Users/thaweesaktrongtirakul/Library/CloudStorage/OneDrive-RajamangalaUniversityofTechnologyPhranakhon/AGAIAN/SolarPanel/Images/PV/solar_Wed_Jun_14_9__34__29_2017_L_0.409451347546_I_0.317498039216.jpg');
%% Enhancement
Enhanced = Enhancement1(img);
% Enhanced = AHE(Enhanced);
%% Background Removal
% Option 1: Generate the masking metric from an input image
%  [Mask] = BackgroundRemoval(img);
% Option 2: Read the masking metric from a masking image
   [Mask] = double(imread('mask.png')) / 255;
%% Extract All Interested Pixels
I = uint8(double(img(:,:,1)) .* Mask);
J = uint8(double(Enhanced(:,:,1)) .* Mask);
X = J(Mask==1);
%% Construct the enhanced image to their origin locations
J = I;
J(Mask==1) = X;
%% Generate the segemnted regions
u = 1.0 * mean(X(:));
R = zeros(size(Mask));
R(J>u) = 1;
for i = 1:3
    R = medfilt2(R, [5 5]);
end
R = 1 - R;
imshow(R)