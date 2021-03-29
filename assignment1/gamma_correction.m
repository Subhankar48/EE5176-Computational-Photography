function image_new = gamma_correction(image, gamma)
%     convert to HSV 
    HSV = rgb2hsv(image);
%     correct only the V(intensity) component
%     this gives much better results than correcting each 
%     color component independently
    gamma_corrected = HSV(:,:,3).^gamma;
    HSV_mod = HSV;
    HSV_mod(:,:,3) = gamma_corrected;
    
    image_new = hsv2rgb(HSV_mod);
end