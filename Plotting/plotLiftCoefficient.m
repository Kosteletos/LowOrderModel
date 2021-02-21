function plotLiftCoefficient(lift,added_mass,circulatory,accel,dt,tmax)

%Displacement & time
t_array = 0:dt:tmax;
s_array = 0.5*accel*t_array.^2;

% Lift - Displacement
figure(1)
plot(s_array,lift);
hold on
plot(s_array,added_mass);
plot(s_array,circulatory);
hold off
legend("Total Lift","Added Mass", "Circulatory","Location","Northwest")
xlabel('Displacement s / c')
ylabel('C_l')
title('LOM  Lift - Displacement')
%ylim([0,1])
%xlim([0,10])

% Lift - Time
figure(2)
plot(t_array, lift);
hold on 
plot(t_array,added_mass);
plot(t_array,circulatory);
hold off
legend("Total Lift","Added Mass", "Circulatory","Location","Northwest")
xlabel('Time [s]')
ylabel('C_l')
title('LOM  Lift - Time')
%ylim([0,1])
%xlim([0,10])
end

