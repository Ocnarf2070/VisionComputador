subplot(1,2,1);
[x,y] = ginput(1);
hold on
scatter(x,y,'*r');
ln = F'*[x;y;1]; % x,y are the coordinates of the clicked point on the left image
x0 = [0 size(imR,2)];
y0 = -ln(1)/ln(2)*x0-ln(3)/ln(2);
subplot(1,2,2);
line(x0,y0);
x1 = x0(1);
y1 = y0(1);
ln = F*[x1;y1;1]; % x,y are the coordinates of the clicked point on the left image
x0 = [0 size(imL,2)];
y0 = -ln(1)/ln(2)*x0-ln(3)/ln(2);
subplot(1,2,1);
line(x0,y0);