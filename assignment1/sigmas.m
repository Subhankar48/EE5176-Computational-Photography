function [sigma_r, sigma_g, sigma_b] = sigmas(image)
    sigma_r = 1.95*std2(image(:, :, 1));
    sigma_g = 1.95*std2(image(:, :, 2));
    sigma_b = 1.95*std2(image(:, :, 3));
end