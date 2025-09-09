function [xroot, input_list] = bisection(fun, Ln, Rn, f_tol, x_tol, max_iter)
  
count = 0;   

guess_list = [];

Fl = fun(Ln);
%Fr = fun(Rn);

Mn = (Ln + Rn) / 2; 
Fm = fun(Mn);

      if (Fl*Fm)<0
      
        while count < max_iter && abs(Fm) > f_tol && abs(Rn-Ln) > x_tol
            
            count = count + 1;
            
            if (Fl*fun(Mn))<0

                guess_list = [guess_list, Rn];
                Rn = Mn ;
            else 
                
                guess_list = [guess_list, Ln];
                
                Ln = Mn;
            end
        Mn = (Ln + Rn) / 2;
        end

        guess_list = [guess_list, Mn];

      else
          disp("bisection method: no zero crossing")
          return
      end
      xroot = Mn;
      input_list = guess_list;
    
        %disp(['Bisection root ', 'x = ', num2str(Mn), ' f(x) = ', num2str(fun(Mn))]);
   
    end