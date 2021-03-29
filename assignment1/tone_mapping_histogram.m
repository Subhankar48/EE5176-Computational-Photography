function image_new = tone_mapping_histogram(image)
%     convert to HSV 
    HSV = rgb2hsv(image);
%     equalize only the V(intensity) component
%     this gives much better results than equalising each 
%     color component independently
    Heq = histeq(HSV(:,:,3));
    HSV_mod = HSV;
    HSV_mod(:,:,3) = Heq;

    image_new = hsv2rgb(HSV_mod);
end