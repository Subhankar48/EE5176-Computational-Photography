%% Reading images and noise 
clear;
fish = imread('fish.png');
load('gaussNoise.mat');
background = imread('background.png');
redcar = imread('redcar.png');
[x, y, ~] = size(fish);

%% Parameters for conventional camera
exposure_time = 52;
code_seq = ones(1, exposure_time);
x_vel = 1;
y_vel = 0;

%% Blur and add noise
blurred_fish = motion_blur_linear(fish, x_vel, y_vel, code_seq);
blurred_fish_noisy = cast(blurred_fish, 'like', gaussNoise) + gaussNoise;
blurred_fish_noisy = uint8(blurred_fish_noisy);

%% Display results
imshow(blurred_fish_noisy);
title("Blurred Image");
pause(1.5);

%% Clear plots
close all;

%% Blur Matrix
A = blur_matrix(code_seq, y);
blur_r = (A*cast(fish(:, :, 1)', 'like', A))';
blur_g = (A*cast(fish(:, :, 2)', 'like', A))';
blur_b = (A*cast(fish(:, :, 3)', 'like', A))';
blur_final = uint8(cat(3, blur_r, blur_g, blur_b));

%% Display results
figure(1);
% Remove the normalization from A before displaying to see it clearly
imshow(A*sum(code_seq));
title("Blur matrix for motion blur with conventional camera");
pause(1.5);
figure(2);
imshow(blur_final);
title("Image blurred after matrix multiplication with blur matrix");
pause(1.5);

%% Clear plots
close all;

%% Debluring
deblurred = deblur(blurred_fish_noisy, A);

%% Display results
figure(1)
imshow(deblurred);
title("Image deblurred using pseudo inverse of blur matrix");
pause(1.5);

%% Clear plots
close all;

%% RMSE calculation
root_mse = sqrt(mean((deblurred-fish).^2, 'all'));
fprintf('The RMSE betwen the clear and deblurred images is: %f\n', root_mse);

%% End of Question 1

%% Flutter Shutter parameters
load('codeSeq.mat');
x_vel = 1;
y_vel = 0;

%% Blur and add noise
blurred_fish_flutter = motion_blur_linear(fish, x_vel, y_vel, codeSeq);
blurred_fish_flutter_noisy = cast(blurred_fish_flutter, 'like', gaussNoise) + gaussNoise;
blurred_fish_flutter_noisy = uint8(blurred_fish_flutter_noisy);

%% Display results
imshow(blurred_fish_flutter_noisy);
title("Blurred image flutter shutter");
pause(1.5);

%% Close plots
close all;

%% Blur matrix flutter shutter
A_flutter = blur_matrix(codeSeq, y);
imshow(A_flutter*sum(codeSeq));
% Remove the normalization from A before displaying to see it clearly
title("Blur matrix for flutter shutter");
pause(1.5);

%% Close plots
close all;

%% Deblurring
deblurred_f = deblur(blurred_fish_flutter_noisy, A_flutter);

%% Display results
figure(1)
imshow(deblurred_f);
title("Image deblurred using pseudo inverse of blur matrix for flutter shutter");
pause(1.5);

%% Clear plots
close all;

%% RMSE calculation
root_mse = sqrt(mean((deblurred_f-fish).^2, 'all'));
to_print = sprintf('The RMSE betwen the clear and deblurred images is: %f\n', root_mse);
disp(to_print);

%% Deblurring non noisy images
deblurred_f_n = deblur(blurred_fish_flutter, A_flutter);
deblurred_n = deblur(blurred_fish, A);

%% Display results
figure(1)
imshow(deblurred_n);
title("Deblurring conventional photo when noise is not added");
pause(1.5);

figure(2)
imshow(deblurred_f_n);
title("Deblurring flutter shutter photo when noise is not added");
pause(1.5);

%% Clear plots
close all;

%% Frequency response
% remove the normalization factors else it is not visible
response_conventional = A(:, 1)*sum(code_seq);
response_flutter = A_flutter(:, 1)*sum(codeSeq);
y = fft(response_conventional);
y1 = fft(response_flutter);
n = ceil(length(y)/2);
m = 20*log(abs(y));
m1 = 20*log(abs(y1));
plot(m(1:n));
hold on;
plot(m1(1:n));
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
title("Frequency responses");
legend('conventional', 'flutter shutter');

%% Clear plots
close all;

%% End of Question 2

%% Motion invariant photography parameters
exposure_time = 52;
car_r_channel = redcar(:, :, 1);
load('CameraT.mat');
[x_car, y_car, ~] = size(redcar);

%% For different object velocities with static camera
x_vels = [1 2 3];
motion_blurred_image1 = object_motion_x_static_background(redcar, background, x_vels(1), exposure_time);
motion_blurred_image2 = object_motion_x_static_background(redcar, background, x_vels(2), exposure_time);
motion_blurred_image3 = object_motion_x_static_background(redcar, background, x_vels(3), exposure_time);

%% Display results
figure(1);
imshow(motion_blurred_image1);
title("Speed = 1 pixel/s static camera");
pause(1.5);

figure(2);
imshow(motion_blurred_image2);
title("Speed = 2 pixel/s static camera");
pause(1.5);

figure(3);
imshow(motion_blurred_image3);
title("Speed = 3 pixel/s static camera");
pause(1.5);

%% Clear plots
close all;

%% Parabolic motion
x_vels = [1 2 3];
motion_blurred_1 = motion_invariant_bil(redcar, background, x_vels(1), CameraT);
motion_blurred_2 = motion_invariant_bil(redcar, background, x_vels(2), CameraT);
motion_blurred_3 = motion_invariant_bil(redcar, background, x_vels(3), CameraT);

%% Display results
figure(1);
imshow(motion_blurred_1);
title("Speed = 1 pixel/s motion invariant photography");
pause(1.5);

figure(2);
imshow(motion_blurred_2);
title("Speed = 2 pixel/s motion invariant photography");
pause(1.5);

figure(3);
imshow(motion_blurred_3);
title("Speed = 3 pixel/s motion invariant photography");
pause(1.5);

%% Clear plots
close all;

%% PSF
x_vals = [0.1, 1:52];
a = 1/13;
psf = 1./sqrt(a*x_vals);
norm_fact = sum(psf);
psf = psf/norm_fact;

%% Display results
stem(x_vals, psf, 'filled');
title("PSF for motion invariant photography");
xlim([-1 53]);

%% Clear plots
close all;

%% Blur Matrix for motion invariant photography
A_mot_invariant = blur_matrix(psf, y_car);

%% Display blur matrix
imshow(A_mot_invariant*norm_fact);
% Remove the normalization from A before displaying to see it clearly
title("Blur matrix for motion invariant photography");
pause(1.5);

%% Close plots
close all;

%% Deblurring
deblurred_m = deblur(motion_blurred_1, A_mot_invariant);

%% Display results
figure(1);
imshow(deblurred_m);
title("Deblurring image captured using motion invariant photography");
pause(1.5);

%% Clear plots
close all;