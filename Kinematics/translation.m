function [ U, UDot, s] = translation(t,dt,accel)

%% U

% Constant
U = ones(length(t));

% surge
%U = accel.*t;

% SS -> accel -> SS
% t1 = 1.0; i1 = t <= t1;
% t2 = 1.5; i2 = (t <= t2) & (t > t1);
% i3 = t>t2;
% 
% v1 = 2;
% v2 = 4;
% 
% U = zeros(1,length(t));
% 
% % 0 < t < t1       Steady-state
% U(i1) = U(i1) + v1;
% % t1 < t < t2      Acceleration
% accel = (v2-v1)/(t2-t1);
% U(i2) = U(i2) + v1 + (t(i2)-t1)*accel;
% % t2 < t < tmax    Steady-state
% U(i3) = U(i3) + v2;

%% dU/dt
UDot = gradient(U)/dt;

%% s
s = cumtrapz(t,U);

%% Real only
U = real(U); UDot = real(UDot);
s = real(s);
end

