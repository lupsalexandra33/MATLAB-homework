function [Theta] = normal_equation(FeatureMatrix, Y, tol, iter)

  [m, n] = size(FeatureMatrix);
  % adaugam o linie lui Theta pe care ulterior o evitam
  Theta = zeros(n+1, 1);
  % adaugam o coloana lui FeatureMatrix pentru a iesi la inmultirea cu Theta
  FeatureMatrix = cat(2, ones(m, 1), FeatureMatrix);
  A1 = FeatureMatrix' * FeatureMatrix;
  b1 = FeatureMatrix' * Y;
  % primul Theta va fi 0, motiv pentru care calculele le vom efectua de la al
  % doilea element
  A = A1(2:end, 2:end);
  b = b1(2:end);
  % mai jos este implementarea gradientului conjugat din suportul teoretic
  r = b - A * Theta(2:end);
  v = r;
  tol_squared = tol * tol;
  k = 1;
  while k <= iter && r' * r > tol_squared
      t_k = (r' * r) / (v' * A * v);
      Theta(2:end) = Theta(2:end) + t_k * v;
      r_2 = r - t_k * A * v;
      s_k = (r_2' * r_2) / (r' * r);
      v = r_2 + s_k * v;
      r = r_2;
      k = k + 1;
  end

end
