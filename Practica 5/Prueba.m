clear all
close all
N=400;
I=zeros(N);
I(1,1:2)=1;
I(1,N-1:N)=1;
for i = 2:N-1
    I(i,i-1:i+1)=1;
    j=N-i;
    I(i,j:j+2)=1;
end
I(N,i:i+1)=1;
I(N,1:2)=1;
imshow(I);
Centroid_and_principal_direction(I);