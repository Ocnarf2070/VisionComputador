clear all
close all
figure(1)
im = imread('long_jump_0.PNG'); %Read the image
im_g = imnoise(im,'gaussian'); %Put a gaussian noice in the image
mask_a=fspecial('average',[3 3]); %The average kernel 3x3
mask_g=fspecial('gaussian',[3 3],0.5); %The gaussian kernel 3x3
subplot(2,2,1);
imshow(im_g);
title('Gaussian noise');
subplot(2,2,2);
im1=conv2(im_g,mask_a);%The convolution between original and the average kernel
imshow(uint8(im1));%because some valor is in double, we have to chage to int
title('Averaging smoothing');
subplot(2,2,3);
im2=medfilt2(im_g,[3,3]);%Funtion with make the median filter with size 3x3
imshow(im2);
title('Median smoothing');
subplot(2,2,4);
im3=conv2(im_g,mask_g);%The convolution between original and the gaussian kernel
imshow(uint8(im3));%because some valor is in double, we have to chage to int
title('Gaussian smoothing');

figure(2)
im_sp = imnoise(im,'salt & pepper');%Put a salt and pepper noice in the image
subplot(2,2,1);
imshow(im_sp);
title('Sal and pepper noise');
%from here we do the same except is for the salt and pepper noiced image
subplot(2,2,2);
im1=conv2(im_sp,mask_a);
imshow(uint8(im1));
title('Averaging smoothing');
subplot(2,2,3);
im2=medfilt2(im_sp,[3,3]);
imshow(im2);
title('Median smoothing');
subplot(2,2,4);
im3=conv2(im_sp,mask_g);
imshow(uint8(im3));
title('Gaussian smoothing');
