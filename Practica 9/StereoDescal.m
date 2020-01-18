
clear
close all
imL = imread('pepsi_left.tif');
imR = imread('pepsi_right.tif');
subplot(1,2,1);
[ibL,Ly,Lx] = harris(imL,2,1000,10);% y coordinates = row and x coordinates = columns
imshow(imL);
hold on
scatter(Lx,Ly);% To plot the points 
hold off
drawnow
subplot(1,2,2);
[ibR,Ry,Rx] = harris(imR,2,1000,10);% y coordinates = row and x coordinates = columns
imshow(imR);
hold on
scatter(Rx,Ry,'r');
hold off
drawnow
len=30;%the half lenght of the rectangle of the template
wit=30;%the half width of the rectangle of the template

Corr = nan * ones(2,length(Lx));
for i=1:size(Lx,1)
    drawnow
    rec=[Lx(i)-len Ly(i)-wit len*2 wit*2];% the rectangle of the template
    im=imcrop(imL,rec);%Cropping the image for the template
    C=normxcorr2(im,imR);
    Cp=C(len:size(C,1)-len,wit:size(C,2)-wit);%Eliminating the border of the NCC
    %Searching the probabilities of the NCC of each keypoints of the right
    %image
    %figure(2)
    %imshow(Cp)
    for j=1:length(Rx)
        x=Ry(j);
        y=Rx(j);
        prob(j)=Cp(x,y);
    end
    ProbMax=max(prob);
    if ProbMax >= 0.9
        index = find(prob == ProbMax);%Calculating the maximum probability and its position
        Corr(:,i)=[Rx(index); Ry(index)];
        
    end
    %pause(0.2)
end

index2=find(~isnan(Corr(1,:)));
h1 = [Lx(index2)'; Ly(index2)'];
h2 = Corr(:,index2);
for i=1:length(index2)
    colors = [rand rand rand];
    subplot(1,2,1);
    hold on
    scatter(h1(1,i),h1(2,i),'*','MarkerEdgeColor',colors); 
    hold off
    subplot(1,2,2);
    hold on
    scatter(h2(1,i),h2(2,i),'*','MarkerEdgeColor',colors); 
    hold off
    drawnow
end
[F, inliers] = ransacfitfundmatrix(h2,h1,1e-5);
fprintf('Fundamental matrix:\n');
disp(F);
fprintf('Inliners: \nLeft image:\n');
disp(h1(1:2,inliers));
fprintf('Right image:\n');
disp(h2(1:2,inliers));
figure(2)
subplot(1,2,1);
imshow(imL);
subplot(1,2,2);
imshow(imR);

subplot(1,2,1);
[x,y] = ginput(1);
%hold on
%scatter(x,y,'*r');
ln = F'*[x;y;1]; % x,y are the coordinates of the clicked point on the left image
x0 = [0 size(imR,2)];
y0 = -ln(1)/ln(2)*x0-ln(3)/ln(2);
subplot(1,2,2);
line(x0,y0);
%{
x1 = x0(1);
y1 = y0(1);
ln = F*[x1;y1;1]; % x,y are the coordinates of the clicked point on the left image
x0 = [0 size(imL,2)];
y0 = -ln(1)/ln(2)*x0-ln(3)/ln(2);
subplot(1,2,1);
line(x0,y0);
%}
b = 0.119 ;
cx = 255.64; cy = 201.12;
f = 351.32;
di = h1(1,:)-h2(1,:);
xli=h2(1,:); yli=h2(2,:);

Xi = b * (xli - cx) ./ di;
Yi = b * -(yli - cy) ./ di;
Zi = f * b ./ di;
figure
plot3(Xi,Yi,Zi,'.');



