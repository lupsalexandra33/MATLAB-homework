function [X, y] = load_dataset(path)

  % cu functia load extrag continutul fisierului de tip .mat
  continut_mat = load(path);
  X = continut_mat.X;
  y = continut_mat.y;

end
