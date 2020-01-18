%--------------------------------------------------------------------------
%                    EXERCISE: BINARY CLASSIFIER  
%--------------------------------------------------------------------------

close all;
clear variables;

%Training
N_images = 500;
N_images_types = 10;
path_train = 'train/imagen';
images=zeros(28,28,N_images,N_images_types);
for type = 1:N_images_types
    for i_image = 1:N_images
        im_file_name = strcat(path_train,int2str(type-1),'_',int2str(i_image),'.png');
        im = imread(im_file_name);
        images(:,:,i_image,type)=im;
    end
end
p_f=zeros(28,28,N_images_types);
w_f=zeros(28,28,N_images_types);
w_n1=zeros(1,N_images_types);
for type = 1:N_images_types
    x=images(:,:,:,type)~=0;
    p_f(:,:,type)=Change_prob(sum(x,3)/N_images);
    [w_f(:,:,type), w_n1(type)] = Parts_disc(p_f(:,:,type),1/N_images_types);
end





