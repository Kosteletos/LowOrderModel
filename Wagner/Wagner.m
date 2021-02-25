function [phi] = Wagner(s)
% phi(s) = 1 - 0.165*e^(-0.0455s) - 0.335e^(-0.3s) 

phi = 1 - 0.165*exp(-0.0455*s) - 0.335*exp(-0.3*s);
end

