% a math model in matlab
clc
clear all
close all
% % define the parameters
% a=1; % Birth rate of prey
% b=1; % Death rate of prey
% c=1; % Birth rate of predator
% d=1; % Death rate of predator
p=zeros(1,4);
for i=1:4
    prompt = 'Ingrese un parametro para el modelo: ';
    x = input(prompt);
    p(i) = x;
    
end

% define the initial conditions
while 1
    prompt = 'Ingrese el numero inicial de presas: ';
    x0 = input(prompt); % number of prey in the beginning of the simulation 
    if x0 > 0 % the number of prey must be greater than 0
        break
    else
        text = 'El numero de presas debe ser mayor a 0';
        disp(text);
    end
end
while 1
    prompt = 'Ingrese el numero inicial de depredadores: ';
    y0 = input(prompt); % number of predators in the beginning of the simulation
    if y0 > 0 % the number of predators must be greater than 0
        break
    else
        text = 'El numero de depredadores debe ser mayor a 0';
        disp(text);
    end
end
% define the time span
tspan=[0 15];
% define the initial conditions
y0=[x0 y0];
% solve the system of differential equations
[t,y] = ode45(@(t,y) f(t,y,p),tspan,y0); 
% ode45 is a built-in function in MATLAB that does the numerical integration 
%for you and use the function f to calculate the derivatives of the system of 
% differential equations at each time step t and each state variable y 
% (in this case, the number of prey and the number of predators)

% plot the results
plot(t,y(:,1),'r',t,y(:,2),'b')
xlabel('Tiempo')  
ylabel('Poblacion')
legend('presa','depredador')
title('Depredador-Presa modelo matematico');

% define the function
function dy=f(t,y,p)    
    % define the system of differential equations
    dy=zeros(2,1);
    dy(1)=p(1)*y(1)-p(2)*y(1)*y(2);
    dy(2)=-p(3)*y(2)+p(4)*y(1)*y(2);
end
