% Generate a math model
clc
clear all
close all
% Define the parameters
% Define the initial conditions
x0 = 0.5;
y0 = 0.5;
% Define the time span
tspan = [0 100];
% Define the initial conditions
y0 = [x0 y0];
% Define the parameters
p = [a b c d];
% Define the function handle
f = @(t,y,p) [p(1)*y(1) - p(2)*y(1)*y(2); -p(3)*y(2) + p(4)*y(1)*y(2)];

% Solve the system
[t,y] = ode45(@(t,y) f(t,y,p),tspan,y0); % ode45 is a built-in function in MATLAB that solves ODEs numerically using the Runge-Kutta method of order 4(5) with step size control and dense output.  The function is called as follows: [t,y] = ode45(f,tspan,y0) where f is the function handle, tspan is the time span, and y0 is the initial conditions.  The output is the solution vector y and the time vector t.
% Plot the results
plot(t,y(:,1),'r',t,y(:,2),'b')
legend('Prey','Predator')
xlabel('Time')  
ylabel('Population')
title('Lotka-Volterra Model')
grid on