function [Enhanced] = CLAHE_HEHyperbolization(img,kernel,condition)
% Condition = 1: Parallel network enable
% Kernel       : Size of a tile
% img          : 8-bit unsigned interger image
    I = double(img);
    D = kernel;
    center = round((D^2) / 2);
    S = round(D/2) - 1;
    I = padarray(I,[S S],'symmetric');
    k       = 0.0001;
    MAX     = 255;
    B = uint8(im2col(I,[D D],'sliding'));
    [~,y] = size(B);
    Enhanced = uint8(zeros([1 y]));
    if condition == 1
        parfor i = 1:y
            T = B(:,i);
            Imin = double(min(T(:)));
            Imax = double(max(T(:)));
            nn = imhist(B(:,i));
            p  = nn / sum(nn);
            c  = cumsum(p);
%             f  = uint8(MAX * k * exp(log(1 + (1 / k)) * c));
            f  = uint8(MAX * k * exp((1 + (1 / k)) * c));
            E  = f(B(:,i) + 1);
            E  = NormalRange(E,Imin,Imax,1);
            if E(center) == 0
                Enhanced(i) = T(center);
            else
                Enhanced(i) = E(center);
            end
        end
%         delete(gcp('nocreate'));
    else
        for i = 1:y
            T = B(:,i);
            Imin = double(min(T(:)));
            Imax = double(max(T(:)));
            nn = imhist(B(:,i));
            p  = nn / sum(nn);
            c  = cumsum(p);
            f  = uint8(MAX * k * exp(log(1 + (1 / k)) * c));
            E  = f(B(:,i) + 1);
            E  = NormalRange(E,Imin,Imax,1);
            if E(center) == 0
                Enhanced(i) = T(center);
            else
                Enhanced(i) = E(center);
            end
        end
    end

    [x,y,z]  = size(img);
    Enhanced = reshape(Enhanced,x,y,z);
end