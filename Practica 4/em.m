
clear variables
clc

% Prepare the data
num_seg = 2;
im = imread('torre_monica.jpg'); 
im = rgb2gray(im);
im = im2double(im);

numIter= 10;

clus = segmentation_em(im, num_seg, numIter); %Image with segm. result 
im_clust = uint8(255*(clus-1)/(max(max(clus))-1));
    
% Show the figure
figure
subplot(1,2,1); 
imshow(im); 
title('Imagen original');    

% Show the results
subplot(1,2,2); 
imshow(im_clust); 
title('Segmentacion EM');

