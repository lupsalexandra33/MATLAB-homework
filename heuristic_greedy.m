function [path] = heuristic_greedy (start_position, probabilities, Adj)

	% punem in path ca prim element pozitia de start
	path(1) = start_position;
	[m, n] = size(Adj);
	visited = zeros(1, m-2);
	visited(start_position) = 1;
	while ~isempty(path)
		% extragem ultimul element din path
		position = path(end);
		if Adj(position, m-1) == 1
			path = [path, m-1];
			return;
		end
		maxi = -1;
		vecin_close = -1;
		Adj = sparse(Adj);
		% cautam vecinii
		vecini = find(Adj(position, :) == 1);
		n = length(vecini);
		for j = 1:n
			if probabilities(vecini(j)) > maxi && visited(vecini(j)) == 0
				maxi = probabilities(vecini(j));
			end
			if probabilities(vecini(j)) == maxi
				% extragem vecinul cu cea mai mare probabilitate de WIN
				% (adica cel mai apropiat de o stare de WIN)
				vecin_close = vecini(j);
			end
		end
		if vecin_close == -1
			% daca nu exista niciun vecin, ultimul element se scoate din
			% path pentru ca plecand de la el nu ajungem nicaieri
			path(end) = [];
		end
		visited(vecin_close) = 1;
		% se adauga vecinul in path
		path = [path, vecin_close];
	end
	path = sparse(path);

end
