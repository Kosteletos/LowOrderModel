function [Alpha] = Alpha(s, accel)

%Alpha = 0.3;
omega = 0.8;
Alpha = omega*sqrt(2*s/accel);

Alpha = real(Alpha);
end

