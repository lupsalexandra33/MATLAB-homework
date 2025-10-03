function [Link] = get_link_matrix (Labyrinth)

    [m, n] = size(Labyrinth);
    % construim matricea cu valori de la 1 la m*n in functie de relatia dintre parametrii
    if m == n
        matrix = reshape(1:m*n, m, n)';
    else
        for i = 1:m
            for j = 1:n
                matrix(i, j) = (i - 1) * n + j;
            end
        end
    end
    Adj = [];
    % stocam eficient matricea prin functia sparse
    A = sparse(Adj);
    % mai cream 2 matrice ce vor stoca starea de WIN, respectiv cea de LOSE
    win_matrix = [];
    lose_matrix = [];
    for i = 1:m
        linie = Labyrinth(i, :);
        for j = 1:n
            element_matrice = linie(j);
            % transformam fiecare numar al matricii in binar
            element_binar_matrice = dec2bin(element_matrice, 4);
            b0 = str2num(element_binar_matrice(4));
            b1 = str2num(element_binar_matrice(3));
            b2 = str2num(element_binar_matrice(2));
            b3 = str2num(element_binar_matrice(1));
            % nord
            if (b3 == 0)
                if (i == 1)
                    Adj(matrix(i, j), m * n + 1) = 1;
                else
                    Adj(matrix(i, j), matrix(i - 1, j)) = 1;
                end
            end
            % vest
            if (b0 == 0)
                if (j == 1)
                    Adj(matrix(i, j), m * n + 2) = 1;
                else
                    Adj(matrix(i, j), matrix(i, j - 1)) = 1;
                end
            end
            % est
            if (b1 == 0)
                if (j == n)
                    Adj(matrix(i, j), m * n + 2) = 1;
                else
                    Adj(matrix(i, j), matrix(i, j + 1)) = 1;
                end
            end
            % sud
            if (b2 == 0)
                if (i == m)
                    Adj(matrix(i, j), m * n + 1) = 1;
                else
                    Adj(matrix(i, j), matrix(i + 1, j)) = 1;
                end
            end
        end
    end
    % la final, adaugam si cele doua conexiuni intre starile de WIN, respectiv de LOSE
    Adj(m * n + 1, m * n + 1) = 1;
    Adj(m * n + 2, m * n + 2) = 1;
    [l1, l2] = size(Adj);
    % stocam eficient matricea prin functia sparse
    Link = sparse(l1, l2);
    for i = 1:l1
        % calculam numarul de elemente nenule de pe fiecare linie
        line = sum(Adj(i, :));
        for j = 1:l2
            if Adj(i, j) == 1
                % matricea de legatura se afla prin impartirea fiecarui element
                % al matricii de adiacenta la numarul de elemente de pe linia respectiva
                Link(i, j) = Adj(i, j) / line;
            end
        end
    end

end
