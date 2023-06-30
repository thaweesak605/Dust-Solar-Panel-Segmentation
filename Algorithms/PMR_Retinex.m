function Value = PMR_Retinex(I,mask,x,y)
%% Block-Based Processing
    % Seperate an array into small blocks.
    RAW = I;
    B = im2col(RAW,[5 5],'sliding');
    BOX = zeros([5,5,size(B,2)]);
    for i = 1:size(B,2)
        BOX(:,:,i) = reshape(B(:,i),5,5);
    end
    Value = zeros([1,size(B,2)]);
    for i = 1:size(B,2)
        % Block Initialization.
        T = BOX(:,:,i) + 1;
        T = T(mask > 0);
        T1 = T(1:end-1);
        T2 = T(2:end);
        % Ratio Calculation (R).
        R = T2 ./ T1;
        R(R>1) = 1;
        % Partial Cummulative Product
        Value(i) = prod(R,1);
    end
    Value = reshape(Value,x,y);
end