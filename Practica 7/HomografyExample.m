% At least 4 pairs of points needed
P = [0 0 1; 2 0 1; 0 4 1; 2 4 1]';
Q = [0 0 1; 3 0 1; 1 3 1; 2 3 1]';
npoints = size(P,2); %4 in this example
H = homography2d(P,Q); %Transformation from P --> Q (Q =H*P)
% Now we can transform any point p ?? q
% q = H*p;
% q_nh(1:2) = q(1:2)/q(3);
% Or p =inv(H)*q;
q5=[1.5 4.5 1];
p5=inv(H)*q5'
q7=[3 4 1];
p7=inv(H)*q7'

