function grad = Sobel(image,threshold)
im = imread(image);
im = rgb2gray(im);
mask=1/4.*fspecial('sobel'); %Sobel kerner
im2=conv2(double(im),mask,'same'); %convolution of the image and the sobel kerner for horizontal edges
im3=conv2(double(im),mask','same'); %convolution of the image and the sobel kerner for vertical edges
grad= atan(im3/im2); % the direction gradient
im_modulo=abs(im2)+abs(im3); %the module gradient
subplot(2,2,1);
imshow(im);
title('Original image');
subplot(2,2,2);
imshow(uint8(abs(im2))); %this is for getting the module gradien for horizontal edges
title('Sobel horizontal image');
subplot(2,2,3);
imshow(uint8(abs(im3))); %this is for getting the module gradien for vertical edges
title('Sobel vertical image');
subplot(2,2,4);
pintar_verde;%Script witch change the colour of the edges to
%green and overlaps the original image
imshow(im_modulo_rgb);
title('Edges(green) image on the original');
end