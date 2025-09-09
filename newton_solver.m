function xroot = newton_solver(fun, xn, f_tol, x_tol, max_iter)

    count = 0;

    Fn = fun(xn);

        %guesses = xn
        while abs(Fn) > f_tol 

            count = count + 1;

            xn = xn - fun(xn)/derfun(xn);
            % guesses (end + 1) = xn
        end 
        
        xroot = xn;
        %disp(['Newton root ', 'x = ', num2str(xn), ', f(x) = ', num2str(fun(xn))]);
    end