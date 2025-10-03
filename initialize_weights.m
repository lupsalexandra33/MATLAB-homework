function [matrix] = initialize_weights(L_prev, L_next)

  L = L_prev + L_next;
  % calculam valoarea lui epsilon
  epsilon = sqrt(6) / sqrt(L);
  % calculam matricea cu valori intre -epsilon si epsilon
  matrix = (-epsilon) + 2 * epsilon .* rand(L_next, L_prev + 1);

end
