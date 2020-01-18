P=[eye(3) zeros(3,1)];
% A parabola on the Ground Plane (Y=2),vertex at point (2,0,5,1)
bx = -100:0.1:100; by = 2*ones(1,length(bx)); bz = 5+bx.^2;
bk = ones(1,length(bx));
figure(); subplot(1,2,1); plot(bx,bz,'r.'); %Plot the parabola
% Horizon line: Two points of the ground plane (y=2) at infinity
iip1 = [20;0;100;0]; iip2 = [-20;0;100;0]; %Two directions
iip = [iip1,iip2]; %4x2
% A point at infinity, i.e. a direction on the ground plane
ip0 = [0.1;0;1;0];
% Projections on the image
im = 255.*ones(480,640); subplot(1,2,2); imshow(im); %White image
% Project the PARABOLA:
bip = [bx;by;bz;bk]; %4x#points
bop = P*bip; %3x#points
%Now normalized the homogeneous coordinates
bdn = repmat(bop(end,:),3,1); %Repeat the last row 3 times
bop = bop./bdn; % homogeneous coordinates (last element = 1)
hold on; plot(bop(1,:),bop(2,:),'r.');
% Projection of the Horizon Line
iop = P*iip; %3x2
idn = repmat(iop(end,:),3,1); iop = iop./idn;
hold on; line([0 640], [iop(2,1) iop(2,end)]);
% Projection of the infinite point
ip0p = P*ip0; %3x1 ip0p = ip0p/ip0p(3);
plot(ip0p(1,:),ip0p(2,:),'g+');
