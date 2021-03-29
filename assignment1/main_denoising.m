%% Reading the data
clear;
addpath('data');
addpath('data/bil_filter');

load('RawImage1.mat');
load('bayer1.mat');
load("RawImage2.mat");
load('bayer2.mat');
load('RawImage3.mat');
load("bayer3.mat");

%% Demosaic the images
img1 = demosaic_self(RawImage1, bayer1, "cubic");
img2 = demosaic_self(RawImage2, bayer2, "cubic");
img3 = demosaic_self(RawImage3, bayer3, "cubic");

%% White Balance and tone mapping image 1
x_coord = 435;
y_coord = 2000;
img1_neutral = white_balance_coords(img1, x_coord, y_coord);
img1_neutral_gamma_09 = gamma_correction(img1_neutral, 0.9);
img1 = img1_neutral_gamma_09;

%% White Balance and tone mapping image 2
x_coord = 280;
y_coord = 1165;
img2_highlight = white_balance_coords(img2, x_coord, y_coord);
img2_highlight_gamma_09 = gamma_correction(img2_highlight, 0.9);
img2 = img2_highlight_gamma_09;

%% White Balance and tone mapping image 3
x_coord = 565;
y_coord = 1550;
img3_neutral = white_balance_coords(img3, x_coord, y_coord);
img3_neutral_gamma_09 = gamma_correction(img3_neutral, 0.9);
img3 = img3_neutral_gamma_09;

%% Convert to double
img1 = im2double(img1);
img2 = im2double(img2);
img3 = im2double(img3);

%% Estimate sigmas
sigma_s = 2.5;
window_size = 11;
w = floor(window_size/2);

patch1 = img1(75:135, 690:750, :);
patch2 = img2(705:765, 924:984, :);
patch3 = img3(1060:1120, 750:810, :);

[sigma1_r, sigma1_g, sigma1_b] = sigmas(patch1);
[sigma2_r, sigma2_g, sigma2_b] = sigmas(patch2);
[sigma3_r, sigma3_g, sigma3_b] = sigmas(patch3);

%% Filter RawImage1
filtered_img1 = zeros(size(img1));
filtered_img1(:, :, 1) = bfilter2(img1(:, :, 1), w, [sigma_s, sigma1_r]);
filtered_img1(:, :, 2) = bfilter2(img1(:, :, 2), w, [sigma_s, sigma1_g]);
filtered_img1(:, :, 3) = bfilter2(img1(:, :, 3), w, [sigma_s, sigma1_b]);

%% Filter RawImage2
filtered_img2 = zeros(size(img2));
filtered_img2(:, :, 1) = bfilter2(img2(:, :, 1), w, [sigma_s, sigma2_r]);
filtered_img2(:, :, 2) = bfilter2(img2(:, :, 2), w, [sigma_s, sigma2_g]);
filtered_img2(:, :, 3) = bfilter2(img2(:, :, 3), w, [sigma_s, sigma2_b]);

%% Filter RawImage3
filtered_img3 = zeros(size(img3));
filtered_img3(:, :, 1) = bfilter2(img3(:, :, 1), w, [sigma_s, sigma3_r]);
filtered_img3(:, :, 2) = bfilter2(img3(:, :, 2), w, [sigma_s, sigma3_g]);
filtered_img3(:, :, 3) = bfilter2(img3(:, :, 3), w, [sigma_s, sigma3_b]);

%% RawImage1 results
figure(1);
imshow(img1);
title("RawImage1 neutral object gamma 0.9");
drawnow;
pause(1);

figure(2);
imshow(filtered_img1);
title("RawImage1 neutral object gamma 0.9 filtered");
drawnow;
pause(1);

%% Close all Plots
close all;

%% RawImage2 results
figure(1);
imshow(img2);
title("RawImage2 specular highlight gamma 0.9");
drawnow;
pause(1);

figure(2);
imshow(filtered_img2);
title("RawImage2 specular highlight gamma 0.9 filtered");
drawnow;
pause(1);

%% Close all Plots
close all;

%% RawImage3 results
figure(1);
imshow(img3);
title("RawImage3 neutral object gamma 0.9");
drawnow;
pause(1);

figure(2);
imshow(filtered_img3);
title("RawImage3 neutral object gamma 0.9 filtered");
drawnow;
pause(1);

%% Close all Plots
close all;