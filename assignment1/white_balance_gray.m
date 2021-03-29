function image_new = white_balance_gray(image)
    
    [x, y, ~] = size(image);
    
    r_channel = image(:, :, 1);
    g_channel = image(:, :, 2);
    b_channel = image(:, :, 3);

    R = mean(mean(r_channel));
    G = mean(mean(g_channel));
    B = mean(mean(b_channel));

    sr = (R+G+B)/(3*R);
    sg = (R+G+B)/(3*G);
    sb = (R+G+B)/(3*B);

    image_new = zeros(x, y, 3);
    image_new(:,:,1) = sr.*r_channel;
    image_new(:,:,2) = sg.*g_channel;
    image_new(:,:,3) = sb.*b_channel;
    image_new = uint8(image_new);

end