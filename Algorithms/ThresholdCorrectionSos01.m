% --------------------Input--------------------
% nn - 1D histogram
% k  - The largest elements of array
% --------------------Output-------------------
% threshold - Optimal Single Threshold
% ---------------------------------------------
function [threshold,f] = ThresholdCorrectionSos01(img)
    nn = imhist(img);
    p = nn / sum(nn);
    c = cumsum(p);
    for i = 2:254
        a = sum(c(1:i));
        b = sum(c(i+1:end));
        a = (a + 1) .^ 1;
        b = (b + 1) .^ 1;
        s1(i) = a .* tan(log10(log10(a)));
        s2(i) = b .* tan(log10(log10(b)));
    end
    F = (s1 + s2);
    f = F(2:end);
    threshold = find(f==max(f(:)));
end