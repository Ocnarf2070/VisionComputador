clear all
close all
imL = rgb2gray(imread('prueba2.tif'));
[ibL,Ly,Lx] = harris(imL,2,1000,1);% y coordinates = row and x coordinates = columns
imshow(imL);
title('Keypoints detected in the left image');
hold on
scatter(Lx,Ly);% To plot the points 
hold off