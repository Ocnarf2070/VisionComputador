im=imread('long_jump_0.PNG');
im_g=rgb2gray(im);
imshow(im);
while 1
   [x,y]=ginput(1);
   x=uint64(x);
   y=uint64(y);
   color=im(y,x,:);
   colorg=im_g(y,x);
   txt=sprintf('Color: %d %d %d\nColor in gray:%d',color,colorg);    
   xlabel(txt);
end