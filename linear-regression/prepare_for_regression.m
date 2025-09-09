function [FeatureMatrix] = prepare_for_regression(InitialMatrix)
    % Determinam dimensiunile matricei initiale
    [m, n] = size(InitialMatrix);

    % Vector pentru a retine coloanele ce contin date non-numerice
    coloane = [];
    FeatureMatrix = InitialMatrix;

    i = 1;

    % Parcurgem matricea pentru a identifica coloanele cu stringuri
    while i <= n
        % Verificam daca elementul curent nu este numeric
        if ~isnumeric(FeatureMatrix{1, i})
            % Adaugam indexul coloanei in vectorul de coloane non-numerice
            coloane(end + 1) = i;

            % Verificam daca coloana specifica tipul de furnished
            if ~isempty(strfind(FeatureMatrix{1, i}, 'furnished'))
                % Adaugam o noua coloana si le mutam pe restul
                % la dreapta pentru a ii face loc
                for k = 1:m

                    for j = n:-1:i + 1
                        FeatureMatrix{k, j + 1} = FeatureMatrix{k, j};
                    end

                    FeatureMatrix{k, i + 1} = [];
                end

                n = n + 1; % Actualizam numarul de coloane
                i = i + 1; % Sarim peste coloana nou adaugata
            end

        end

        i = i + 1;
    end

    % Numarul de coloane ce necesita transformare
    l = length(coloane);

    % Transformam string-urile in valori numerice
    for i = 1:m

        for j = 1:l
            k = coloane(j); % Indexul coloanei de transformat
            val = FeatureMatrix{i, k}; % Valoarea curenta

            % Convertim fiecare tip de string la valoarea numerica corespunzatoare
            if strcmp(val, 'yes')
                FeatureMatrix{i, k} = 1;
            elseif strcmp(val, 'no')
                FeatureMatrix{i, k} = 0;
            elseif strcmp(val, 'semi-furnished')
                FeatureMatrix{i, k} = 1;
                FeatureMatrix{i, k + 1} = 0;
            elseif strcmp(val, 'unfurnished')
                FeatureMatrix{i, k} = 0;
                FeatureMatrix{i, k + 1} = 1;
            elseif strcmp(val, 'furnished')
                FeatureMatrix{i, k} = 0;
                FeatureMatrix{i, k + 1} = 0;
            end

        end

    end

    % Convertim matricea de celule intr-o matrice numerica
    FeatureMatrix = cell2mat(FeatureMatrix);
end
