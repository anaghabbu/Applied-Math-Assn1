function findingTheRoots()
    % Define test function and derivative
    test_func01 = @(x) (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
    test_derivative01 = @(x) 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;

    % Call methods
    bisection(test_func01, test_derivative01, -10, 5, 0.01)
    newton_method(test_func01, test_derivative01, 5, 0.01)
    secant_method(test_func01, -10, 5, 0.01, 100)

    function bisection(fun, derfun, Ln, Rn, tol)
      Mn = (Ln + Rn) / 2;    
        while abs(fun(Mn)) > tol
            if (fun(Ln)*fun(Mn))<0
                Rn = Mn ;
            else 
                Ln = Mn;
            end
        Mn = (Ln + Rn) / 2;
        end
        disp(['Bisection root ', 'Mn = ', num2str(Mn), ' f(x) = ', num2str(fun(Mn))]);
   
    end

    function newton_method(fun, derfun, xn, tol)

        while abs(fun(xn)) > tol 
            xn = xn - fun(xn)/derfun(xn);
        end 
        

        disp(['Newton root ', 'xn = ', num2str(xn), ', f(x) = ', num2str(fun(xn))]);
    end

    function secant_method(fun, x0, x1, tol, iter)
        
        for i = 1:iter
            x2 = x1 - fun(x1)*(x1 - x0)/(fun(x1) - fun(x0));
        

            if abs(fun(x2)) < tol
                disp(['Secant root x2 = ', num2str(x2), num2str(i)]);
                return
            end
        x0 = x1;
        x1 = x2;
        end

    end

end





