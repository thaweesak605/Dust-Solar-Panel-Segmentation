function stlwrite2(I,filename)
    X = 1:size(I,1);
    X = repmat(X',1,size(I,2));
    Y = 1:size(I,2);
    Y = repmat(Y',1,size(I,1))';
    surf2stl(filename,X,Y,I);
end