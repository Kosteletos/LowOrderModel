function [dUdt] = dUdt(s,b,U_fs,U0,omega,lambda)

dUdt = U0*lambda*omega*cos(omega*s*b/U_fs);

end

