 % Define test function and derivative
    test_func01 = @(x) (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
    test_derivative01 = @(x) 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;



% Hardcoded bisection
Ln = -5;
Rn = 8;
tol = 0.01;

  Mn = (Ln + Rn) / 2; 
      if (test_func01(Ln)*test_func01(Mn))<0
        while abs(test_func01(Mn)) > tol
            if (test_func01(Ln)*test_func01(Mn))<0
                Rn = Mn ;
            else 
                Ln = Mn;
            end
        Mn = (Ln + Rn) / 2;
        end
      else
          disp("bisection method: no zero crossing")
          return
      end
    
        disp(['Bisection root ', 'x = ', num2str(Mn), ' f(x) = ', num2str(test_func01(Mn))]);  

% Hardcoded newton

xn= 5;

        while abs(test_func01(xn)) > tol 
            xn = xn - test_func01(xn)/test_derivative01(xn);
        end 

        disp(['Newton root ', 'x = ', num2str(xn), ', f(x) = ', num2str(test_func01(xn))]);


% Hardcoded secant
iter1 = 50;
x1 = 5;
x0 = -10;
x2 = [];


    for i = 1:iter1
            x2 = x1 - test_func01(x1)*(x1 - x0)/(test_func01(x1) - test_func01(x0));
        

            if abs(test_func01(x2)) < tol
                disp(['Secant root x = ', num2str(x2), num2str(i)]);
                return
            end
        x0 = x1;
        x1 = x2;
    end

    
%Plotting

y = 0;
syms x f(x);
figure('Visible','on');
fplot(test_func01, [-10 35]); hold on;
fplot(y, [-10 35]); hold on;
plot(Mn, test_func01(Mn), 'x-')
plot(xn, test_func01(xn), 'x-')
plot(x2, test_func01(x2), 'x-')

xlabel('x');
ylabel('y');
title('Plot of Sine and Cosine Function');
grid on;