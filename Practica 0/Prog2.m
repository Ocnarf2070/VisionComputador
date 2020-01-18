clear all
close all
im = imread('imagenes\lily_gray.tif');
im2 = im2bw(im,100/255);
im3 = imresize(im,0.5);
x = size(1);
y = size(2);
c = [x/4, y/4, 3*x/4, 3*y/4];
im4=im(c(1):c(3),c(2):c(4));
        
subplot(2,2,1);
imshow(im);
title('Original image');

subplot(2,2,2);
imshow(im2);
title('Thresholdized image (t=100)');

subplot(2,2,3);
imshow(im3);
title('Half resolution image');

subplot(2,2,4);
imshow(im4);
title('Centre of the image');

