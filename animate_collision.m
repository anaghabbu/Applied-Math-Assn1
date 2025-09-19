% %Short example demonstrating how to create a MATLAB animation
% %In this case, a square moving along an elliptical path
% function animation_example()
% %Define the coordinates of the square vertices (in its own frame)
% square_coords_x = [-3,3,3,-3,-3];
% square_coords_y = [-3,-3,3,3,-3];
% %set up the plotting axis
% hold on; axis equal; axis square
% axis([0,40,0,40])
% %initialize the plot of the square
% square_plot = plot(0,0,'k');
% %iterate through time
% for t=0:.001:10
% %compute the position of the square's center (travelling along ellipse)
% position_x = 9*cos(t)+20;
% position_y = 7*sin(t)+20;
% %compute positions of square vertices (in world frame)
% x_plot = square_coords_x+position_x;
% y_plot = square_coords_y+position_y;
% 18
% %update the coordinates of the square plot
% set(square_plot,'xdata',x_plot,'ydata',y_plot);
% %update the actual plotting window
% drawnow;
% end
% end


function animate_collision(x_wall,y_ground, t_wall,t_ground, egg_params)

    %define location and filename where video will be stored
    %written a bit weird to make it fit when viewed in assignment
    mypath1 = 'C:\Users\ababu\OneDrive - Olin College of Engineering\Documents\Applied Math';
   % mypath2 = 'AppliedMathForEngineers\Modules\Strandbeest\graphics\';
    fname='egg_animation.avi';
    input_fname = [mypath1,fname];
    %create a videowriter, which will write frames to the animation file
    writerObj = VideoWriter(input_fname);
    %must call open before writing any frames
    open(writerObj);

    %set up the plotting axis
    fig1 = figure(1);
    title('Animation of Egg Collision of Parametric Curve Path')
    xlabel('Units of Distance')
    ylabel('Units of Distance')
    hold on; axis equal; axis square
    axis([0,40,0,40]);
    %initialize the plot of the square
    egg_plot = plot(0,0,'k');
    box_plot = plot(0,0,'r');
    ground_line = plot(0,0,'b');
    collision_point = plot(0,0,'g');
    set(collision_point, 'Marker', 'o')


    % if t_wall>t_ground
    %     collision_time = t_ground;
    % else
    %     collision_time = t_wall;
    % end

    s = linspace(0, 1, 50);
    collision_time = min(t_ground, t_wall);

    time_stamps = linspace(0, collision_time, 100);

    for i = 1:length(time_stamps)

        t = time_stamps(i);

        [x0,y0,theta] = egg_trajectory01(t);

        
        [V, ~] = egg_func(s,x0,y0,theta,egg_params);
        [x_range,y_range, v_left, v_right, v_top, v_bottom] = compute_bounding_box(x0,y0,theta,egg_params)

        %box = plot([x_range(1),x_range(2),x_range(2),x_range(1),x_range(1)] ...
            %,[y_range(2),y_range(2),y_range(1),y_range(1),y_range(2)]);
        x_box = [x_range(1),x_range(2),x_range(2),x_range(1),x_range(1)];
        y_box = [y_range(2),y_range(2),y_range(1),y_range(1),y_range(2)];
        floor = yline(y_ground);
        wall = xline(x_wall);
        

        set(box_plot, 'xdata',x_box,'ydata', y_box);
        set(egg_plot, 'xdata',V(1, :),'ydata',V(2, :));
        set(ground_line, 'xdata', floor ,'ydata', wall);

        drawnow;

        %capture a frame (what is currently plotted)
        current_frame = getframe(fig1);
        %write the frame to the video
        writeVideo(writerObj,current_frame);
        
        pause(.1)
    end

    [x0,y0,theta] = egg_trajectory01(collision_time);
    [V, ~] = egg_func(s,x0,y0,theta,egg_params);
    [x_range,y_range, v_left, v_right, v_top, v_bottom] = compute_bounding_box(x0,y0,theta,egg_params);

    
    if t_wall > t_ground
        set(collision_point, 'xdata', v_bottom(1) ,'ydata', v_bottom(2))
        drawnow;
        set(collision_point, 'xdata', v_bottom(1) ,'ydata', v_bottom(2))
        drawnow;
        set(collision_point, 'xdata', v_bottom(1) ,'ydata', v_bottom(2))
        drawnow;

        %capture a frame (what is currently plotted)
        current_frame = getframe(fig1);
        %write the frame to the video
        writeVideo(writerObj,current_frame);

    else
        set(collision_point, 'xdata', v_right(1) ,'ydata', v_right(2))
        drawnow;
        set(collision_point, 'xdata', v_right(1) ,'ydata', v_right(2))
        drawnow;
        set(collision_point, 'xdata', v_right(1) ,'ydata', v_right(2))
        drawnow;

        %capture a frame (what is currently plotted)
        current_frame = getframe(fig1);
        %write the frame to the video
        writeVideo(writerObj,current_frame);
    end

    %must call close after all frames are written
    close(writerObj);
    
end

%% add multiple frames for collision point so it shows up on video

% i have the timestamps
% now what do i do
% 
% i plot the egg at the time stamp
% i plot the bounding box at the time stamp
% 
% 
