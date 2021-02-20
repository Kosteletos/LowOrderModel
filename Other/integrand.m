function [I] = integrand(s,sigma,accel)
%Integrand of circulatory component

I = (Alpha(sigma,accel).*dUdt(sigma,accel) + dAlphadt(sigma,accel).*U(sigma,accel)).*Wagner2(s-sigma);

end

