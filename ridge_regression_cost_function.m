function [Error] = ridge_regression_cost_function(Theta, Y, FeatureMatrix, lambda)

  [m, n] = size(FeatureMatrix);
  % nu luam primul element din Theta in calcul
  Theta2 = Theta(2:end);
  val_prezisa = FeatureMatrix * Theta2;
  diferenta = val_prezisa - Y;
  % inmultim fiecare termen din vector
  putere = diferenta.^2;
  % adunam toti termenii vectorului
  suma_putere = sum(putere);
  suma_regularizare = 0;
  for i = 1:n
      % calculam regularizarea
      suma_regularizare = suma_regularizare + Theta2(i) * Theta2(i);
  end
  % calculam eroarea
  Error = suma_putere / (2 * m) + lambda * suma_regularizare;

end
