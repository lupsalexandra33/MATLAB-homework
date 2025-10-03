function [decoded_path] = decode_path (path, lines, cols)

	n = length(path);
	% creem o matrice de lungimea path-ului excluzand starea de WIN
	% avand doua coloane ce exprima pozitia starii in matrice
	decoded_path = zeros(n-1, 2);
	% creem matricea
	if lines == cols
		matrix = reshape(1:lines*cols, lines, cols)';
	else
		for i = 1:lines
			for j = 1:cols
				matrix(i, j) = (i-1)*cols + j;
			end
		end
	end
	k = n;
	o = 1;
	while k ~= 1
		% cautam elementul o din path in matrice
		[p, q] = find(matrix == path(o));
		decoded_path(o, 1) = p;
		decoded_path(o, 2) = q;
		o = o + 1;
		k = k - 1;
	end

end
