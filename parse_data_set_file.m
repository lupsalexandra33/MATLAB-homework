function [Y, InitialMatrix] = parse_data_set_file(file_path)

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
  % creez o matrice A de tip cell cu o coloana in plus
  A = cell(m, n+1);
  InitialMatrix = cell(m, n);
  Y = zeros(m, 1);
  i = 1;
  while i <= m
      linie_matrice = fgetl(fid);
      % convertesc fiecare linie in vector cu regexp
      split_linie_matrice = regexp(linie_matrice, ' ', 'split');
      % umplu matricea linie cu linie
      A(i, :) = split_linie_matrice;
      i = i + 1;
  end
  % convertesc prima coloana intr-un vector de numere de tip double cu str2double
  Y = str2double(A(:, 1));
  InitialMatrix = A(:, 2:end);
  fclose(fid);

end
