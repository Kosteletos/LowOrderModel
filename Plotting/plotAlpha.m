function plotAlpha(alpha,accel,dt,tmax)

%Displacement & time
t_array = 0:dt:tmax;
s_array = 0.5*accel*t_array.^2;

alpha_deg = alpha*180/pi;

% Alpha - Displacement
figure(3)
plot(s_array, alpha_deg);
xlabel('Displacement s / c')
ylabel('Alpha [deg]')
title('LOM  Alpha - Displacement')
%ylim([0,1])
%xlim([0,10])

% Alpha - Time
figure(4)
plot(t_array, alpha_deg);
xlabel('Time [s]')
ylabel('Alpha [deg]')
title('LOM  Alpha - Time')
%ylim([0,1])
%xlim([0,10])
end
