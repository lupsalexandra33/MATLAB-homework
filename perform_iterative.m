function [x, err, steps] = perform_iterative (G, c, x0, tol, max_steps)

    err = tol + 1;
	steps = 0;
	x = x0;
    while err > tol && steps < max_steps
			% facem o copie a lui x
			prev_x = x;
			% calculam noul x
			x = G * prev_x + c;
			% eroarea este data de norma diferentei starii curente si anterioare
			err = norm(x - prev_x);
			steps = steps + 1;
    end

end
