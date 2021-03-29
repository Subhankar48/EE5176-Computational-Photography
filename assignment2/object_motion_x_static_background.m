function final_image = object_motion_x_static_background(foreground, background, vel, exposure_time)
    channel = foreground(:, :, 1);
    [x_coords, y_coords] = find(channel>0);
    final_image = zeros(size(foreground));
    
    I = sub2ind(size(channel), x_coords, y_coords);
    object = cast(channel(I), 'like', final_image);
    h = waitbar(0, "Performing motion blur...");
    for t = 0:exposure_time-1
        blurred_channel = zeros(size(channel));
        
        P = sub2ind(size(blurred_channel), x_coords, y_coords+t*vel);
        blurred_channel(P) = object;
        
        addition = cast(merging(blurred_channel, background), 'like', final_image);
        final_image = final_image+addition;
        waitbar((t+1)/exposure_time);
    end
    final_image = uint8(final_image/exposure_time);
    close(h);
end