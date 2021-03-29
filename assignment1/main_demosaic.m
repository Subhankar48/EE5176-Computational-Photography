%% Reading the data
clear;
addpath('data');
addpath('data/bil_filter');

load('RawImage1.mat');
load('bayer1.mat');
load('kodim19.mat');
load('kodim_cfa.mat');

%% Demosaicing the kodim19.png image
image_k = imread('kodim19.png');
image_k_lin = demosaic_self(raw, cfa, 'linear');
image_k_cub = demosaic_self(raw, cfa, 'cubic');
image_k_mat = demosaic(uint8(raw), 'rggb');

figure(1);
imshow(image_k);
title("kodim19.png image");
drawnow;
pause(1);

figure(2);
imshow(image_k_lin);
title("kodim19 image demosaicing bilinear interpolation");
drawnow;
pause(1);

figure(3);
imshow(image_k_cub);
title("kodim19 image demosaicing bicubic interpolation");
drawnow;
pause(1);

figure(4);
imshow(image_k_mat);
title("kodim19 image demosaicing using Matlab's demosaic");
drawnow;
pause(1);

%% Close all Plots 
close all;

%% Demosaicing RawImage1
image_r1 = demosaic(RawImage1, 'rggb');
image_r1_lin = demosaic_self(RawImage1, bayer1, 'linear');
image_r1_cub = demosaic_self(RawImage1, bayer1, 'cubic');

figure(1);
imshow(image_r1);
title("RawImage1.mat demosaic using Matlab's demosaic");
drawnow;
pause(1);

figure(2);
imshow(image_r1_lin);
title("RawImage1.mat demosaic using bilinear interpolation");
drawnow;
pause(1);

figure(3);
imshow(image_r1_cub);
title("RawImage1.mat demosaic using bicubic interpolation");
drawnow;