function [x_regression, y_regression] = cleaning_data(error_list, error_next_list, iter_list)

    x_regression = [];
    y_regression = [];

    for n = 1:length(iter_list)
        if error_list(n)>1e-15 && error_list(n)<1e-2 && ...
        error_next_list(n)>1e-14 && error_next_list(n)<1e-2 && ...
        iter_list(n) > 2
    
        x_regression(end + 1) = error_list(n);
        y_regression(end + 1) = error_next_list(n);

        end
    end
end