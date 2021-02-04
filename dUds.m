function [dUds] = dUds(s,b,U_fs,U0,omega,lambda)

dUds = (U0/U_fs)*omega*b*lambda*cos(omega*s*b/U_fs);

end

