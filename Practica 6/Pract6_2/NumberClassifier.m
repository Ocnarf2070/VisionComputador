
clear all
close all
Binary_classifier;

prompt = 'Introduce the name of the image with its extension:\n';
im_file_name = input(prompt);
im = imread(im_file_name);
im = rgb2gray(im);
mn=mean(mean(im));
im = imadjust(im, [0 mn/255],[0.25 1]);
imshow(im);
title('Square the number to classify');
[X,Y] = ginput(2);
im=im<200;
rec=[X(1) Y(1) abs(X(1)-X(2)) abs(Y(1)-Y(2))];
imth=imcrop(im,rec);
imshow(imresize(imth,[28 28].*5));
imth = imresize(imth,[28 28]);
title('Number to classify');

for j=1:N_images_types
    dx(j)=discriminants(w_f(:,:,j),w_n1(j),imth);
end
[~,pos] = max(dx);
subtitle = sprintf('The chopped image is clasified as %d\n',pos-1);
xlabel(subtitle);

