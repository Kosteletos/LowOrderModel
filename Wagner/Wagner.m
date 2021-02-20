function [phi] = Wagner(s,c)
% phi(s) = 1 - 0.165*e^(-0.0455s) - 0.335e^(-0.3s) 

phi = 1 - 0.165*exp(-0.0455*2*s./c) - 0.335*exp(-0.3*2*s./c);
end

