clc
clearvars
close all
load('SegmentX.mat')
img = X;
u = 52.5;

    nn = imhist(img);
    p = nn / sum(nn);
    c = cumsum(p);
    for i = 1:255
        a = sum(c(1:i));
        b = sum(c(i+1:end));
        a = (a + 1) .^ 1;
        b = (b + 1) .^ 1;
        s1(i) = a .* tan(log10(log10(a) + 0));
        s2(i) = b .* tan(log10(log10(b) + 0));
    end
    F = (s1 + s2);
    f = F(2:end);
    d = f(24)-f(23);
    for i = 2:23
        f(i) = f(23) - log10((23-i) * d + 1);
    end
    threshold = find(f==max(f(:)));
    x = 0:255;
    yyaxis left
    plot(x,p/max(p),LineWidth=1,Color=[0 0 0.8]);hold;
    plot(x,c,LineWidth=1,Color=[0 0.8 0]);
    ylabel('Normalized Pixels')
    yyaxis right
    x = 1:254;
    plot(x+21.5,f,LineWidth=1,Color=[0.8 0 0])
    ylabel('$TL^2$-Values',Interpreter='latex')
    xlim([0 255])
    legend('$PDF$','$CDF$','$TL^2$',Interpreter='latex');
    title('Relationship Between Histogram and $TL^2$ function',Interpreter='latex');