function [Y, InitialMatrix] = parse_data_set_file(file_path)
    fid = fopen(file_path, 'r');

    % Citim dimensiunile 
    m = fscanf(fid, '%d', 1);
    n = fscanf(fid, '%d', 1);

    % Initializam matricea de tip cell pentru a stoca date mixte
    InitialMatrix = cell(m, n);
    Y = zeros(m, 1);

    % Eliminam caracterul newline ramas ca rest al primei linii
    fgets(fid);

    for i = 1:m

        % Prima valoare din fiecare rând este valoarea de ieșire
        Y(i) = fscanf(fid, '%lf', 1);

        % Citim fiecare caracteristica ramasa pe rand
        for j = 1:n

            % Citim ca sir de caractere caracteristica
            string = fscanf(fid, '%s', 1);

            % Incercam sa il convertim in numar
            numar = str2double(string);

            % Daca conversia esueaza, il stocam ca sir, altfel il stocam ca numar
            if isnan(numar)
                InitialMatrix{i, j} = string;
            else
                InitialMatrix{i, j} = numar;
            end

        end

        % Eliminam caracterul newline ramas
        fgets(fid);
    end

    fclose(fid);
end
