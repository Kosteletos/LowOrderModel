function [ U, UDot, s] = translation(t,dt,accel)

% U
U = accel.*t;

% dU/dt
UDot = gradient(U)/dt;

% s
s = 0.5.*accel.*t.^2;

% Real only
U = real(U); UDot = real(UDot);
s = real(s);
end

