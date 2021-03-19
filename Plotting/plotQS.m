close all

alpha0 = 0.261799*3; %rad
V0 = 1; % chords/s
k = alpha0*V0^2;

alpha_qs = k./(U.^2);


figure(1)
plot(t,Alpha*180/pi)
hold on
plot(t,alpha_qs*180/pi)
hold off
xlabel("t")
ylabel("alpha [deg]")
legend("LOM","QS")

figure(2)
plot(s,Alpha*180/pi)
hold on
plot(s,alpha_qs*180/pi)
hold off
xlabel("s")
ylabel("alpha [deg]")
legend("LOM","QS","Location","southeast")


alpha_qs_dot = gradient(alpha_qs)/dt;
figure(3)
plot(t,dAlphadt);
hold on
plot(t,alpha_qs_dot);
hold off
ylabel("angular velocity [rad/s]")
xlabel("t [s]")
legend("LOM","QS","Location","southeast")