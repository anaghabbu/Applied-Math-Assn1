
function rootFinding()
 
 %my_recorder = input_recorder();
 %record_fun = my_recorder.generate_recorder_fun(@test_func01);

 max_iter = 200;
 f_tol = 1e-14;
 x_tol = 1e-14;
 xl = -5;
 xr = 20;

 test_func01(xl)
 test_func01(xr)


 xroot_reference = bisection(@test_func01, xl, xr, f_tol, x_tol, max_iter);

 num_trials = 100;

 x_guess_list = [];
 x_next_guess_list = [];

 
 iter_list = [];



 for n = 1:num_trials

   xl = xroot_reference - 0.001 - 2*rand();
   xr = xroot_reference + 0.001 + 2*rand();

   %my_recorder.clear_input_list();
    
   [x_root, input_list] = bisection(@test_func01, xl, xr, f_tol, x_tol, max_iter);


    x_current = input_list(1:end-1);
    x_next = input_list(2:end);

    
    iter = 1:(length(input_list())-1);

    x_guess_list = [x_guess_list, x_current];
    x_next_guess_list = [x_next_guess_list, x_next]; 
    iter_list = [iter_list, iter];


 end

 error_list = abs(x_guess_list-xroot_reference);
 error_next_list = abs(x_next_guess_list-xroot_reference);

 figure(1);
 loglog(error_list,error_next_list,'ro','markerfacecolor','r','markersize',2);

 figure(2);
 semilogy(iter_list, error_list,'ro','markerfacecolor','r','markersize',2);

 [x_regression, y_regression] = cleaning_data(error_list, error_next_list, iter_list);

 [p, k] = generate_error_fit(x_regression,y_regression);

%plotting fit line

%generate x data on a logarithmic range
fit_line_x = 10.^ [-16:.01:1];
%compute the corresponding y values
fit_line_y = k*fit_line_x.^p;
%plot on a loglog plot.
loglog(fit_line_x,fit_line_y,'k-','linewidth',2)

% only for newton: [dfdx,d2fdx2] = approximate_derivative(@test_func, xroot_reference)


end



