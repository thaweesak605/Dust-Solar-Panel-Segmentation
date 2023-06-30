clc
clearvars
close all
load('temp.mat');

X = sum(J,3);
T1 = zeros(size(X));
T2 = zeros(size(X));
T3 = zeros(size(X));
T1((X>200)&(X<250)) = 1;
T2((X>150)&(X<200)) = 1;
T3((X> 50)&(X<150)) = 1;
Segment1 = img .* uint8(T1);
Segment2 = img .* uint8(T2);
Segment3 = img .* uint8(T3);
subplot(2,2,1); imshow(Segment1)
subplot(2,2,2); imshow(Segment2)
subplot(2,2,3); imshow(Segment3)

Segment1 = imresize(Segment1, [256 256]);
Segment2 = imresize(Segment2, [256 256]);
Segment3 = imresize(Segment3, [256 256]);
GenerateSTL(Segment1,'Segment1.stl')
GenerateSTL(Segment2,'Segment2.stl')
GenerateSTL(Segment3,'Segment3.stl')

function GenerateSTL(input,filename)
    D3I = flip(input,1);
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
    stlwrite(filename, X, Y, D3I);
end