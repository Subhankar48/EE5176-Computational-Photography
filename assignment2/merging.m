function final_image = merging(foreground, background)
    % assume foreground is the red channel only
    k = background;
    r1 = k(:, :, 1);
    g1 = k(:, :, 2);
    b1 = k(:, :, 3);
    r1(foreground>0) = 0;
    g1(foreground>0) = 0;
    b1(foreground>0) = 0;
    final_image = cat(3, r1, g1, b1);
    final_image(foreground>0) = foreground(foreground>0);
end