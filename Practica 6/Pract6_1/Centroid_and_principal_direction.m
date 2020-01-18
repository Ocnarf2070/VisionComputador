function Centroid_and_principal_direction(I)
global center;
[mu00,~,~,mu11,mu20,mu02,~,~,~,~]=momentos_centrales(I);
hold all
plot(center(1),center(2),'r+');
Cov=1/mu00.*[mu20 mu11;mu11 mu02];
[V,D]=eig(Cov);
V1=V(:,1); V2=V(:,2);
a1=D(1,1); a2=D(2,2);
x0=center(1); y0=center(2);
x1=V1(1)*a1+x0; y1=V1(2)*a1+y0;
line ([x0,x1],[y0,y1], 'LineWidth',1, 'Color',[0 0 1]);
x1=V2(1)*a2+x0; y1=V2(2)*a2+y0;
line ([x0,x1],[y0,y1], 'LineWidth',1, 'Color',[0 0 1]);
end

