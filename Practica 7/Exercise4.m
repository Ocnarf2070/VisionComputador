clear
close all
w=16.5;
h=40.3;
figure
image='offside.jpg';
im=imread(image);
imshow(im);
title('Indicate the four vertices in the image');
P=ginput(4);
title('Indicate the last defender');
[x,y]=ginput(1);
p=[x;y;1];
title('');
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
% lq=[1;0;q_nh(1)];
% l=H*lq;
% hold on
% X=l(1);Y=l(2);b=l(3);
% x=[0,b];
% y=(X/-Y)*x-(b/-Y);
% plot(x,y);
pq1=[q_nh(1);0;1];
pq2=[q_nh(1);h;1];
p1=inv(H)*pq1;
p1=p1(1:2)/p1(3);
p2=inv(H)*pq2;
p2=p2(1:2)/p2(3);
x=[p1(1),p2(1)];
y=[p1(2),p2(2)];
hold on
l=plot(x,y,'r');
l.LineWidth=2;