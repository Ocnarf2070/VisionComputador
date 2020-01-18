clear all
close all
Binary_classifier;
%Testing
path_train = 'test\timage';
digits = load('test\digitos.mat');
digits = digits.digitos;
for i=1:length(digits)
    im_file_name = strcat(path_train,int2str(i),'.png');
    x = imread(im_file_name);
    for j=1:N_images_types
        dx(j)=discriminants(w_f(:,:,j),w_n1(j),x);
    end
    [~,pos] = max(dx);
    im=extractAfter(im_file_name,5);
    %fprintf('The image %s is clasified as %d\n',im,pos-1);
    class(i)=pos-1;
end
prob=Calculate_prob(class,digits);
fprintf('The percentage of successful classify is %d%%\n',prob);