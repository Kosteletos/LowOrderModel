function [U] = U(s,b,U_fs,U0,omega,lambda)

U = U0*(1 + lambda*sin(omega*s*b/U_fs)); 

end

