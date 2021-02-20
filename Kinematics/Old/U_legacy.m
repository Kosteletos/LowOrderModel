function [U] = U(s,accel)

U = sqrt(2*s*accel); 

U = real(U);
end

