function [newimg] = RegionEnhancement3(newimg,mask)
    for i = 1:max(mask(:))
        I = newimg(mask==i);
        [x,~,~] = size(I);
        I = reshape(I,sqrt(x),sqrt(x),1);
        condition = 1;
        kernel = 11;
        II = CLAHE_HEHyperbolization(I,kernel,condition);
        II = reshape(II,x,1,1);
        newimg(mask==i) = II;
    end
end