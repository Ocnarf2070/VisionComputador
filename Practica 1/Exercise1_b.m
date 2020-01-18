clear all
close all
%Load the image
im = imread('test_images\rice.tif');
subplot(2,4,1);
%Original image
imshow(im);
title('Input image');
subplot(2,4,5);
imhist(im);
title('Histo input image');
%Modify the image with a LUT where until 50 is 0 and beyond 200 is 1
im2=imadjust(im,[50/255,200/255],[0,1]);
subplot(2,4,2);
imshow(im2);
title('LUT enhancement');
subplot(2,4,6);
imhist(im2);
title('Histo LUT enhancement');
%Equalizating the image
im3=histeq(im);
subplot(2,4,3);
imshow(im3);
title('Equalized image');
subplot(2,4,7);
imhist(im3);
title('Histo equalized image');
%Specific histogram where is the inverse in this case
im_aux=imadjust(im,[0,1],[1,0]);
im4=histeq(im,imhist(im_aux));
subplot(2,4,4);
imshow(im4);
title('Specification enhancement');
subplot(2,4,8);
imhist(im4);
title('Histo specification');