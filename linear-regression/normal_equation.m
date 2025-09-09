function [Theta] = normal_equation(FeatureMatrix, Y, tol, iter)
    A = FeatureMatrix' * FeatureMatrix;
    b = FeatureMatrix' * Y;
    n = size(FeatureMatrix, 2);
    Theta = zeros(n + 1, 1);
    x = zeros(n, 1);
    r = b - A * x; 
    v = r;
    tolsquared = tol * tol;
    k = 1;

    while k <= iter && r' * r > tolsquared
        t = (r' * r) / (v' * A * v);
        x = x + t * v;
        r2 = r - t * A * v;
        s = (r2' * r2) / (r' * r);
        v = r2 + s * v;
        r = r2;
        k = k + 1;
    end

    Theta = [0; x];
end
