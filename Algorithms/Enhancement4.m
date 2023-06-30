function [newimg] = Enhancement4(img)
    HSV = rgb2hsv(img);
    threshold = 0.1:0.1:1.0;
    I   = uint8(HSV(:,:,3) * 255);
    [newimg] = NormalizeSize(I);
    for i = 1:size(threshold,2)
        [mask]     = MaskingMS(newimg,threshold(i));
        [enhanced] = RegionEnhancement3(newimg,mask);
        E(:,:,i)   = imresize(enhanced, [size(I,1) size(I,2)]);
    end
    HSV(:,:,3) = mean(E,3) / 255;
    % r = Retinex_Generation(I);
%     W = [0	1	0
%          1	1	1
%          0	1	0];
%     [r] = WeightedMedianFilter(r,W);
%     J = HSV(:,:,3) - (0.2 * log(r));
%     HSV(:,:,3) = J;
    newimg = uint8(hsv2rgb(HSV) * 255);
end