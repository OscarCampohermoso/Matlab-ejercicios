clc
close all
clear all

% Define the parameters of the system
Ptx = 20; % Transmitted power in dBm
Gtx = 10; % Transmitter antenna gain in dBi
Grx = 10; % Receiver antenna gain in dBi
Acctxt = 3; % Transmitter antenna area in m^2
Accrx = 3; % Receiver antenna area in m^2
d = 1:10; % Distance between transmitter and receiver in m
fc = 700:100:5000; % Carrier frequency in Hz

[L] = PathLoss(d,fc); % Path loss in dB
[Prx] = Pot_Rx(Ptx,Gtx,Grx,Acctxt,Accrx,fc,L); % Received power in dBm
L
% Plot the results
figure(1)
plot(L')
figure(2)
plot(Prx')