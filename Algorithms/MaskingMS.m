function [mask] = MaskingMS(img,threshold)
    [x,y,z] = size(img);
    c = cat(2,x,y,z);
    S = qtdecomp(img,threshold, [8 max(c)/2]);
%     S = qtdecomp(img,threshold, [8 16]);
    S = full(S);
    [x,y] = find(S>0);
    mask = S;
    for i = 1:size(x,1)
        block_size = S(x(i),y(i));
        mask(x(i):x(i)+block_size-1,y(i):y(i)+block_size-1) = i;
    end
end