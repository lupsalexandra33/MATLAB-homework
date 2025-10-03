function [Theta] = gradient_descent(FeatureMatrix, Y, n, m, alpha, iter)

  % adaugam cate o coloana atat pentru Theta, cat si pentru FeatureMatrix
  Theta = zeros(n+1, 1);
  FeatureMatrix = cat(2, ones(m, 1), FeatureMatrix);
  for i = 1:iter
      calcul_1 = FeatureMatrix * Theta - Y;
      % incepem calculul de la 2 pentru a nu lua in considerare primul element
      for j = 2:n+1
          calcul_2 = 0;
          for k = 1:m
              calcul_2 = calcul_2 + calcul_1(k) * FeatureMatrix(k, j);
          end
          calcul_3 = calcul_2 / m;
          Theta(j) = Theta(j) - alpha * calcul_3;
      end
  end

end
