function blurred_image = motion_blur_linear(image, x_vel, y_vel, code_seq)
    exposure_time = length(code_seq);
    [x, y, ~] = size(image);
    % Assumption is images are RGB
    x_prime = x+y_vel*(exposure_time-1);
    y_prime = y+x_vel*(exposure_time-1);
    image = im2double(image);
    blurred_image = zeros(x_prime, y_prime, 3);
    for t = 0:(exposure_time-1)
        x_move = t*y_vel;
        y_move = t*x_vel;
        blurred_image(1+x_move:x+x_move, 1+y_move:y+y_move, :) = blurred_image(1+x_move:x+x_move, 1+y_move:y+y_move, :)+ image*code_seq(1+t);
    end
    blurred_image = uint8(255*blurred_image./sum(code_seq));
end