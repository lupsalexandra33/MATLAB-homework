function [Error] = linear_regression_cost_function(Theta, Y, FeatureMatrix)

  [m, n] = size(FeatureMatrix);
  % nu luam primul element din Theta in calcul
  Theta2 = Theta(2:end);
  val_prezisa = FeatureMatrix * Theta2;
  diferenta = val_prezisa - Y;
  % ridicam la patrat fiecare termen din vector
  putere = diferenta.^2;
  % adunam toti termenii vectorului
  suma_putere = sum(putere);
  % calculul erorii
  Error = suma_putere / (2*m);

end
