function [newimg] = RegionEnhancement2(newimg,mask)
    for i = 1:max(mask(:))
        I = newimg(mask==i);
        [x,~,~] = size(I);
        I = reshape(I,sqrt(x),sqrt(x),1);
        II = adapthisteq(I,'clipLimit',0.00005);
        II = reshape(II,x,1,1);
        newimg(mask==i) = II;
    end
end

% Define a new width...