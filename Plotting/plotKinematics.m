function plotKinematics(t,s,U)
% velocity - time and displacement - time graphs

% Velocity Time
figure(6)
plot(t, U)
ylabel("Velocity [chords/s]")
xlabel("Time [s]")

% Position Time
figure(7)
plot(t, s)
ylabel("Displacement [chords]")
xlabel("Time [s]")


end

