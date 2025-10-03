function [Labyrinth] = parse_labyrinth(file_path)

   fid = fopen(file_path, 'r');
    if fid == -1
        % afisez un mesaj de eroare in cazul in care deschiderea fisierului nu a avut loc cu succes
        disp('Eroare de deschidere a fisierului!');
    end
    % citesc prima linie pentru a obtine parametrii matricei
    linie = fgetl(fid);
    dimensiuni = str2num(linie);
    m = dimensiuni(1);
    n = dimensiuni(2);
    % creez o matrice de zero-uri
    Labyrinth = zeros(m, n);
    i = 1;
    while i <= m
        linie_matrice = fgetl(fid);
        % convertesc fiecare linie in vector de numere cu str2num
        dimensiuni_matrice = str2num(linie_matrice);
        % umplu matricea linie cu linie
        Labyrinth(i, :) = dimensiuni_matrice;
        i = i + 1;
    end
    fclose(fid);

end
