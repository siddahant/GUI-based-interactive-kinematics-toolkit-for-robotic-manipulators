function poly_out=POLY(px_start, px_end,tf)
% function to generate 5th order polynomial equation between two point
syms t
%px_start
%px_end=5
ti=0
%tf=3
a0=px_start % PX
a1=0
a2=0
A=[tf^5 tf^4 tf^3;
 5*tf^4 4*tf^3 3*tf^2;
 20*tf^3 12*tf^2 6*tf^1]
%X=[a5;a4;a3]
B=[px_end-px_start;0;0]
X=inv(A)*B;
a3=X(3)
a4=X(2)
a5=X(1)
poly_out=a5*t^5+a4*t^4+a3*t^3+a2*t^2+a1*t^1+a0;
end
