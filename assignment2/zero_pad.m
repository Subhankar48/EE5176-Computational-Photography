function padded_image = zero_pad(image)
    [x, y, ~] = size(image);
    padded_image = zeros(x+2, y+2, 3);
    padded_image(2:x+1, 2:y+1, :) = image;
end