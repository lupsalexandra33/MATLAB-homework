function [G, c] = get_Jacobi_parameters (Link)

	[line, col] = size(Link);
	% eliminam starea de WIN si de LOSE din linii si coloane
	n1 = line - 2;
	n2 = col - 2;
	% G acopera toate starile de la 1 la m*n
	G = Link(1:n1, 1:n2);
	G = sparse(G);
	% c reprezinta vectorul starii de WIN
	c = Link(1:n1, n2 + 1);
	c = sparse(c);

end
