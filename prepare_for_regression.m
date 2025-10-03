function [FeatureMatrix] = prepare_for_regression(InitialMatrix)

  [m, n] = size(InitialMatrix);
  % creez matricea numerica in care vom pune toate valorile
  FeatureMatrix = zeros(m, n+1);
  for i = 1:m
    % initializam o variabila care sa ne spuna la ce coloana ne aflam
      a = 0;
      for j = 1:n
          if strcmp(InitialMatrix{i, j}, 'yes') == 1
              FeatureMatrix(i, j) = 1;
          elseif strcmp(InitialMatrix{i, j}, 'no') == 1
              FeatureMatrix(i, j) = 0;
          elseif strcmp(InitialMatrix{i, j}, 'unfurnished') == 1
              FeatureMatrix(i, j) = 0;
              FeatureMatrix(i, j+1) = 1;
              if j == n-1
                  a = 1;
              end
          elseif strcmp(InitialMatrix{i, j}, 'furnished') == 1
              FeatureMatrix(i, j) = 0;
              FeatureMatrix(i, j+1) = 0;
              if j == n-1
                  a = 1;
              end
          elseif strcmp(InitialMatrix{i, j}, 'semi-furnished') == 1
              FeatureMatrix(i, j) = 1;
              FeatureMatrix(i, j+1) = 0;
              if j == n-1
                  a = 1;
              end
          else
              if a == 0
                  FeatureMatrix(i, j) = str2double(InitialMatrix{i, j});
              else
                  FeatureMatrix(i, j+1) = str2double(InitialMatrix{i, n});
              end
          end
      end
  end

end
