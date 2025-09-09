function xroot = secant_solver(fun, x0, x1, f_tol, x_tol, max_iter)

        count = 0;
        f0 = fun(x0);
        f1 = fun(x1);

        dx = 2*x_tol;
        
        while count < max_iter && abs(f1) > f_tol && abs(dx) > x_tol

            count = count + 1;

            x2 = x1 - f1*(x1 - x0)/(f1 - f0);

            dx = x2 - x1;

            f2 = fun(x2);

            % guesses(end + 1) = x2

            x0 = x1;
            f0 = f1;

            x1 = x2;
            f1 = f2;
        end

        xroot = x1;
  
    end