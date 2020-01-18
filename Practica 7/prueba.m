% clear;
% close all;
% data = [255 325; 245 330; 250 126; 244 125];
% % corresponding sort-value, pick one out or make one up yourself:
% sortval = data(:,1); % the x-value
% sortval = data(:,2); % y-value
% sortval = (data(:,1)-0).^2 + (data(:,2)-0).^2; % distance form point (xo,y0)
% 
% [~,sortorder] = sort(sortval);
% sorted_data = data(sortorder,:)
% scatter(data(:,1),data(:,2))
% hold on
% line([sorted_data(1,1),sorted_data(2,1)],[sorted_data(1,2),sorted_data(2,2)],'Color','red');
% line([sorted_data(2,1),sorted_data(3,1)],[sorted_data(2,2),sorted_data(3,2)],'Color','blue');
% line([sorted_data(3,1),sorted_data(4,1)],[sorted_data(3,2),sorted_data(4,2)],'Color','green');
% hold off
clear variables
clc

% Prepare the data
num_seg = 2;
im = imread('long_jump_0.PNG'); 
im = rgb2gray(im);
im = im2double(im);

numIter= 30;

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

