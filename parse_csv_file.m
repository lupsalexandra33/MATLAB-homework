function [Y, InitialMatrix] = parse_csv_file(file_path)

  fid = fopen(file_path, 'r');
  if fid == -1
      % afisez un mesaj de eroare in cazul in care deschiderea fisierului nu a avut loc cu succes
      disp('Eroare de deschidere a fisierului!');
  end
  % citesc prima linie separat pentru ca nu am nevoie de ea
  linie = fgetl(fid);
  % astfel cu textscan citesc si retin in variabila text tot restul fisierului
  text = textscan(fid, '%s', 'Delimiter', '\n');
  text = text{1};
  % retin numarul de linii al textului
  m = length(text);
  Y = zeros(m, 1);
  A = {};
  InitialMatrix = {};
  i = 1;
  while i <= m
      % convertesc fiecare linie in vector cu regexp
      split_linie_matrice = regexp(text{i}, ',', 'split');
      % umplu matricea linie cu linie
      A(i, :) = split_linie_matrice;
      i = i + 1;
  end
  % convertesc prima coloana intr-un vector de numere de tip double cu str2double
  Y = str2double(A(:, 1));
  InitialMatrix = A(:, 2:end);
  fclose(fid);

end