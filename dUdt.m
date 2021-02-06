function [dUdt] = dUdt(s,U0)

%dUdt = U0^2/b;
lambda =0.2;
omega = 0.1;
b=0.5;
dUdt = U0*lambda*omega*cos(omega*b*s/U0);

end

