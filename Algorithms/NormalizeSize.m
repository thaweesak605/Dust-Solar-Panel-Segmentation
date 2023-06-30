function [newimg] = NormalizeSize(img)
    [x,y,~] = size(img);
    frac = 20;
    i = 0;
    j = 0;
    while frac > 1
        i = i + 1;
        frac = x / (2 ^ i);
    end
    frac = 20;
    while frac > 1
        j = j + 1;
        frac = y / (2 ^ j);
    end
    newimg = imresize(img, [2^i 2^j]);
end