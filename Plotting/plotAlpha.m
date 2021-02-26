function plotAlpha(alpha,s,t)

global folder subfolder

alpha_deg = alpha*180/pi;

% Alpha - Displacement
figure(3)
plot(s, alpha_deg);
xlabel('Displacement s / c')
ylabel('Alpha [deg]')
title('LOM  Alpha - Displacement')
%ylim([0,1])
%xlim([0,10])
savefig(fullfile(folder,subfolder,"LOM alpha - displacement.fig"))

% Alpha - Time
figure(4)
plot(t, alpha_deg);
xlabel('Time [s]')
ylabel('Alpha [deg]')
title('LOM  Alpha - Time')
%ylim([0,1])
%xlim([0,10])
savefig(fullfile(folder,subfolder,"LOM alpha - time.fig"))
end
