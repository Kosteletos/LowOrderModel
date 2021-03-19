function [alpha, alphaDot] = rotation(t, dt, i, iterateFlag, iterationCounter, deltaLift, alphaIN)
%Pitching

if iterateFlag == 0

    % Prescribed rotation
%     omega = 0.4;
%     alpha = omega*t(i);
%     alphaDot = omega;
    
    % Alpha
    alpha = 0.261799;

    % d(Alpha)Dt
    alphaDot = 0;

elseif iterateFlag ==1 
        
    if iterationCounter ~= 0
       alphaPrev = alphaIN(i);
    else
       alphaPrev = alphaIN(i-1); 
    end
    alpha0 = alphaIN(i-1);
    
    % Alpha
    alpha = alphaPrev + deltaLift/1000;

    % d(Alpha)Dt
    alphaDot = (alpha - alpha0)/dt;     
    
end

%Real only
alpha = real(alpha); alphaDot = real(alphaDot);
end

