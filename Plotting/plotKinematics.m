function plotKinematics(t,s,U)
% velocity - time and displacement - time graphs

global folder subfolder

% Velocity Time
figure(6)
plot(t, U)
ylabel("Velocity [chords/s]")
xlabel("Time [s]")
savefig(fullfile(folder,subfolder,"vel - time"))

% Position Time
figure(7)
plot(t, s)
ylabel("Displacement [chords]")
xlabel("Time [s]")
savefig(fullfile(folder,subfolder,"pos - time"))

end

