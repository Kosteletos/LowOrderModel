function plotLiftCoefficient(lift,added_mass,circulatory,s,t)

global folder subfolder

% Lift - Displacement
figure(1)
plot(s,lift);
hold on
plot(s,added_mass);
plot(s,circulatory);
hold off
legend("Total Lift","Added Mass", "Circulatory","Location","Northwest")
xlabel('Displacement s / c')
ylabel('C_l')
title('LOM  Lift - Displacement')
%ylim([0,1])
%xlim([0,10])
savefig(fullfile(folder,subfolder,"LOM lift - displacement.fig"))

% Lift - Time
figure(2)
plot(t, lift);
hold on 
plot(t,added_mass);
plot(t,circulatory);
hold off
legend("Total Lift","Added Mass", "Circulatory","Location","Northwest")
xlabel('Time [s]')
ylabel('C_l')
title('LOM  Lift - Time')
%ylim([0,1])
%xlim([0,10])
savefig(fullfile(folder,subfolder,"LOM lift - time.fig"))
end

