function [Error] = linear_regression_cost_function(Theta, Y, FeatureMatrix)
    [m, n] = size(FeatureMatrix);
    Theta = Theta(2:end); % Eliminam theta0 (considerat 0)
    Preziceri = FeatureMatrix * Theta; % Calculam valorile prezise
    Erori = Preziceri - Y; % Calculam diferentele fata de iesirile reale
    s = 0; % Initializam suma erorilor patratice

    for i = 1:m
        s = s + Erori(i)^2; % Adunam eroarea patratica pentru fiecare exemplu
    end

    Error = (1 / (2 * m)) * s; % Functia de cost finala
end
