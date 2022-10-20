% Electric resistance model
clc
clear all
close all
% Parameters
R1=1;
R2=2;
R3=10;
R4=0.1;
R0=1000;
% Input
Vin=1;
% Output
Vout=0;
% Time
t=0:0.0001:0.1;
% Loop
for i=1:length(t)
    Vout(i)=((R2*R3)/(R2+R3))*Vin;
end
% Plot
plot(t,Vout)
title('Voltage across R_4')
xlabel('Time (s)')
ylabel('Voltage (V)')
grid on
