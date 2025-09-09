
function rootFinding()
 max_iter = 200;
 f_tol = 1e-15;
 x_tol = 1e-15;
 xl = 5;
 xr = 20;

 xroot_reference = bisection(@testfunc01, xl, xr, f_tol, x_tol, max_iter)

 num_trials = 100;

 x_guess_list = [];
 x_next_guess_list = [];
 iter_list = [];

 for n = 1:max_iter

   xl = xroot_reference - 0.001 - 2*rand();
   xr = xroot_reference + 0.001 + 2*rand();


   [x_root, input_list] = bisection(@testfunc01, xl, xr, f_tol, x_tol, max_iter)


    x_current = input_list(1:end-1);
    x_next = input_list(2:end);
    iter = 1:input_list();

    x_guess_list = [x_guess_list, x_current]
    x_next_guess_list = [x_next_guess_list, x_next] 
    iter_list = [iter_list, iter]


 end


end





function [fval, dfdx] = test_func01(x)  
    fval = (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
    dfdx = 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;
end
    