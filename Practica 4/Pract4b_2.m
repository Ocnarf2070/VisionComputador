clear variables
close all
clc

im = imread('torre_monica.jpg'); % Load the image
im_gray = rgb2gray(im); % Convert it to grayscale
figure, subplot(1,2,1), imshow(im), title('Color image') % Show it
nPixels = prod(size(im_gray)); % Get the number of pixels to ...
data = reshape(im, nPixels, 3); % ... reshape the image as a vector 
seed1 = [10,10]; % Set the seeds 
seed2 = [400,240];
seeds = [seed1(1)*size(im_gray,2)+seed1(2);seed2(1)*size(im_gray,2)+seed2(2)];
seeds = repmat(seeds,[1,3]); % Uncomment for the RGB image

for i=1:10
    fprintf('Performing k-means segmentation with %d maximum iterations\n',i);
    pert = kmeans(double(data), 2,'Start',seeds,'MaxIter',i); % kmeans!
    clus = reshape(pert, size(im_gray)); %Vector Image back to a matrix 
    im_clust = uint8(255*(clus-1)/(max(max(clus))-1)); % Clusters are 1 and 2
    subplot(1,2,2), imshow(im_clust), title('Segmentation from color') % Show results
    %pause;
    drawnow;
end

