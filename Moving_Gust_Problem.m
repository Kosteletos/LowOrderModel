clear all

smax = 130;

b = 0.5; % = c/2
c = 1;

U_gust = 0.65;
U_fs = 1;


alpha0 = 0.1; % Constant angle of attack
dsigma = 0.001; % integral d(sigma)
ds = 0.5;

num = round(smax/ds);

I = zeros([1,num+1]);
cl = zeros([1,num+1]);

%lambda = U_fs/(U_fs + U_gust);
%U0 = (U_fs + U_gust)^2/(2*U_fs + U_gust);
lambda = 0;
U0=1;
omega = 0.37;

for i = 0:1:num
    s = i*ds;
    for sigma = 0:dsigma:s
        I(i+1) = I(i+1) + alpha0*U(sigma,c,U_fs,U0,omega,lambda)*dWagnerds(s-sigma)*dsigma;
    end
    a = [pi*b*dUdt(s,b,U_fs,U0,omega,lambda)*alpha0/U(s,b,U_fs,U0,omega,lambda)^2,(2*pi/U(s,b,U_fs,U0,omega,lambda))*(U(s,b,U_fs,U0,omega,lambda)*alpha0/2),(2*pi/U(s,b,U_fs,U0,omega,lambda))*I(i+1)];
    disp(a);
    cl(i+1) = pi*b*dUdt(s,b,U_fs,U0,omega,lambda)*alpha0/U(s,b,U_fs,U0,omega,lambda)^2 + (2*pi/U(s,b,U_fs,U0,omega,lambda))*(U(s,b,U_fs,U0,omega,lambda)*alpha0/2 + I(i+1)) ;
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
    cl_wagner(i) = wagner_s(s-ds);
end

figure(1)
plot(s_array,cl/cl_qs);
hold on 
plot([1,140],[1,1])
plot(s_array,cl_wagner);
hold off
legend("c_l general","c_l Wagner","Location","Southeast")
xlabel('s')
ylabel('c l/c_{l_{q-s}}')
%ylim([0,3.5])
xlim([0,130])
hold on

%%
%Non-dim displacement
s_array = 0:ds:smax;

figure(2)
plot(s_array,I);
xlabel('s')
ylabel('I')
hold on

