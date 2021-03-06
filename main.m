clearvars %-except Alpha dAlphadt
addpath(genpath(pwd))
tic

global folder subfolder

% Simulation Options
tmax = 58;
dt = 0.002;

% Iterate Options
startIterateTime = 49.98; % [s]
iterate = 0;  %1 = true, 0 = false 

% Plotting Options
folder = "C:\Users\Tom\OneDrive - University of Cambridge\Uni Notes\IIB\Project\Low-Order Model\Figures\Comparison\Accel_Decel";
subfolder = "test";
plotForces = 1; %1 = true, 0 = false 
plotAoA = 1; %1 = true, 0 = false 
plotI = 0; %1 = true, 0 = false
plotTranslation = 1; %1 = true, 0 = false

% Initialisations
c = 1;
t = 0:dt:tmax;
num = round(tmax/dt)+1;
I = zeros([1,num]);
added_mass = zeros([1,num]);
added_mass_v = zeros([1,num]);
added_mass_a = zeros([1,num]);
circulatory = zeros([1,num]);
lift = zeros([1,num]);
Alpha = zeros([1,num]);
dAlphadt = zeros([1,num]);
iterateFlag = 0;
targetLift = 0;
iterationCounter = 0;
deltaLift =0;

[U, dUdt, s] = translation(t,dt);

i = 1;
while i <= num 
    
    
    [Alpha(i), dAlphadt(i)] = rotation(t, dt, i, iterateFlag, iterationCounter, deltaLift, Alpha);

    
    I(i) = 0;
    for sigma = 1:1:i
        
        %Work on this - its clunky
        if (sigma ~= 1) && (sigma ~= i)
            dsigma = (s(sigma+1)-s(sigma-1))/2;
        elseif sigma ==1
           dsigma = s(2)-s(1); % this is a dubious way of doing the initial condition 
        else
            dsigma = s(end)-s(end-1);
        end
        
        % Leishman
        %integral (d(V*alpha)/dt|s=simga * Wagner(s-sigma) * d(sigma)
        I(i) = I(i) + (2*Alpha(sigma)*dUdt(sigma) + dAlphadt(sigma)*U(sigma))*Wagner2(s(i)-s(sigma))*dsigma;
        
        % Ignacio
        %I(i) = I(i) + (dWagner2ds(2*s(sigma))*Alpha(i +1 -sigma)*U(i +1 -sigma))*2*dsigma;
       
    end
    
    added_mass(i) = (pi*c/2)/(U(101)^2)*(0.5*sin(2*Alpha(i))*dUdt(i) + dAlphadt(i)*U(i)*cos(Alpha(i))^2);
    added_mass_a(i) = (pi*c/2)/(U(101)^2)*(dAlphadt(i)*U(i)*cos(Alpha(i))^2);
    added_mass_v(i) = (pi*c/2)/(U(101)^2)*(0.5*sin(2*Alpha(i))*dUdt(i));
    
    % Leishman
    circulatory(i) = (2*pi)/(U(101))*(U(1)*Alpha(1)*Wagner2(s(i)) + I(i)/U(101));
    
    % Ignacio
    %circulatory(i) = (2*pi*U(i)/U(end)/2.19)*(U(i)*Alpha(i)*Wagner2(0) + I(i));
    
    lift(i) = added_mass(i) + circulatory(i);

    if ((iterate == 1) && (iterateFlag == 0) && (t(i)>startIterateTime))
        iterateFlag = 1;
        targetLift = lift(i);
    end
    
    deltaLift = targetLift - lift(i);
       
    if iterationCounter ~= 0
        disp(['iteration= ',num2str(iterationCounter)]);
    end
    
    iterationCounter = iterationCounter + 1;
    if (abs(deltaLift)< 1e-3 || iterateFlag == 0)
        i = i + 1;
        iterationCounter = 0;
    end
end
toc

if plotForces == 1
    plotLiftCoefficient(lift,added_mass,added_mass_v,added_mass_a,circulatory,s,t);
end
if plotAoA == 1
    plotAlpha(Alpha,s,t);
end
if plotI == 1
    plotIntegral(I,s);
end
if plotTranslation == 1
    plotKinematics(t,s,U);
end
