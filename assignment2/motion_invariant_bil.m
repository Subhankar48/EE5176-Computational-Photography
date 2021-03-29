function final_image =  motion_invariant_bil(foreground, background, vel, camera_motion)
    ceils = ceil(camera_motion);
    max_motion = max(ceils);
    [x, y, ~] = size(foreground);
    final_image = zeros(x, y+max_motion, 3);
    n_frames = length(camera_motion);
    [x1,y1,~] = size(final_image);
    [xx, yy] = meshgrid(1:x1, 1:y1);
    all_x = xx(:);
    all_y = yy(:);
    I = sub2ind(size(final_image(:, :, 1)), all_x, all_y);    
    padded_foreground = zero_pad(foreground);
    padded_background = zero_pad(background);
    h = waitbar(0, "Performing motion invariant photography...");
    for i = 1:n_frames
        camera_coords = camera_motion(i);
        car_y_coords = all_y - camera_coords + (i-1)*vel;
        background_y_coords = all_y - camera_coords;
        car_r = zeros(size(final_image(:, :, 1)));
        background_r = zeros(size(final_image(:, :, 1)));
        background_g = zeros(size(background_r));
        background_b = zeros(size(background_r));
        car_vals = bilinear_interpolate(padded_foreground(:, :, 1), all_x, car_y_coords);
        car_r(I) = car_vals;
        background_r_vals = bilinear_interpolate(padded_background(:, :, 1), all_x, background_y_coords);
        background_g_vals = bilinear_interpolate(padded_background(:, :, 2), all_x, background_y_coords);
        background_b_vals = bilinear_interpolate(padded_background(:, :, 3), all_x, background_y_coords);
        background_r(I) = background_r_vals;
        background_g(I) = background_g_vals;
        background_b(I) = background_b_vals;
        background_canvas = cat(3, background_r, background_g, background_b);
        addition = cast(merging(car_r, background_canvas), 'like', final_image);
        final_image = final_image+addition;
        waitbar(i/n_frames);
    end
    close(h);
    final_image = uint8(final_image/n_frames);
end