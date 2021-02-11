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

accel=0.6;

for i = 0:1:num
    
    t = i*dt;
    s = 0.5*accel*t^2;
    
    for sigma = 0:dsigma:s
        % integral (d(V*alpha)/dt|s=simga * Wagner(s-sigma) * d(sigma)
        I(i+1) = I(i+1) + (Alpha(sigma)*dUdt(sigma,accel) + dAlphadt(sigma)*U(sigma,accel))*Wagner(s-sigma)*dsigma;
    end
    a = [(pi*c/2)*(Alpha(s)*dUdt(s,accel) + dAlphadt(s)*U(s,accel)),(2*pi*U(s,accel))*(U(0,accel)*Alpha(0)*Wagner(s)),(2*pi*U(s,accel))*I(i+1)];
    %a = a/sum(a); 
    %added mass, circulatory 1 & 2
    disp(a);
    
    added_mass(i+1) = (pi*c/2)*(Alpha(s)*dUdt(s,accel) + dAlphadt(s)*U(s,accel));
    circulatory(i+1) = (2*pi*U(s,accel))*(U(0,accel)*Alpha(0)*Wagner(s) + I(i+1));
    lift(i+1) = 0.5*rho*c*(added_mass(i+1) + circulatory(i+1));
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

figure(2)
plot(s_array/c,lift);
hold on
plot(s_array/c,added_mass*0.5*rho*c);
plot(s_array/c,circulatory*0.5*rho*c);
%plot([1,140],[1,1])
%plot(s_array/c,cl_wagner);
hold off
legend("c_l","c_l added mass", "c_l circulatory","Location","Northwest")
xlabel('s/c')
ylabel('unsteady lift [N]')
%ylim([0.8,3.5])
%xlim([0,10])
hold on

%%
%Non-dim displacement
t_array = 0:dt:tmax;
s_array = 0.5*accel*t_array.^2;

figure(2)
plot(s_array/c,I);
xlabel('s/c')
ylabel('I')
legend("1","0.1","0.01","0.001","0.0001")
hold on

