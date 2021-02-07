clear all

smax = 0.3;
% s= u*t/b
c = 0.12;
rho = 1000;

alpha0 = 0.1; % Constant angle of attack
dsigma = 0.0001; % integral d(sigma)
ds = 0.01;

num = round(smax/ds);

I = zeros([1,num+1]);
lift = zeros([1,num+1]);

U0=0.4;

for i = 0:1:num
    s = i*ds;
    for sigma = 0:dsigma:s
        % integral (d(V*alpha)/dt|s=simga * Wagner(s-sigma) * d(sigma)
        I(i+1) = I(i+1) + (alpha(sigma)*dUdt(sigma,U0) + dalphadt(sigma)*U(sigma,U0))*Wagner(s-sigma)*dsigma;
    end
    a = [(pi*c/2*U0^2)*(alpha(s)*dUdt(s,U0) + dalphadt(s)*U(s,U0)),(2*pi/U0)*(U(0,U0)*alpha(0)*Wagner(s)),(2*pi/U0)*I(i+1)];
    a = a/sum(a); 
    %added mass, circulatory 1 & 2
    disp(a);
    
    %make decision on => is Cl = l/v^2 or Cl=l/v0^2?
    clv2 = (pi*c/2)*(alpha(s)*dUdt(s,U0) + dalphadt(s)*U(s,U0)) + (2*pi*U(s,U0))*(U(0,U0)*alpha(0)*Wagner(s) + I(i+1));
    lift(i+1) = clv2*0.5*rho*c;
end

%%
%Quasi-steady lift coefficient
cl_qs = 2*pi*alpha0;

%Non-dim displacement
s_array = 0:ds:smax;

%Wagner function (recovered for U_gust -> inf)
cl_wagner = zeros([1,num+1]);
for i = 1:1:num+1
    s = i*ds;
    cl_wagner(i) = Wagner(s-ds);
end

figure(1)
plot(s_array/c,lift);
hold on 
%plot([1,140],[1,1])
plot(s_array/c,cl_wagner);
hold off
legend("c_l general","c_l Wagner","Location","Southeast")
xlabel('s/c')
ylabel('unsteady lift [N]')
%ylim([0.8,3.5])
%xlim([0,10])
hold on

%%
%Non-dim displacement
s_array = 0:ds:smax;

figure(2)
plot(s_array,I);
xlabel('s')
ylabel('I')
legend("1","0.1","0.01","0.001","0.0001")
hold on

