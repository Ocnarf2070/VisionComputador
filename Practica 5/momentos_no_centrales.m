function [m00,m10,m01,m11,m20,m02,m21,m12,m30,m03]=momentos_no_centrales(I)
m00=moment_no_central(0,0,I);
m01=moment_no_central(0,1,I);
m10=moment_no_central(1,0,I);
m20=moment_no_central(2,0,I);
m11=moment_no_central(1,1,I);
m02=moment_no_central(0,2,I);
m03=moment_no_central(0,3,I);
m12=moment_no_central(1,2,I);
m21=moment_no_central(2,1,I);
m30=moment_no_central(3,0,I);
end

