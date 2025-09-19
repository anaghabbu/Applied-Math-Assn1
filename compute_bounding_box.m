%Function that computes the bounding box of an oval
%INPUTS:
%theta: rotation of the oval. theta is a number from 0 to 2*pi.
%x0: horizontal offset of the oval
%y0: vertical offset of the oval
%egg_params: a struct describing the hyperparameters of the oval
%OUTPUTS:
%x_range: the x limits of the bounding box in the form [x_min,x_max]
%y_range: the y limits of the bounding box in the form [y_min,y_max]
function [x_range,y_range, v_left, v_right, v_top, v_bottom] = compute_bounding_box(x0,y0,theta,egg_params)

    x_range = [];
    y_range = [];
    egg_wrapperx2 = @(s_in) egg_wrapperx1(s_in,x0,y0,theta,egg_params);
    egg_wrappery2 = @(s_in) egg_wrappery1(s_in,x0,y0,theta,egg_params);
    
    s_range = linspace(0,1,100);
    for n = 1:length(s_range)
        gx_vals(n) = egg_wrapperx2(s_range(n));
    end
    % hold on
    % plot(s_range,gx_vals)
    % plot(s_range,0*s_range)
    
    

    xlist = [];
    ylist = [];

    for s_guess1 = linspace(0,1,5)
        [s_root, ~ ] = secant_solver(egg_wrapperx2, s_guess1, s_guess1 + .01, .001, .001, 50);
        [V, G] = egg_func(s_root,x0,y0,theta,egg_params);
        xlist(end+1) = V(1);
        ylist(end+1) = V(2);
    end

    [x_min, min_index] = min(xlist);
    [x_max, max_index] = max(xlist);
    v_left = [x_min; ylist(min_index)];
    v_right = [x_max; ylist(max_index)];

    xlist = [];
    ylist = [];

    for s_guess1 = linspace(0,1,5)
        
        [s_root, ~ ] = secant_solver(egg_wrappery2, s_guess1, s_guess1 + .01, .001, .001, 50);
        [V, G] = egg_func(s_root,x0,y0,theta,egg_params);
        xlist(end+1) = V(1);
        ylist(end+1) = V(2);
    end

    y_min = min(ylist);
    y_max = max(ylist);

    [y_min, min_index] = min(ylist);
    [y_max, max_index] = max(ylist);
    v_bottom = [xlist(min_index); y_min];
    v_top = [xlist(max_index); y_max];

    x_range = [x_min, x_max];
    y_range = [y_min, y_max];

    




end


function x_out = egg_wrapperx1(s,x0,y0,theta,egg_params)
    [~, G] = egg_func(s,x0,y0,theta,egg_params);
    x_out = G(1);
end

function x_out = egg_wrappery1(s,x0,y0,theta,egg_params)
    [~, G] = egg_func(s,x0,y0,theta,egg_params);
    x_out = G(2);
end



%when G(1) = zero - we get vertical bounding box lines


%G(1) describes change in tangent vector in x direction
%G(1) describes change in tangent vector in y direction

%put s back into egg func using same paramters to find root, itll give us V
%point that is position of left most or right most point