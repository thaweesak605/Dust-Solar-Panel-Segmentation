clc
clearvars
close all
img = imread('/Users/thaweesaktrongtirakul/Library/CloudStorage/OneDrive-RajamangalaUniversityofTechnologyPhranakhon/AGAIAN/SolarPanel/Images/PV/solar_Wed_Jun_21_6__15__35_2017_L_0.134716732543_I_0.0119058823529.jpg');
%% Enhance the input image
[newimg,Retinex_img] = Enhancement(img);
%% Fusion
% w = 0.0;
% newimg = uint8(w * (255 - Retinex_img * 255) + (1 - w) * double(newimg));
%% Background Removal
% Option 1: Generate the masking metric from an input image
%  [Mask] = BackgroundRemoval(img);
% Option 2: Read the masking metric from a masking image
   [Mask] = double(imread('mask.png')) / 255;
%% Extract All Interested Pixels
I = uint8(double(rgb2gray(img)) .* Mask);
J = uint8(double(rgb2gray(newimg)) .* Mask);
K = Retinex_img .* Mask;
CI = img;
CJ = img;
for i = 1:size(img,3)
    CI(:,:,i) = uint8(double(img(:,:,i)) .* Mask);
    CJ(:,:,i) = uint8(double(newimg(:,:,i)) .* Mask);
end
%% Generate the segemnted regions
X = J(Mask==1);
u = 1.0 * mean(X(:));
R = zeros(size(Mask));
R(J>u) = 1;
for i = 1:5
    R = 1 - medfilt2(R, [2 2]);
end
%% Display images
figure; imshow(img)
figure; imshow(newimg)
figure; imshow(CI)
figure; imshow(CJ)
figure; imshow(Retinex_img)
figure; imshow(R)
%% Display 3D Models
D3I = flip(I,1);
figure;
surf(D3I); title('3D Artificial Image');
title('3D Original Image')
shading interp
colormap jet
axis tight
set(gca,'nextplot','replacechildren','visible','off')
view(0,83)
[X,Y] = meshgrid(1:length(D3I));
for i = 1:5
    D3I = medfilt2(D3I, [2 2]);
end
stlwrite('Test1.stl', X, Y, D3I);

D3J = flip(J,1);
figure;
surf(D3J); title('3D Artificial Image');
title('3D Enhanced Image')
shading interp
colormap jet
axis tight
set(gca,'nextplot','replacechildren','visible','off')
view(0,83)
[X,Y] = meshgrid(1:length(D3J));
for i = 1:5
    D3J = medfilt2(D3J, [2 2]);
end
stlwrite('Test2.stl', X, Y, D3J);