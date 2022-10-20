% A Matlab program about Covid cases in differente dates
clc
clear all
close all                

CovidCases = [2, 1, 4, 4, 5, 6, 5, 4, 2, 7, 8, 6, 3, 4, 5, 8, 9, 4, 5, 2, 6, 8];
ocurrencias = zeros(1,9);
for i = 1:9
    ocurrencias(i) = sum(CovidCases == i);
end
fechasCovid(1) = datetime(2020,3,1);
fechasCovid(2) = datetime(2020,4,2);
fechasCovid(3) = datetime(2020,5,3);
fechasCovid(4) = datetime(2020,6,4);
fechasCovid(5) = datetime(2020,7,5);
fechasCovid(6) = datetime(2020,8,6);
fechasCovid(7) = datetime(2020,9,7);
fechasCovid(8) = datetime(2020,10,8);
fechasCovid(9) = datetime(2020,11,9);
fechasCovid(10) = datetime(2020,12,10);
fechasCovid(11) = datetime(2021,1,11);
fechasCovid(12) = datetime(2021,2,12);
fechasCovid(13) = datetime(2021,3,13);
fechasCovid(14) = datetime(2021,4,14);
fechasCovid(15) = datetime(2021,5,15);
fechasCovid(16) = datetime(2021,6,16);
fechasCovid(17) = datetime(2021,7,17);
fechasCovid(18) = datetime(2021,8,18);
fechasCovid(19) = datetime(2021,9,19);
fechasCovid(20) = datetime(2021,10,20);
fechasCovid(21) = datetime(2021,11,21);
fechasCovid(22) = datetime(2021,12,22);
figure(1)
bar(fechasCovid, CovidCases)
title('Covid Cases in different dates')
xlabel('Dates')
ylabel('Covid Cases')
grid on

acumulada(1) = CovidCases(1);
% realice a cumulative sum with CovidCases with a for and 
for i = 2:length(CovidCases)
    acumulada(i) = CovidCases(i) + acumulada(i-1);
    
end
figure(2)
stairs(fechasCovid, acumulada)
title('Covid Cases in different dates')
xlabel('Dates')
ylabel('Covid Cases')
grid on

acumulada2 = cumsum(CovidCases);
figure(3)
stairs(fechasCovid, acumulada2)
title('Covid Cases in different dates')
xlabel('Dates')
ylabel('Covid Cases')
grid on