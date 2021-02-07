function [dWagnerds] = dWagnerds(s)
% phi(s) = 0.0455*0.165*e^(-0.0455s) + 0.3*0.335e^(-0.3s) 
c = 0.12;
dWagnerds = 0.0455*0.165*exp(-0.0455*2*s/c) + 0.3*0.335*exp(-0.3*2*s/c);
end

