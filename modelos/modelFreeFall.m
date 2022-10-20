% a free fall model
clc
clear all
close all
% define the parameters
g=9.81;
m=0.1;
k=0.1;
% define the initial conditions
x0=0;
v0=0;
% define the time span
tspan=[0 10];
% define the initial conditions
y0=[x0 v0];
% define the function
f=@(t,y) [y(2);-g-k/m*y(1)];
% solve the ODE
[t,y]=ode45(f,tspan,y0); 
% plot the results
plot(t,y(:,1)) % position
xlabel('time (s)') % x-axis label
ylabel('position (m)') % y-axis label
title('Free fall') % title
grid on % grid
