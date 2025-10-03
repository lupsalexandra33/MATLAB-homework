function [J, grad] = cost_function(params, X, y, lambda, ...
                   input_layer_size, hidden_layer_size, ...
                   output_layer_size)

  [m, n] = size(X);
  % cu reshape atribui cat din params apartine lui Theta1 si cat lui Theta2 iar
  % apoi transform fiecare theta intr-o matrice de dimensiune corespunzatoare
  Theta1 = reshape(params(1:hidden_layer_size * (input_layer_size + 1)), [hidden_layer_size, (input_layer_size + 1)]);
  Theta2 = reshape(params(hidden_layer_size * (input_layer_size + 1) + 1:end), [output_layer_size, (hidden_layer_size + 1)]);
  % tranform y intr-o matrice binara
  y_matrix = eye(output_layer_size)(y, :);
  % initializez cele doua matrici pentru calculul gradientului
  triunghi1 = zeros(hidden_layer_size, (input_layer_size + 1));
  triunghi2 = zeros(output_layer_size, (hidden_layer_size + 1));
  % in variabila p vom calcula costul
  p = 0;
  % am adaugat o coloana de 1 matricii X
  a1 = [ones(m, 1), X]'; % am transpus astfel incat produsul cu Theta1 sa fie compatibil la calculul lui z2
  z2 = Theta1 * a1;
  a2_1 = sigmoid(z2);
  % am adaugat linia de 1 matricii
  a2 = [ones(1, m); a2_1];
  z3 = Theta2 * a2;
  a3 = sigmoid(z3);
  % am calculat costul folosind de doua ori sum pentru a calcula eficient
  p = sum(sum(-y_matrix' .* log(a3) - (1 - y_matrix') .* log(1 - a3)));
  % calculam eroarea gama3 si gama2, dar si gradientii
  gama3 = a3 - y_matrix';
  triunghi2 = gama3 * (a2');
  % la gama2 evitam prima coloana a lui Theta
  gama2 = (Theta2(:, 2:end)' * gama3) .* sigmoid(z2) .* (1 - sigmoid(z2));
  triunghi1 = gama2 * (a1');
  % calculez valoarea finala pentru cei doi gradienti
  gradienti1 = triunghi1 / m;
  gradienti2 = triunghi2 / m;
  % am impartit costul la m
  p = p / m;
  suma1 = 0;
  suma2 = 0;
  % in suma1 si suma2 calculez cele doua regularizari pentru a obtine varianta finala a functiei de cost
  % adaug regularizarea si pentru cei doi gradienti
  suma1 = sum(sum(Theta1(:, 2:end) .* Theta1(:, 2:end)));
  gradienti1(:, 2:end) = gradienti1(:, 2:end) + (lambda / m) * Theta1(:, 2:end);
  suma2 = sum(sum(Theta2(:, 2:end) .* Theta2(:, 2:end)));
  gradienti2(:, 2:end) = gradienti2(:, 2:end) + (lambda / m) * Theta2(:, 2:end);
  suma = suma1 + suma2;
  % calculez regularizarea cu cele doua sume adunate
  regularizare = (lambda / (2 * m)) * suma;
  % rezultatul final al costului
  J = p + regularizare;
  % concatenez pe verticala cei doi vectori coloana ai gradientilor
  grad = cat(1, gradienti1(:), gradienti2(:));

end
