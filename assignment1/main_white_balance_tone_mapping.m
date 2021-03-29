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

%% Processing RawImage1
img1_gray = white_balance_gray(img1);

x_coord = 814;
y_coord = 830;
img1_highlight = white_balance_coords(img1, x_coord, y_coord);

x_coord = 435;
y_coord = 2000;
img1_neutral = white_balance_coords(img1, x_coord, y_coord);

img1_gray_hist = tone_mapping_histogram(img1_gray);
img1_gray_gamma_05 = gamma_correction(img1_gray, 0.5);
img1_gray_gamma_07 = gamma_correction(img1_gray, 0.7);
img1_gray_gamma_09 = gamma_correction(img1_gray, 0.9);

img1_highlight_hist = tone_mapping_histogram(img1_highlight);
img1_highlight_gamma_05 = gamma_correction(img1_highlight, 0.5);
img1_highlight_gamma_07 = gamma_correction(img1_highlight, 0.7);
img1_highlight_gamma_09 = gamma_correction(img1_highlight, 0.9);

img1_neutral_hist = tone_mapping_histogram(img1_neutral);
img1_neutral_gamma_05 = gamma_correction(img1_neutral, 0.5);
img1_neutral_gamma_07 = gamma_correction(img1_neutral, 0.7);
img1_neutral_gamma_09 = gamma_correction(img1_neutral, 0.9);

%% Processing RawImage2
img2_gray = white_balance_gray(img2);

x_coord = 280;
y_coord = 1165;
img2_highlight = white_balance_coords(img2, x_coord, y_coord);

x_coord = 715;
y_coord = 445;
img2_neutral = white_balance_coords(img2, x_coord, y_coord);

img2_gray_hist = tone_mapping_histogram(img2_gray);
img2_gray_gamma_05 = gamma_correction(img2_gray, 0.5);
img2_gray_gamma_07 = gamma_correction(img2_gray, 0.7);
img2_gray_gamma_09 = gamma_correction(img2_gray, 0.9);

img2_highlight_hist = tone_mapping_histogram(img2_highlight);
img2_highlight_gamma_05 = gamma_correction(img2_highlight, 0.5);
img2_highlight_gamma_07 = gamma_correction(img2_highlight, 0.7);
img2_highlight_gamma_09 = gamma_correction(img2_highlight, 0.9);

img2_neutral_hist = tone_mapping_histogram(img2_neutral);
img2_neutral_gamma_05 = gamma_correction(img2_neutral, 0.5);
img2_neutral_gamma_07 = gamma_correction(img2_neutral, 0.7);
img2_neutral_gamma_09 = gamma_correction(img2_neutral, 0.9);

%% Processing RawImage3
img3_gray = white_balance_gray(img3);

x_coord = 675;
y_coord = 175;
img3_highlight = white_balance_coords(img3, x_coord, y_coord);

x_coord = 565;
y_coord = 1550;
img3_neutral = white_balance_coords(img3, x_coord, y_coord);

img3_gray_hist = tone_mapping_histogram(img3_gray);
img3_gray_gamma_05 = gamma_correction(img3_gray, 0.5);
img3_gray_gamma_07 = gamma_correction(img3_gray, 0.7);
img3_gray_gamma_09 = gamma_correction(img3_gray, 0.9);

img3_highlight_hist = tone_mapping_histogram(img3_highlight);
img3_highlight_gamma_05 = gamma_correction(img3_highlight, 0.5);
img3_highlight_gamma_07 = gamma_correction(img3_highlight, 0.7);
img3_highlight_gamma_09 = gamma_correction(img3_highlight, 0.9);

img3_neutral_hist = tone_mapping_histogram(img3_neutral);
img3_neutral_gamma_05 = gamma_correction(img3_neutral, 0.5);
img3_neutral_gamma_07 = gamma_correction(img3_neutral, 0.7);
img3_neutral_gamma_09 = gamma_correction(img3_neutral, 0.9);



%% Plots for RawImage1
figure(1);
imshow(img1);
title("RawImage1");
drawnow;
pause(1);

figure(2);
imshow(img1_gray);
title("RawImage1 - gray pixel");
pause(1);

figure(3);
imshow(img1_highlight);
title("RawImage1 - specular highlights");
drawnow;
pause(1);

figure(4);
imshow(img1_neutral);
title("RawImage1 - neutral object");
drawnow;
pause(1);

figure(5);
imshow(img1_gray_hist);
title("RawImage1 - gray pixel - histogram");
pause(1);

figure(6);
imshow(img1_gray_gamma_05);
title("RawImage1 - gray pixel - gamma 0.5");
pause(1);

figure(7);
imshow(img1_gray_gamma_07);
title("RawImage1 - gray pixel - gamma 0.7");
pause(1);

figure(8);
imshow(img1_gray_gamma_09);
title("RawImage1 - gray pixel - gamma 0.9");
pause(1);

figure(9);
imshow(img1_neutral_hist);
title("RawImage1 - neutral object - histogram");
pause(1);

