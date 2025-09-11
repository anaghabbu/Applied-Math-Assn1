function [x_regression, y_regression] = cleaning_data(error_list, error_next_list, iter_list, ...
         filter_list1,filter_list2, filter_list3, filter_list4, filter_list5 )

    x_regression = [];
    y_regression = [];

    for n = 1:length(iter_list)
        if error_list(n)>filter_list1 && error_list(n)<filter_list2 && ...
        error_next_list(n)> filter_list3 && error_next_list(n)<filter_list4 && ...
        iter_list(n) > filter_list5
     

    
            x_regression(end + 1) = error_list(n);
            y_regression(end + 1) = error_next_list(n);

        end
    end
end