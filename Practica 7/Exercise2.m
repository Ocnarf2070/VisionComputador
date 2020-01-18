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
inv_tf = fliptform(tf);
imageHolo = 'chiquito.jpg';
im_holo = imread(imageHolo);
im_holo = rgb2gray(im_holo);
img2 = imtransform(im, tf, 'XData', [1 w], 'YData', [1 h]);
im_holo=flip(imresize(im_holo',size(img2)),2);
[y,x]=size(im);
img2 = imtransform(im_holo, inv_tf,'XData', [1 x], 'YData', [1 y]);
ind = img2 == 0;
img3 = im.*uint8(ind)+img2.*uint8(~ind);
imshow(img3);
title('AR image');