clear
close all
image='la_rosaleda_2.jpg';
w=68*5;
h=105*5;
im=imread(image);
im=rgb2gray(im);
imshow(im);
title('Indicate the four vertices in the image');
P=ginput(4);
title('');
sortval=(P(:,1)-0).^2 + (P(:,2)-0).^2;
[~,sortorder] = sort(sortval);
P = P(sortorder,:);
P=[P ones(4,1)]';
Q=[0 0 1;
   w 0 1;
   0 h 1;
   w h 1]';
   
H=homography2d(P,Q);
tf = maketform('projective',H');
img2 = imtransform(im, tf, 'XData', [1 w], 'YData', [1 h]);
figure(2)
imshow(img2);
title('Perspective rectangle');
