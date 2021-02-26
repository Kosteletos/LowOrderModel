function plotIntegral(I,s)

    figure(5)
    plot(s,I);
    xlabel('Displacement s/c')
    ylabel('I')
    legend("1","0.1","0.01","0.001","0.0001")
    hold on
end