figure(10);
imshow(img1_neutral_gamma_05);
title("RawImage1 - neutral object - gamma 0.5");
pause(1);

figure(11);
imshow(img1_neutral_gamma_07);
title("RawImage1 - neutral object - gamma 0.7");
pause(1);

figure(12);
imshow(img1_neutral_gamma_09);
title("RawImage1 - neutral object - gamma 0.9");
pause(1);

figure(13);
imshow(img1_highlight_hist);
title("RawImage1 - specular highlight - histogram");
pause(1);

figure(14);
imshow(img1_highlight_gamma_05);
title("RawImage1 - specular highlight - gamma 0.5");
pause(1);

figure(15);
imshow(img1_highlight_gamma_07);
title("RawImage1 - specular highlight - gamma 0.7");
pause(1);

figure(16);
imshow(img1_highlight_gamma_09);
title("RawImage1 - specular highlight - gamma 0.9");
pause(1);

%% Close Plots
close all;

%% Plots for RawImage2
figure(1);
imshow(img2);
title("RawImage2");
drawnow;
pause(1);

figure(2);
imshow(img2_gray);
title("RawImage2 - gray pixel");
pause(1);

figure(3);
imshow(img2_highlight);
title("RawImage2 - specular highlights");
drawnow;
pause(1);

figure(4);
imshow(img2_neutral);
title("RawImage2 - neutral object");
drawnow;
pause(1);

figure(5);
imshow(img2_gray_hist);
title("RawImage2 - gray pixel - histogram");
pause(1);

figure(6);
imshow(img2_gray_gamma_05);
title("RawImage2 - gray pixel - gamma 0.5");
pause(1);

figure(7);
imshow(img2_gray_gamma_07);
title("RawImage2 - gray pixel - gamma 0.7");
pause(1);

figure(8);
imshow(img2_gray_gamma_09);
title("RawImage2 - gray pixel - gamma 0.9");
pause(1);

figure(9);
imshow(img2_neutral_hist);
title("RawImage2 - neutral object - histogram");
pause(1);

figure(10);
imshow(img2_neutral_gamma_05);
title("RawImage2 - neutral object - gamma 0.5");
pause(1);

figure(11);
imshow(img2_neutral_gamma_07);
title("RawImage2 - neutral object - gamma 0.7");
pause(1);

figure(12);
imshow(img2_neutral_gamma_09);
title("RawImage2 - neutral object - gamma 0.9");
pause(1);

figure(13);
imshow(img2_highlight_hist);
title("RawImage2 - specular highlight - histogram");
pause(1);

figure(14);
imshow(img2_highlight_gamma_05);
title("RawImage2 - specular highlight - gamma 0.5");
pause(1);

figure(15);
imshow(img2_highlight_gamma_07);
title("RawImage2 - specular highlight - gamma 0.7");
pause(1);

figure(16);
imshow(img2_highlight_gamma_09);
title("RawImage2 - specular highlight - gamma 0.9");
pause(1);

%% Close Plots
close all;

%% Plots for RawImage3
figure(1);
imshow(img3);
title("RawImage3");
drawnow;
pause(1);

figure(2);
imshow(img3_gray);
title("RawImage3 - gray pixel");
pause(1);

figure(3);
imshow(img3_highlight);
title("RawImage3 - specular highlights");
drawnow;
pause(1);

figure(4);
imshow(img3_neutral);
title("RawImage3 - neutral object");
drawnow;
pause(1);

figure(5);
imshow(img3_gray_hist);
title("RawImage3 - gray pixel - histogram");
pause(1);

figure(6);
imshow(img3_gray_gamma_05);
title("RawImage3 - gray pixel - gamma 0.5");
pause(1);

figure(7);
imshow(img3_gray_gamma_07);
title("RawImage3 - gray pixel - gamma 0.7");
pause(1);

figure(8);
imshow(img3_gray_gamma_09);
title("RawImage3 - gray pixel - gamma 0.9");
pause(1);

figure(9);
imshow(img3_neutral_hist);
title("RawImage3 - neutral object - histogram");
pause(1);

figure(10);
imshow(img3_neutral_gamma_05);
title("RawImage3 - neutral object - gamma 0.5");
pause(1);

figure(11);
imshow(img3_neutral_gamma_07);
title("RawImage3 - neutral object - gamma 0.7");
pause(1);

figure(12);
imshow(img3_neutral_gamma_09);
title("RawImage3 - neutral object - gamma 0.9");
pause(1);

figure(13);
imshow(img3_highlight_hist);
title("RawImage3 - specular highlight - histogram");
pause(1);

figure(14);
imshow(img3_highlight_gamma_05);
title("RawImage3 - specular highlight - gamma 0.5");
pause(1);

figure(15);
imshow(img3_highlight_gamma_07);
title("RawImage3 - specular highlight - gamma 0.7");
pause(1);

figure(16);
imshow(img3_highlight_gamma_09);
title("RawImage3 - specular highlight - gamma 0.9");
pause(1);

%% Close Plots
close all;
