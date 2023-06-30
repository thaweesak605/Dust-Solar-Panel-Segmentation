function [newimg] = AHE(img)
    Imin = double(min(img(:)));
    Imax = double(max(img(:)));
    nn   = imhist(img);
    n    = nn;
    u    = mean(nn(:)) * 1000;
    u    = round(u);
    nn(nn>u) = u;
    n    = sum(n(:)) - sum(nn(:));
    nn   = nn + round(n / 256);
    p    = nn / sum(nn(:));
    c    = cumsum(p);
    c    = log2(c + 1);
    f    = uint8((Imax - Imin) .* c + Imin);  
    newimg = f(double(img) + 1);
end