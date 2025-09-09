function [Y, InitialMatrix] = parse_csv_file(file_path)
    fid = fopen(file_path, 'r');
    fgetl(fid); % Ignoram primul rand (headerele)
    InitialMatrix = {}; % Initializam matricea de celule pentru predictori
    Y = []; % Initializam vectorul iesirilor

    i = 1;

    while ~feof(fid)% Cat timp nu am ajuns la finalul fisierului
        linie = fgetl(fid); % Citim o linie din fisier
        linie = strrep(linie, ',', ' '); % Inlocuim separatorii CSV cu spatii
        parti = strsplit(linie); % Impartim linia in bucati
        l = length(parti);

        Y(i, 1) = str2double(parti{1}); % Prima valoare este iesirea

        for j = 2:l
            string = parti{j};
            numar = str2double(string);

            % Daca conversia a esuat, pastram string-ul; altfel, pastram numarul
            if isnan(numar)
                InitialMatrix{i, j - 1} = string;
            else
                InitialMatrix{i, j - 1} = numar;
            end

        end

        i = i + 1;
    end

    fclose(fid)
end
