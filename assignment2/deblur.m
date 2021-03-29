function deblurred_image = deblur(blurred_image, A)
    A_inv = A/(A'*A);
    deblurred_r = cast(blurred_image(:, :, 1), 'like', A_inv)*A_inv;
    deblurred_g = cast(blurred_image(:, :, 2), 'like', A_inv)*A_inv;
    deblurred_b = cast(blurred_image(:, :, 3), 'like', A_inv)*A_inv;
    deblurred_image = uint8(cat(3, deblurred_r, deblurred_g, deblurred_b));
end