function [U] = U(s,U0)
% s= U0*t/b

%U = sqrt(2*s*U0); 
lambda =0.2;
omega = 0.1;
b=0.5;
U = U0*(1+lambda*sin(omega*b*s/U0));

end

