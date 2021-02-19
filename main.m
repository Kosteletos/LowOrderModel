clear all

% Simulation Options
tmax = 1;
dt = 0.01;
c = 0.1;
rho = 1000;
dsigma = 0.001; % integral d(sigma)

% Kinematics
accel = 0.6;

% Iterate Options
startIterateTime = 0.5; % [s]
iterate = 0;  %1 = true, 0 = false 

% Initialisations
num = round(tmax/dt);
I = zeros([1,num+1]);
added_mass = zeros([1,num+1]);
circulatory = zeros([1,num+1]);
lift = zeros([1,num+1]);
%Alpha = zeros([1,num+1]);
%dAlphadt = zeros([1,num+1]);
%U = zeros([1,num+1]);
%dUdt = zeros([1,num+1]);
iterateFlag = 0;
targetLift = 0;
iterationCounter = 0;

% make a kinematics function that generates the values at each time step,
% so can incorporate the iteration in it nicely (and maybe speed up the
% integral)

i = 0;
while i <= num    
    
    t = i*dt;
    s = 0.5*accel*t^2;
    
    I(i+1) = 0;
    for sigma = 0:dsigma:s
        %integral (d(V*alpha)/dt|s=simga * Wagner(s-sigma) * d(sigma)
        I(i+1) = I(i+1) + (Alpha(sigma,accel)*dUdt(sigma,accel) + dAlphadt(sigma,accel)*U(sigma,accel))*Wagner2(s-sigma,c)*dsigma;
        %a =[Alpha(sigma,accel),dUdt(sigma,accel),dAlphadt(sigma,accel),U(sigma,accel)];
        %disp(a);
    end

    
    %integrand_x = @(x) integrand(s,x,accel);     % Slow
    %I(i+1) = integral(integrand_x,0,s);
    
    
    added_mass(i+1) = (pi*c/2)/(accel^2)*(0.5*sin(2*Alpha(s,accel))*dUdt(s,accel) + dAlphadt(s,accel)*U(s,accel)*cos(Alpha(s,accel))^2);
    circulatory(i+1) = (2*pi)/(accel)*(U(0,accel)*Alpha(0,accel)*Wagner2(s,c) + I(i+1));
    lift(i+1) = added_mass(i+1) + circulatory(i+1);

    
    if ((iterate == 1) && (iterateFlag == 0) && (t>startIterateTime))
        iterateFlag = 1;
        targetLift = lift(i+1);
    end
    
    deltaLift = targetLift - lift(i+1);
       
    if iterationCounter ~= 0
        disp(['iteration= ',num2str(iterationCounter)]);
    end
    
    iterationCounter = iterationCounter + 1;
    if (abs(deltaLift)< 1e-2 || iterateFlag == 0)
        i = i + 1;
        iterationCounter = 0;
    end
end

%%

%Displacement & time
t_array = 0:dt:tmax;
s_array = 0.5*accel*t_array.^2;


% Lift - Displacement
figure(2)
plot(s_array/c,lift);
hold on
plot(s_array/c,added_mass);
plot(s_array/c,circulatory);
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

