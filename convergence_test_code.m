function convergence_test_code()

    solver_flag = 1;
    fun = @test_func01;
    x_guess0 = linspace(-5, .5, 100);
    guess_list1 = linspace(1, 6.5, 100);
    guess_list2 = linspace(1, 6.5, 100);
    filter_list1 = 1e-15;
    filter_list2 = 1e-2;
    filter_list3 = 1e-14;
    filter_list4 = 1e-2;
    filter_list5 = 2;

    convergence_analysis(solver_flag, fun, ...
    x_guess0, guess_list1, filter_list1, ...
    filter_list2, filter_list3, filter_list4, filter_list5)

end