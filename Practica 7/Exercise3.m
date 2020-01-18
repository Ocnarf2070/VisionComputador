clear
close all
w=30;
h=122;
n_images=5;
for i=0:n_images-1
    figure
    image=sprintf('long_jump_%d.PNG',i);
    im=imread(image);
    imshow(im);
    title('Indicate the four vertices in the image');
    P=ginput(4);
    title('Indicate the jumper sneaker tip');
    [x,y]=ginput(1);
    p=[x;y;1];
    title(image,'Interpreter','none');
    sortval=(P(:,1)-0).^2 + (P(:,2)-0).^2;
    [~,sortorder] = sort(sortval);
    P = P(sortorder,:);
    P=[P ones(4,1)]';
    Q=[0 0 1;
       0 h 1;
       w 0 1;
       w h 1]';
    H=homography2d(P,Q);
%     tf = maketform('projective',H');
% img2 = imtransform(im, tf, 'XData', [1 w], 'YData', [1 h]);
% figure(2)
% imshow(img2);
    
    q=H*p;
    q_nh(1:2) = q(1:2)/q(3);
    txt=sprintf('Distance from the jumper sneaker to the plasticine indicator: %2.6f cm',20-q_nh(1));
    xlabel(txt);
    pause;
    
end