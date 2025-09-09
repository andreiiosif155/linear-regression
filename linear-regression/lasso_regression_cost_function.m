function [Error] = lasso_regression_cost_function(Theta, Y, FeatureMatrix, lambda)
    [m, n] = size(FeatureMatrix);
    Theta = Theta(2:end); % Se ignora coeficientul theta0 (care este considerat 0)
    Preziceri = FeatureMatrix * Theta; % Calculam valorile prezise
    Erori = Preziceri - Y; % Calculam erorile dintre predictii si valorile reale
    s1 = 0; % Suma erorilor patratice
    s2 = 0; % Suma valorilor absolute ale coeficientilor (pentru regularizare L1)

    for i = 1:m
        s1 = s1 + Erori(i)^2; % Calculam suma patratelor erorilor
    end

    for i = 1:n
        s2 = s2 + abs(Theta(i)); % Adunam valorile absolute ale coeficientilor
    end

    L1 = lambda * s2; % Calculam termenul de regularizare L1
    Error = (1 / m) * s1 + L1; % Calculam functia de cost finala regularizata Lasso
end
