clc
clearvars
close all
img  = imread('/Users/thaweesaktrongtirakul/Library/CloudStorage/OneDrive-RajamangalaUniversityofTechnologyPhranakhon/AGAIAN/SolarPanel/Images/PV/solar_Wed_Jun_14_9__27__0_2017_L_0.0972486379583_I_0.517533333333.jpg');
% mask = imread('/Users/thaweesaktrongtirakul/Library/CloudStorage/OneDrive-RajamangalaUniversityofTechnologyPhranakhon/AGAIAN/SolarPanel/Ground Truths/17.jpg');
mask = imread('mask.png');
%% Enhancement
% You can remove this part by replacing img as an enhanced image instade.
    [x,y,z] = size(img);
    img = reshape(img,x,y*z);
    img = histeq(img);
    img = reshape(img,x,y,z);
%% Layer 1
%% See also: https://htmlcolorcodes.com
ColorCode = [0 255 0];  
t_min = 0;              
t_max = 63;             % <<---- You can change it yourself 64,65,...,n
I      = rgb2gray(img);
LayerG1 = zeros(size(mask));
LayerG1((mask == 0)&(I>=t_min)&(I<=t_max)) = I((mask == 0)&(I>=t_min)&(I<=t_max));
Layer1 = Coloring(img,t_min,t_max,mask,ColorCode);
%% Layer 2
ColorCode = [255 255 0];  
t_min = 64;             % <<---- You can change it yourself 65,66,...,n+1
t_max = 128;            % <<---- You can change it yourself
I      = rgb2gray(img);
LayerG2 = zeros(size(mask));
LayerG2((mask == 0)&(I>=t_min)&(I<=t_max)) = I((mask == 0)&(I>=t_min)&(I<=t_max));
Layer2 = Coloring(img,t_min,t_max,mask,ColorCode);
%% Layer 3
ColorCode = [255 128 0];  
t_min = 129;            % <<---- You can change it yourself
t_max = 192;            % <<---- You can change it yourself
I      = rgb2gray(img);
LayerG3 = zeros(size(mask));
LayerG3((mask == 0)&(I>=t_min)&(I<=t_max)) = I((mask == 0)&(I>=t_min)&(I<=t_max));
Layer3 = Coloring(img,t_min,t_max,mask,ColorCode);
%% Layer 4
ColorCode = [255 0 0];  
t_min = 193;            % <<---- You can change it yourself
t_max = 255;
I      = rgb2gray(img);
LayerG4 = zeros(size(mask));
LayerG4((mask == 0)&(I>=t_min)&(I<=t_max)) = I((mask == 0)&(I>=t_min)&(I<=t_max));
Layer4 = Coloring(img,t_min,t_max,mask,ColorCode);
%% Fuse All Layers
Layer = (double(Layer1) + double(Layer2) + double(Layer3) + double(Layer4));
Layer = uint8(Layer);
%% Display Images and Layer
subplot(2,3,1); imshow(img)
subplot(2,3,4); imshow(Layer)
subplot(2,3,2); imshow(Layer1)
subplot(2,3,3); imshow(Layer2)
subplot(2,3,5); imshow(Layer3)
subplot(2,3,6); imshow(Layer4)
    

D3I = flip(LayerG1,1);
figure;
surf(D3I); title('3D Artificial Image');
title('3D Original Image')
shading interp
colormap jet
axis tight
set(gca,'nextplot','replacechildren','visible','off')
view(0,83)
[X,Y] = meshgrid(1:length(D3I));
stlwrite('LayerG1.stl', X, Y, D3I);

D3I = flip(LayerG2,1);
figure;
surf(D3I); title('3D Artificial Image');
title('3D Original Image')
shading interp
colormap jet
axis tight
set(gca,'nextplot','replacechildren','visible','off')
view(0,83)
[X,Y] = meshgrid(1:length(D3I));
stlwrite('LayerG2.stl', X, Y, D3I);

D3I = flip(LayerG3,1);
figure;
surf(D3I); title('3D Artificial Image');
title('3D Original Image')
shading interp
colormap jet
axis tight
set(gca,'nextplot','replacechildren','visible','off')
view(0,83)
[X,Y] = meshgrid(1:length(D3I));
stlwrite('LayerG3.stl', X, Y, D3I);

D3I = flip(LayerG4,1);
figure;
surf(D3I); title('3D Artificial Image');
title('3D Original Image')
shading interp
colormap jet
axis tight
set(gca,'nextplot','replacechildren','visible','off')
view(0,83)
[X,Y] = meshgrid(1:length(D3I));
stlwrite('LayerG4.stl', X, Y, D3I);

function newimg = Coloring(img,t_min,t_max,mask,ColorCode)
    I = double(rgb2gray(img));
    R = uint8(zeros(size(I)));
    G = uint8(zeros(size(I)));
    B = uint8(zeros(size(I)));    
    R((mask == 0) & (I > t_min) & (I <= t_max)) = ColorCode(1);
    G((mask == 0) & (I > t_min) & (I <= t_max)) = ColorCode(2);
    B((mask == 0) & (I > t_min) & (I <= t_max)) = ColorCode(3);
    newimg = cat(3,R,G,B);
    clear R G B Color
end