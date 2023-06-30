clc
clearvars
close all
% img = imread('/Users/thaweesaktrongtirakul/Library/CloudStorage/OneDrive-RajamangalaUniversityofTechnologyPhranakhon/AGAIAN/SolarPanel/Images/PV/solar_Wed_Jun_14_16__56__25_2017_L_0.150770558895_I_0.245301960784.jpg');
img = imread('/Users/thaweesaktrongtirakul/Library/CloudStorage/OneDrive-RajamangalaUniversityofTechnologyPhranakhon/AGAIAN/SolarPanel/Images/PV/solar_Wed_Jun_14_9__34__29_2017_L_0.409451347546_I_0.317498039216.jpg');
% img = imread('/Users/thaweesaktrongtirakul/Library/CloudStorage/OneDrive-RajamangalaUniversityofTechnologyPhranakhon/AGAIAN/SolarPanel/Images/PV/solar_Wed_Jun_21_6__15__35_2017_L_0.134716732543_I_0.0119058823529.jpg');
% img = imread('/Users/thaweesaktrongtirakul/Library/CloudStorage/OneDrive-RajamangalaUniversityofTechnologyPhranakhon/Path_Based_Retinex_JND/Algorithm/Enhanced02.png');
% img = imread('/Users/thaweesaktrongtirakul/Library/CloudStorage/OneDrive-RajamangalaUniversityofTechnologyPhranakhon/AGAIAN/Thermal Satellite Images with Optimizations/Images/AX-x1-Solar_0000_DJI_0099.jpg');
%% Enhance the input image
[newimg,Retinex_img] = Enhancement2(img);
%% Background Removal
% Option 1: Generate the masking metric from an input image
%  [Mask] = BackgroundRemoval(img);
% Option 2: Read the masking metric from a masking image
   [Mask] = double(imread('mask.png')) / 255;
%% Extract All Interested Pixels
I = uint8(double(img(:,:,1)) .* Mask);
J = uint8(double(newimg(:,:,1)) .* Mask);
K = Retinex_img .* Mask;
X = J(Mask==1);
CI = img;
CJ = img;
for i = 1:size(img,3)
    CI(:,:,i) = uint8(double(img(:,:,i)) .* Mask);
    CJ(:,:,i) = uint8(double(newimg(:,:,i)) .* Mask);
end
%% Enhance the extracted the 1D image
% X = AHE(X);
%% Construct the enhanced image to their origin locations
J = I;
J(Mask==1) = X;
%% Remove Sharp Edges Due to Enhancement Processes
% J = medfilt2(J, [3 3]);
%% Generate the Artificial Thermal Color
[Recolored] = Colormap(J,0);
%% Initialize the 3D model
B = flip(J,1);
%% Generate the segemnted regions
u = 0.95 * mean(X(:));
R = zeros(size(Mask));
R(J>u) = 1;
for i = 1:5
    R = medfilt2(R, [3 3]);
end
R = 1 - R;
%% Segmented Regions
RI = uint8((1 - R) .* double(I));
RJ = uint8((1 - R) .* double(J));
%% Display images
figure; imshow(img)
figure; imshow(newimg)
figure; imshow(CI)
figure; imshow(CJ)
figure; imshow(Retinex_img)
figure; imshow(K)
figure; imshow(R)
%% Display 3D Models
D3I = flip(RI,1);
for i = 1:5
    D3I = medfilt2(D3I, [2 2]);
end
figure;
surf(D3I); title('3D Artificial Image');
title('3D Original Image')
shading interp
colormap jet
axis tight
set(gca,'nextplot','replacechildren','visible','off')
view(0,83)
[X,Y] = meshgrid(1:length(D3I));
stlwrite('Test1.stl', X, Y, D3I);

D3J = flip(RJ,1);
for i = 1:4
    D3J = medfilt2(D3J, [2 2]);
end
figure;
surf(D3J); title('3D Artificial Image');
title('3D Enhanced Image')
shading interp
colormap jet
axis tight
set(gca,'nextplot','replacechildren','visible','off')
view(0,83)
[X,Y] = meshgrid(1:length(D3J));
stlwrite('Test2.stl', X, Y, D3J);

close all
subplot(2,2,1); imshow(CI)
subplot(2,2,2); imshow(CJ)
subplot(2,2,3); surf(D3I); shading interp; axis tight; set(gca,'nextplot','replacechildren','visible','off'); view(0,83); colormap jet;
subplot(2,2,4); surf(D3J); shading interp; axis tight; set(gca,'nextplot','replacechildren','visible','off'); view(0,83); colormap jet;