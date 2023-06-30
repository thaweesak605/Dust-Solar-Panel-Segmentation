function [b] = WeightedMedianFilter(I,W)
    I = double(I);
    I = padarray(I,[1 1],'both');
    [row, col] = size(I);
    for x = 2:1:row-1
        for y = 2:1:col-1
    %% To make a 3x3 weighted mask into a 1x9 mask
    a1 = [W(1)*I(x-1,y-1) W(2)*I(x-1,y) W(3)*I(x-1,y+1) ...
          W(4)*I(x,y-1)   W(5)*I(x,y)   W(6)*I(x,y+1)...
          W(7)*I(x+1,y-1) W(8)*I(x+1,y) W(9)*I(x+1,y+1)];
    a2 = sort(a1);
    med = a2(5); % the 5th value is the weighted median 
    b(x,y) = med;
        end
    end
    b = b(2:end,2:end);
%     b = NormalRange(b,min(I(:)),max(I(:)),1);
end