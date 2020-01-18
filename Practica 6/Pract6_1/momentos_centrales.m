function [mu00,mu10,mu01,mu11,mu20,mu02,mu21,mu12,mu30,mu03]=momentos_centrales(I)
    [m00,m10,m01,m11,m20,m02,m21,m12,m30,m03]=momentos_no_centrales(I);
    global center
    xm=m10/m00;
    ym=m01/m00;
    center = [xm ym];
    u=m00;
    mu00=m00;
    mu01=0;
    mu10=0;
    mu20=m20-u*xm^2;
    mu11=m11-u*ym*xm;
    mu02=m02-u*ym^2;
    mu30=m30-3*m20*xm+2*m10*xm^2;
    mu21=m21-2*m11*xm-m20*ym+2*m01*xm^2;
    mu12=m12-2*m11*ym-m02*xm+2*m10*ym^2;
    mu03=m03-3*m02*ym+2*m01*ym^2;
end