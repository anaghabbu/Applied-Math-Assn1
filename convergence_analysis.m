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
function convergence_analysis(solver_flag, fun, ...
x_guess0, guess_list1, guess_list2, filter_list1, filter_list2, filter_list3, filter_list4, filter_list5)
    
 max_iter = 200;
 f_tol = 1e-14;
 x_tol = 1e-14;
 xl = x_guess0(1);
 xr = x_guess0(2);

 test_func01(xl)
 test_func01(xr)


 xroot_reference = bisection(@test_func01, xl, xr, f_tol, x_tol, max_iter);

 num_trials = 100;

 x_guess_list = [];
 x_next_guess_list = [];

 
 iter_list = [];



 for n = 1:num_trials
   % xl = xroot_reference - 0.001 - 2*rand();
   % xr = xroot_reference + 0.001 + 2*rand();

   %my_recorder.clear_input_list();

   if solver_flag == 1
        xl = guess_list1(n);
        xr = guess_list2(n);
        [x_root, input_list] = bisection(@test_func01, xl, xr, f_tol, x_tol, max_iter);
   end
   if solver_flag == 2
        xl = guess_list1(n);
       [x_root, input_list] = newton_solver(@test_func01, xl, f_tol, x_tol, max_iter);
   end
   if solver_flag == 3
        xl = guess_list1(n);
        xr = guess_list2(n);
       [x_root, input_list] = secant_solver(@test_func01, xl, xr, f_tol, x_tol, max_iter);
   end
   if solver_flag == 4
       xl = guess_list1(n);
       my_recorder = input_recorder(); 
       f_record = my_recorder.generate_recorder_fun(@test_func01);
       x_root = fzero(f_record, xl);   %, xr, f_tol, x_tol, max_iter);
       input_list = my_recorder.get_input_list();
       my_recorder.clear_input_list();
   end


    x_current = input_list(1:end-1);
    x_next = input_list(2:end);

    
    iter = 1:(length(input_list())-1);

    x_guess_list = [x_guess_list, x_current];
    x_next_guess_list = [x_next_guess_list, x_next]; 
    iter_list = [iter_list, iter];


 end



 error_list = abs(x_guess_list-xroot_reference);
 error_next_list = abs(x_next_guess_list-xroot_reference);


  [x_regression, y_regression] = cleaning_data(error_list, error_next_list, iter_list, filter_list1, filter_list2, ...
                                filter_list3, filter_list4, filter_list5);


 disp(iter_list)


 [p, k] = generate_error_fit(x_regression,y_regression)

%plotting fit line

%generate x data on a logarithmic range
fit_line_x = 10.^ [-16:.01:1];
%compute the corresponding y values
fit_line_y = k*fit_line_x.^p;
%plot on a loglog plot.


    if solver_flag == 2

        [dfdx,d2fdx2] = approximate_derivative(@test_func, xroot_reference)

    end

 figure(1);
 loglog(error_list,error_next_list,'bo','markerfacecolor','b','markersize',2)
 hold on;
 loglog(x_regression,y_regression,'ro','markerfacecolor','r','markersize',2)
 loglog(fit_line_x,fit_line_y,'k-','linewidth',2)
 figure(2);
 semilogy(iter_list, error_list,'ro','markerfacecolor','r','markersize',2)

 %change axis or fit line region
 %label with legend

end