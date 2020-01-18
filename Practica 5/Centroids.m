clear all
close all
im=['A','B','C'];
centroid=zeros(2,3);
for i=1:length(im)
    l=im(i);
    hu=zeros(7,15);
    for j=1:15
        hu(:,j)=momentos_Hu(imread(sprintf('botella_%s_%d.bmp',l,j)));
    end
    hold on
    scatter(hu(1,:),hu(2,:));
    centroid(1,i)=mean(hu(1,:));
    centroid(2,i)=mean(hu(2,:));
end
scatter(centroid(1,:),centroid(2,:),250,'rx');
title('The first two HU moments');
hold off