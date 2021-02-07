function [U] = U(s,U0)
% s= U0*t/b ? not true tho
c = 0.12;
U = sqrt(4*s/c*U0); 

end

