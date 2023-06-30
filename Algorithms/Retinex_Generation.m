function [newimg] = Retinex_Generation(img)
    [x,y,z] = size(img);
    if z == 3
        img = rgb2gray(img);
    end
    mask1 = [0	0	0	0	0;
             0	0	0	0	0;
             0	0	1	0	1;
             0	0	0	1	1;
             0	0	0	0	1];
%     mask2 = [0	0	0	0	0;
%              0	0	0	0	0;
%              0	0	1	0	0;
%              0	1	0	0	0;
%              1	1	1	0	0];
%     mask3 = [0	0	1	1	1;
%              0	0	0	1	0;
%              0	0	1	0	0;
%              0	0	0	0	0;
%              0	0	0	0	0];
%     mask4 = [1	1	1	0	0;
%              0	1	0	0	0;
%              0	0	1	0	0;
%              0	0	0	0	0;
%              0	0	0	0	0];
    X = double(img);
    X = padarray(X,[4 4],'both','symmetric');
    X1 = X(1:end-4,1:end-4);
%     X2 = X(1:end-4,5:end);
%     X3 = X(5:end,1:end-4);
%     X4 = X(5:end,5:end);
    Retinex1  = PMR_Retinex(X1,mask1,x,y);
%     Retinex2  = PMR_Retinex(X2,mask2,x,y);
%     Retinex3  = PMR_Retinex(X3,mask3,x,y);
%     Retinex4  = PMR_Retinex(X4,mask4,x,y);
%     newimg    = cat(3,Retinex1,Retinex2,Retinex3,Retinex4);
%     newimg    = (Retinex1 .* Retinex2 .* Retinex3 .* Retinex4) .^ (1/4);
    newimg = Retinex1;
end