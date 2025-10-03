function [X_train, y_train, X_test, y_test] = split_dataset(X, y, percent)

  [m, n] = size(X);
  % permutam random liniile
  P = randperm(m);
  % aplicam aceeasi permutare pentru matrice si vectorul coloana
  X = X(P, :);
  y = y(P, :);
  % calculam fractiunea care se duce in setul de train, respectiv in cel de test
  m_train = percent * m;
  m_test = m - m_train;
  % initializam setul de training
  X_train = zeros(m_train, n);
  y_train = zeros(m_train, 1);
  % adaugam primele m_train teste in setul de train
  for i = 1:m_train
      X_train(i, :) = X(i, :);
      y_train(i) = y(i);
  end
  % initializam setul de test
  X_test = zeros(m_test, n);
  y_test = zeros(m_test, 1);
  % adaugam restul testelor in setul de test
  for i = m_train + 1:m
      X_test(i - m_train, :) = X(i, :);
      y_test(i - m_train) = y(i);
  end

end