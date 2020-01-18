clear all
close all
im = imread('imagenes\lily.tif');
im2 = rgb2gray(im);
figure(1);
imshow(im2);
figure(2);
imhist(im2);
imwrite(im2,'imagenes\lily_gray.tif');