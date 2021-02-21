function plotIntegral(I,accel,dt,tmax)
    %Non-dim displacement
    t_array = 0:dt:tmax;
    s_array = 0.5*accel*t_array.^2;

    figure(5)
    plot(s_array,I);
    xlabel('Displacement s/c')
    ylabel('I')
    legend("1","0.1","0.01","0.001","0.0001")
    hold on
end