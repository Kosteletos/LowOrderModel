function [ U, UDot, s] = translation(t,dt)

%% U

% Constant
% U = 2*ones(length(t));

% surge
% accel = 2; % [chords/s^2]    (5/3 chords/s = 0.2 m/s^2)
% U = accel*t;

% % %SS -> accel -> SS
% t1 = 50; i1 = t <= t1;
% t2 = 50.5; i2 = (t <= t2) & (t > t1);
% i3 = t>t2;
% 
% v1 = 0.5;
% v2 = 2.5;
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


% % SS -> Accel -> Deccel -> SS
t1 = 50; i1 = t <= t1;
t2 = 50.5; i2 = (t <= t2) & (t > t1);
t3 = 51; i3 = (t <= t3) & (t > t2);
i4 = t>t3;

v1 = 0.5;
v2 = 1;

U = zeros(1,length(t));

% 0 < t < t1       Steady-state
U(i1) = U(i1) + v1;
% t1 < t < t2      Acceleration
accel = (v2-v1)/(t2-t1);
U(i2) = U(i2) + v1 + (t(i2)-t1)*accel;
% t2 < t < t3      Decceleration
accel = (v1-v2)/(t3-t2);
U(i3) = U(i3) + v2 + (t(i3)-t2)*accel;

% t2 < t < tmax    Steady-state
U(i4) = U(i4) + v1;
 

%% a = dU/dt
UDot = gradient(U)/dt;

%% s
s = cumtrapz(t,U);

%% Real only
U = real(U); UDot = real(UDot);
s = real(s);
end

