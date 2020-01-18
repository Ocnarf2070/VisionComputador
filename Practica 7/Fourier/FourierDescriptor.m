function [FD_R] = FourierDescriptor(S,nd)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to compute the Fourier Descriptor (FD) of a boundary
% Input:
% S: Matrix 2xnp of the boundary point. np: number of points
% nd: Number of descriptors we want to use
% Output:
% FD_R: Fourier descriptor. Matrix 2xnp with the nd centered columns non-zsro. The extreme
% are zero complex numbers
% Created; Nov. 2018, Javier Gonzalez Jimenez
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if size(S,1) ~= 2 display('the number of rows of S must be 2'), return, end
np = size(S,2); %Number of points that describe the boundary
if nd > np display('the number of descriptors is too large'), return, end
S = S(1,:)+j*S(2,:); %Boundary as a vector of complex numbers
FD = fft(S); %Discrete Fourier transform starting from frequency 0, i.e DC component (FD(1))
FD_centered = fftshift(FD); %Discrete Fourier transform centered at the direct component
% Take the nd centered elements as Fourier descriptor. Fill with zero the sides
nstart = round(np/2) - round(nd/2);
nend = round(np/2) + round(nd/2);
FD_R = [zeros(1, nstart-1),FD_centered(nstart:nend),zeros(1,np-nend)];
return