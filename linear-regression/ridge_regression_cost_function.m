function [Error] = ridge_regression_cost_function(Theta, Y, FeatureMatrix, lambda)
    [m, n] = size(FeatureMatrix);
    Theta = Theta(2:end); % Se ignora coeficientul theta0 (care este considerat 0)
    Preziceri = FeatureMatrix * Theta; %Calculam valorile prezise
    Erori = Preziceri - Y; % Calculam erorile dintre predictii si valorile reale
    s1 = 0; % Suma erorilor patratice
    s2 = 0; % Suma patratelor coeficientilor (pentru regularizare L2)

    for i = 1:m
        s1 = s1 + Erori(i)^2; % Se aduna patratul fiecarei erori
    end

    for i = 1:n
        s2 = s2 + Theta(i)^2; % Se aduna patratul fiecarui coeficient 
    end
 
    L2 = lambda * s2; % Calculam termenul de regularizare L2
    Error = (1 / (2*m)) * s1 + L2; % Functia de cost regularizata
end
