function interpolated_values = bilinear_interpolate(zero_padded_image, x_vals, y_vals)
    [dx, dy] = size(zero_padded_image);
    % get the shape of the original image
    dx = dx-2; 
    dy = dy-2;
    % +1 as we are taking coordinates with respect to a zero padded image
    x = x_vals+1;
    y = y_vals+1;
    
    x_prime = floor(x);
    y_prime = floor(y);
    a = x-x_prime;
    b = y-y_prime;
    
    t1 = x_prime>=1;
    t2 = x_prime<= dx+1;
    t3 = y_prime>=1;
    t4 = y_prime<=dy+1;
    
    t = t1 .* t2 .* t3 .* t4;
    t = t==1;
    a = a(t);
    b = b(t);
    
    interpolated_values = zeros(size(x_vals));
    I1 = sub2ind(size(zero_padded_image), x_prime(t), y_prime(t));
    I2 = sub2ind(size(zero_padded_image), x_prime(t), y_prime(t)+1);
    I3 = sub2ind(size(zero_padded_image), x_prime(t)+1, y_prime(t));
    I4 = sub2ind(size(zero_padded_image), x_prime(t)+1, y_prime(t)+1);
    
    interpolated_values(t) = (1-a).*(1-b).*zero_padded_image(I1) ...
        + (1-a).*b.*zero_padded_image(I2) ...
        + a.*(1-b).*zero_padded_image(I3) ...
        + a.*b.*zero_padded_image(I4);
end