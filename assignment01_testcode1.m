function assignment01_testcode1()

    %Definition of the test function and its derivative
    test_func01 = @(x) (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
    test_derivative01 = @(x) 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;

    bisection_method(test_func01, -2, 5)

    % test_func(3)
    % 
    % test_func2 = @(x_in) 5*x_in;
    % 
    % test_func2
    % 
    % 
    % bisection_method(test_func01,1,7)
    % bisection_method(@test_func,6,8)
end

% Bisection Method
function x_out = bisection_method(fun, Ln, Rn)

    Mn= (Ln + Rn)/2;
    
    while fun(Ln) || fun(Rn) || fun(Mn) ~= 0
    
        if (fun(Ln)>0) && (0 > fun(Mn)) || (fun(Ln)<0) && (0 < fun(Mn))
            Rn=Mn;
            Mn = (Rn+Ln)/2;
        elseif (fun(Mn) > 0) && (0 > fun(Rn)) || (fun(Mn) < 0) && (f < fun(Rn))
            Ln = Mn;
            Mn = (Rn+Ln)/2;
        end
    end  

    if Ln == 0
        x_out = Ln;
    elseif Rn == 0
         x_out = Rn;
    else 
         x_out = Rn;
    end
end



function res = test_func(x)
    res = x^2;
end
