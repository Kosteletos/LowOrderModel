clear all

smax = 130;
% s= u*t/b
b = 0.5; % = c/2
c = 1;


alpha0 = 0.5; % Constant angle of attack
dsigma = 0.001; % integral d(sigma)
ds = 0.5;

num = round(smax/ds);

I = zeros([1,num+1]);
cl = zeros([1,num+1]);

U0=10;

for i = 0:1:num
    s = i*ds;
    for sigma = 0:dsigma:s
        I(i+1) = I(i+1) + alpha0*U(sigma,U0)*dWagnerds(s-sigma)*dsigma;
    end
    %a = [pi*b*dUdt(s,b,U_fs,U0,omega,lambda)*alpha0/U(s,U0)^2,(2*pi/U(s,U0))*(U(s,U0)*alpha0/2),(2*pi/U(s,U0))*I(i+1)];
    %a = a/sum(a); 
    %added mass, circulatory 1 & 2
    %disp(a);
    cl(i+1) = pi*b*dUds(s,U0)*alpha0/U(s,U0) + (2*pi/U(s,U0))*(U(s,U0)*alpha0/2 + I(i+1)) ;
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

