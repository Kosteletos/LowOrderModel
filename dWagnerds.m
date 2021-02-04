function [dWagnerds] = dWagnerds(s)
% phi(s) = 0.0455*0.165*e^(-0.0455s) + 0.3*0.335e^(-0.3s) 

dWagnerds = 0.0455*0.165*exp(-0.0455*s) + 0.3*0.335*exp(-0.3*s);
end

