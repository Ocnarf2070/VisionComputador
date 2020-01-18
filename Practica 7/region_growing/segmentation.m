% clear all
% close all
% I = im2double(imread('long_jump_4.PNG'));
% figure, imshow(I,[]); [y,x]=getpts; y=round(y(1)); x=round(x(1));
% J = regiongrowing(rgb2gray(I),x,y,0.1);
% figure(2), imshow(I+J);
% figure(3), imshow(J);
% figure(4);
imL=double(J);
[ibL,Ly,Lx] = harris(imL,1,0,10);% y coordinates = row and x coordinates = columns
imshow(imL);
title('Keypoints detected in the left image');
hold on
scatter(Lx,Ly);% To plot the points 
hold off
%[points]=FourierDescriptor([Lx,Ly],4);