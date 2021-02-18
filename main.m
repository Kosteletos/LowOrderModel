clear all

tmax = 1;
dt = 0.01;

c = 0.12;
rho = 1000;

alpha0 = 0.1; % Constant angle of attack
dsigma = 0.001; % integral d(sigma)

num = round(tmax/dt);

I = zeros([1,num+1]);
added_mass = zeros([1,num+1]);
circulatory = zeros([1,num+1]);
lift = zeros([1,num+1]);

accel=0.2;

for i = 0:1:num
    
    t = i*dt;
    s = 0.5*accel*t^2;
    
    for sigma = 0:dsigma:s
        % integral (d(V*alpha)/dt|s=simga * Wagner(s-sigma) * d(sigma)
        I(i+1) = I(i+1) + (Alpha(s,accel)*dUdt(s,accel) + dAlphadt(s,accel)*U(s,accel))*Wagner(s-sigma)*dsigma;
        %a =[Alpha(sigma,accel),dUdt(sigma,accel),dAlphadt(sigma,accel),U(sigma,accel)];
        %disp(a);
    end
    
    added_mass(i+1) = (pi*c/2)/(accel^2)*(0.5*sin(2*Alpha(s,accel))*dUdt(s,accel) + dAlphadt(s,accel)*U(s,accel)*cos(Alpha(s,accel))^2);
    k = 2; % Why does this constant make it work?
    circulatory(i+1) = (2*pi)/(accel)*(U(0,accel)*Alpha(0,accel)*Wagner(s) + I(i+1));
    
    %added mass, circulatory
    a = [added_mass(i+1),circulatory(i+1)];
    %disp(a);
    
    %lift(i+1) = 0.5*rho*c*(added_mass(i+1) + circulatory(i+1));
    lift(i+1) = added_mass(i+1) + circulatory(i+1);
end

%%
%Quasi-steady lift coefficient
cl_qs = 2*pi*alpha0;

%Non-dim displacement
t_array = 0:dt:tmax;
s_array = 0.5*accel*t_array.^2;

%Wagner function for comparison
%cl_wagner = zeros([1,num+1]);
%for i = 1:1:num+1
    %t = i*dt;
    %s = 0.5*accel*t^2;
    %cl_wagner(i) = Wagner(s);
%end

% Lift - Displacement
figure(2)
plot(s_array/c,lift);
hold on
%plot(s_array/c,added_mass*0.5*rho*c);
%plot(s_array/c,circulatory*0.5*rho*c);
plot(s_array/c,added_mass);
plot(s_array/c,circulatory);
%plot([1,140],[1,1])
%plot(s_array/c,cl_wagner);
hold off
legend("Total Lift","Added Mass", "Circulatory","Location","Northwest")
xlabel('Displacement s / c')
ylabel('C_l')
title('LOM  Lift - Displacement')
%ylim([0,1])
%xlim([0,10])

% Lift - Time
figure(3)
plot(t_array, lift);
hold on 
%plot(t_array,added_mass*0.5*rho*c);
%plot(t_array,circulatory*0.5*rho*c);
plot(t_array,added_mass);
plot(t_array,circulatory);
hold off
legend("Total Lift","Added Mass", "Circulatory","Location","Northwest")
xlabel('Time [s]')
ylabel('C_l')
title('LOM  Lift - Time')
%ylim([0,1])
%xlim([0,10])


%%
%Non-dim displacement
t_array = 0:dt:tmax;
s_array = 0.5*accel*t_array.^2;

figure(4)
plot(s_array/c,I);
xlabel('Displacement s/c')
ylabel('I')
legend("1","0.1","0.01","0.001","0.0001")
hold on

