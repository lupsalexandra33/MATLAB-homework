function [classes] = predict_classes(X, weights, ...
                  input_layer_size, hidden_layer_size, ...
                  output_layer_size)

  [m, n] = size(X);
  % creez un vector coloana de clase
  classes = zeros(m, 1);
  % cu reshape atribui cat din weights apartine lui Theta1 si cat lui Theta2 iar
  % apoi transform fiecare theta intr-o matrice de dimensiune corespunzatoare
  Theta1 = reshape(weights(1:hidden_layer_size * (input_layer_size + 1)), [hidden_layer_size, (input_layer_size + 1)]);
  Theta2 = reshape(weights(hidden_layer_size * (input_layer_size + 1) + 1:end), [output_layer_size, (hidden_layer_size + 1)]);
      % am adaugat o coloana de 1 matricii X
      a1 = [ones(m, 1), X]'; % am transpus astfel incat produsul cu Theta1 sa fie compatibil la calculul lui z2
      z2 = Theta1 * a1;
      a2_1 = sigmoid(z2);
      % am adaugat linia de 1 matricii
      a2 = [ones(1, m); a2_1];
      z3 = Theta2 * a2;
      a3 = sigmoid(z3);
  for i = 1:m
      % maxi va stoca valoarea maxima a lui a3
      % maxi_k va stoca pozitia la care se afla valoarea maxima a lui a3
      maxi = -1;
      maxi_k = -1;
      for k = 1:output_layer_size
          if a3(k,i) > maxi
              maxi = a3(k,i);
              maxi_k = k;
          end
      end
      % classes primeste pozitia la care se afla maximul
      classes(i) = maxi_k;
  end

end
