clear all
str_im = input('Introduce the image name of the bottle\n');
im = imread(str_im);
im_hu = momentos_Hu(im);
im_type=['A','B','C'];
centroid=zeros(1,2);
for i=1:length(im_type)
    l=im_type(i);
    hu=zeros(7,15);
    for j=1:15
        hu(:,j)=momentos_Hu(imread(sprintf('botella_%s_%d.bmp',l,j)));
    end
    centroid(1)=mean(hu(1,:));
    centroid(2)=mean(hu(2,:));
    d(i)=pdist2(centroid,im_hu(1:2),'euclidean');
end
[~,point] = min(d);
fprintf('The image corresponds to a %s type bottle\n',im_type(point));

