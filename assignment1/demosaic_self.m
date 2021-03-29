function image = demosaic_self(raw_image_mat, cfa_mat, method)
    raw_image_mat = double(raw_image_mat);
    [y, x] = size(cfa_mat);
    y = 1:y; 
    x = 1:x;
    [xx, yy] = meshgrid(x,y);

    xr = xx(cfa_mat==1);
    yr = yy(cfa_mat==1);
    vr = raw_image_mat(cfa_mat==1);
    vq_r = griddata(xr, yr, vr, xx, yy, method);

    xg = xx(cfa_mat==2);
    yg = yy(cfa_mat==2);
    vg = raw_image_mat(cfa_mat==2);
    vq_g = griddata(xg, yg, vg, xx, yy, method);

    xb = xx(cfa_mat==3);
    yb = yy(cfa_mat==3);
    vb = raw_image_mat(cfa_mat==3);
    vq_b = griddata(xb, yb, vb, xx, yy, method);

    image = zeros([size(cfa_mat), 3]);
    image(:, :, 1) = vq_r;
    image(:, :, 2) = vq_g;
    image(:, :, 3) = vq_b;
    
    image = uint8(image);
    
end
