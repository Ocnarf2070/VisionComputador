clc
clear all
close all
global region;
global media;
global points_in_region; 
global im1;   
im1 = imread('rice.png');
imshow(im1);
[x,y]=ginput(1);
x=uint8(x);
y=uint8(y);
region = zeros(size(im1));
media=double(im1(y,x));
points_in_region=0;
crec_recur(x,y,30);
im=im1;
mask = logical(region);

im_modulo_r = uint8(im);
im_modulo_g = uint8(im);
im_modulo_b = uint8(im);

im_modulo_r(mask) = 0;
im_modulo_g(mask) = 255;
im_modulo_b(mask) = 0;

im_modulo_rgb(:,:,1) = im_modulo_r;
im_modulo_rgb(:,:,2) = im_modulo_g;
im_modulo_rgb(:,:,3) = im_modulo_b;

imshow(im_modulo_rgb);

Centroid_and_principal_direction(region);

title('Segmented region');