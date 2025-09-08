%Example template for analysis function
%INPUTS:
%solver_flag: an integer from 1-4 indicating which solver to use
% 1->Bisection 2-> Newton 3->Secant 4->fzero
%fun: the mathematical function that we are using the
% solver to compute the root of
%x_guess0: the initial guess used to compute x_root
%guess_list1: a list of initial guesses for each trial
%guess_list2: a second list of initial guesses for each trial
% if guess_list2 is not needed, then set to zero in input
%filter_list: a list of constants used to filter the collected data

function convergence_analysis(solver_flag, func, ...
x_guess0 (Ln), guess_list1 (Rn), guess_list2, filter_list)

% Bisection

x_root = 0.717447;

% array of initial guess
ig1 = linspace(-10, 0, 50) 
ig2 = linspace(1, 35, 50)
input = [];

% Loop through the array using indices
for i = 1:50
      Ln = ig1(i)
      Rn = ig2(i)
      Mn = (Ln + Rn) / 2; 

      if (fun(Ln)*fun(Mn))<0
        while abs(fun(Mn)) > tol
            if (fun(Ln)*fun(Mn))<0
                x_input(end + 1) = Rn;
                Rn = Mn ;
            else 
                x_input(end + 1) = Ln;
                Ln = Mn;
            end
        Mn = (Ln + Rn) / 2;
        arrayLength = arrayLength + 1;
        end
      else
          disp("bisection method: no zero crossing")
          return
      end
    
        disp(['Bisection root ', 'x = ', num2str(Mn), ' f(x) = ', num2str(fun(Mn))]);


    if solver_flag ~=tt 1 && f(a)*f(b) > 0
        error('Function does not change sign on the interval.')
    end
end

%end