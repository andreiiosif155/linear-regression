function [Theta] = gradient_descent(FeatureMatrix, Y, n, m, alpha, iter)
    Theta = zeros(n+1, 1);  % Initializam vectorul coeficientilor (inclusiv theta0)
    FeatureMatrix=[ones(m,1), FeatureMatrix]; % Adaugam coloana de 1 pentru termenul theta0
    for i = 1:iter
        Preziceri = FeatureMatrix * Theta; % Calculam predictiile
        Erori = Preziceri - Y; % Calculam erorile

        % Calculam gradientul pentru toti coeficientii
        gradient = (1 / m) * (FeatureMatrix' * Erori); 
        % Actualizam doar coeficientii theta 1 ... n
        Theta(2:end) = Theta(2:end) - alpha * gradient(2:end); 
    end
end