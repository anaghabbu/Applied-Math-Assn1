function xroot = newton_solver(fun, xn, f_tol, x_tol, max_iter)

    dx = 2 *x_tol;
    count = 0;
        
    [fval, dfdx] = fun(xn);

    %Fn = fun(xn);

        %guesses = xn
        while count<max_iter && abs(fval) > f_tol && abs(dx) > x_tol
            
            dx = -fval/dfdx;
            count = count + 1;

            xn = xn - fval/dfdx;
            % guesses (end + 1) = xn
        end 
        
        xroot = xn;
        %disp(['Newton root ', 'x = ', num2str(xn), ', f(x) = ', num2str(fun(xn))]);
    end