function [Mask] = BackgroundRemoval(img)
    M = ones(size(img(:,:,1)));
    Mask = ones(size(img));
    [~,~,z] = size(img);
    for j = 1:z
        [~,mserCC] = detectMSERFeatures(img(:,:,z));
        for i = 1:size(mserCC.PixelIdxList,2)
            ind = mserCC.PixelIdxList(i);
            ind   = ind{1,1};
            M(ind) = 0;
        end
        Mask(:,:,j) = M;
    end
    Mask = min(Mask,[],3);
    Mask = imbinarize(Mask,0.5);
    for i = 1:5
        Mask = 1 * medfilt2(Mask, [3 3]);
    end
end