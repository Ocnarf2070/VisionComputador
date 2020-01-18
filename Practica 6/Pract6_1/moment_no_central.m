function y=moment_no_central(i,j,I)
[M,N]=size(I);
ax=(1:N).^i; ay=(1:M).^j;
y=ax*I'*ay';
end

