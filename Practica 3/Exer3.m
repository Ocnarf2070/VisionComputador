clear all
close all
imL = imread('pepsi_left.tif');
imR = imread('pepsi_right.tif');
subplot(2,2,1);
[ibL,Ly,Lx] = harris(imL,2,1000,10);% y coordinates = row and x coordinates = columns
imshow(imL);
title('Keypoints detected in the left image');
hold on
scatter(Lx,Ly);% To plot the points 
hold off
subplot(2,2,2);
[ibR,Ry,Rx] = harris(imR,2,1000,10);% y coordinates = row and x coordinates = columns
imshow(imR);
title('Keypoints detected in the right image');
hold on
scatter(Rx,Ry,'r');
hold off

len=30;%the half lenght of the rectangle of the template
wit=30;%the half width of the rectangle of the template
%Iniciation of the handlers
subplot(2,2,4);%For not messing with the other subplot already done
handler=plot(0,0);
handler2=handler;
l=[];
for i=1:size(Ly,1)
%for i=1:20
    rec=[Lx(i)-len Ly(i)-wit len*2 wit*2];% the rectangle of the template
    im=imcrop(imL,rec);%Cropping the image for the template
    C=normxcorr2(im,imR);
    Cp=C(len:size(C,1)-len,wit:size(C,2)-wit);%Eliminating the border of the NCC
    %Searching the probabilities of the NCC of each keypoints of the right
    %image
    for j=1:length(Rx)
        x=Ry(j);
        y=Rx(j);
        prob(j)=Cp(x,y);
    end
    
    subplot(2,2,3);
    imshow(im)%Showing the template
    title('Template');

    
    subplot(2,2,4);
    scatter(Ry,prob,5,'r.');%Plotting the probability along the row of the image
    hold on
    [m,p]=max(prob);%Calculating the maximum probability and its position
    disp(m);
    l=[l,m];
    scatter(Ry(p),m,'g*');%Plotting the maximum probability
    hold off
    title('Correlation values of right image keypoints');

    %Drawing the rectangle position in the first image and the correspondient
    %rectangle position in the second one
    subplot(2,2,1);
    if ~isempty(handler) 
        delete(handler);
        handler=rectangle('Position',rec, 'EdgeColor','r');
    end
    
    subplot(2,2,2);
    if ~isempty(handler2)
        delete(handler2);
        rec=[Rx(p)-len Ry(p)-wit len*2 wit*2];
        handler2=rectangle('Position',rec, 'EdgeColor','g');
    end
    pause(0.2)
end
mean(l)