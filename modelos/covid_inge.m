%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                     CLASES DE PROGRAMACIÓN EN MATLAB (COVID-19)                                  %%%
%%%                   Realizadas por: Ph.D. Ing. Marcelo Molina Silva                                %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%           El programa consta de generar gráficos (Distribuciones) del virus
%%%        COVID-19 con el objetivo de ver su tendencia y dar un claro ejemplo del
%%%         análisis estadístico que se puede realizar de una variable aleatória
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc 
clear all
close all 

%% Declaración de Variables 
Casos_Nuevos = [2 1 0 7 0 1 0 1 0	5 2	1 7	1 4	7 22 13	7 15 11	8 8	9 7 18 26 11 16 54 4 7 25 30 24 43 44 24 28 27 44 34 11 63 31 104 59 84 64 39 57 57 67 241 124 87 121 84 195 185];
startDate = datenum('03-10-2020');          % Define fecha como número "Inicio"
endDate = datenum('05-08-2020');            % Define fecha como número "Fin"
Inv_startDate = datestr (startDate);        % De número a fecha "Inicio"
Inv_endDate = datestr (endDate);            % De número a fecha "Fin"
%% Algoritmo
Tam = length(Casos_Nuevos);
Media = mean(Casos_Nuevos);
Desvio = std(Casos_Nuevos);
x= [Casos_Nuevos(Tam-3) Casos_Nuevos(Tam-2) Casos_Nuevos(Tam-1) Casos_Nuevos(Tam)];
Media_4UD=mean(Casos_Nuevos(end-3:end));
Desvio_4UD=std(Casos_Nuevos(end-3:end));
xData = linspace(startDate,endDate,Tam);
%% Mostrar los Resultados

disp(['La media de personas contagiadas desde que empezó la pandemia es' num2str(Media)])
disp(['El desvio de personas contagiadas desde que empezó la pandemia es' num2str(Desvio)])
disp(['La media de personas contagiadas en los últimos 4 días' num2str(Media_4UD)])
disp(['El desvio de personas contagiadas en los últimos 4 días' num2str(Desvio_4UD)])

figure(1)
bar(xData,Casos_Nuevos)
datetick('x','dd/mm','keeplimits')
title('Número de casos Nuevos de COVID-19 en Bolivia')
xlabel ('Fechas')
ylabel ('Número de casos')
set(gca,'XTick',[startDate:endDate])
set(gca,'YTick',[min(Casos_Nuevos):10:max(Casos_Nuevos)])
grid on 

figure(2)
stem(xData,Casos_Nuevos)
hold on 
plot(xData, Casos_Nuevos,'r','LineWidth',2)
datetick('x','dd/mm','keeplimits')
title('Número de casos Nuevos de COVID-19 en Bolivia')
xlabel ('Fechas')
ylabel ('Número de casos')
set(gca,'XTick',[startDate:endDate])
set(gca,'YTick',[min(Casos_Nuevos):10:max(Casos_Nuevos)])
grid on
hold off
a=0;
for i = 1:Tam
    a=a+Casos_Nuevos(i);
    x2(i)=a;
end

% % % for j = 1:Tam
% % %     if j==1
% % %         FA(j)=Casos_Nuevos(j);
% % %     else
% % %         FA(j)=Casos_Nuevos(j)+FA(j-1);
% % %     end
% % %     
% % % end 

figure (3)
plot(xData,x2)
hold on
stairs(xData,x2,'r','LineWidth',2)
datetick('x','dd/mm','keeplimits')
title('Dist. Acumulada COVID-19 en Bolivia')
xlabel ('Fechas')
ylabel ('Acumulada')
set(gca,'XTick',[startDate:endDate])
set(gca,'YTick',[min(x2):100:max(x2)])
grid on
hold off


x3=x2/max(x2);

figure (4)
plot(xData,x3)
hold on
stairs(xData,x3,'g','LineWidth',2)
datetick('x','dd/mm','keeplimits')
title('Dist. Acumulada COVID-19 en Bolivia')
xlabel ('Fechas')
ylabel ('Acumulada')
set(gca,'XTick',[startDate:endDate])
% set(gca,'YTick',[min(x3):max(x3)])
grid on
hold off


%%

Retardo_Novo=Casos_Nuevos;
x1=find(Retardo_Novo==0);
Retardo_Novo(x1)=[];
Retardo_RMS = Retardo_Novo;

p=sort((Casos_Nuevos')); 
maximo=max(p);
minimo=min(p);
Vrms=[minimo:0.002:maximo maximo];
tam_p=size(p);
percentual=(1/tam_p(2));
k=1;
for i=Vrms
      dist_cum_retRMS(k)=length(find(p<=i))*percentual;
      k=k+1;
end

dist_cum_retRMS=dist_cum_retRMS/max(dist_cum_retRMS);

% CDF LogNormal
Param_Logn= mle(Retardo_RMS,'distribution','logn');
L = cdf('logn',Vrms,Param_Logn(1), Param_Logn(2));

% CDF Normal
Param_Norm= mle(Retardo_RMS,'distribution','norm');
norm = cdf('norm',Vrms,Param_Norm(1), Param_Norm(2));

% CDF Weibull
Param_Weibull = mle(Retardo_RMS,'distribution','Weibull');
w=cdf('Weibull',Vrms,Param_Weibull(1),Param_Weibull(2));

% CDF Nakagami Teórica
param_Nakagami = mle(Retardo_RMS,'distribution','nakagami');
n = cdf('nakagami',Vrms,param_Nakagami(1),param_Nakagami(2));

% CDF Rice Teórica
Param_Rice = mle(Retardo_RMS,'distribution','rician');
r = cdf('rician',Vrms,Param_Rice(1),Param_Rice(2));

% CDF Rayleigh Teórica
Param_Rayl = mle(Retardo_RMS,'distribution','rayl');
ry = cdf('rayl',Vrms,Param_Rayl(1));

figure (5)
stairs(Vrms,dist_cum_retRMS)
hold on 
plot(Vrms,L,'b')
plot(Vrms,norm,'r')
plot(Vrms,w,'y');
plot(Vrms,n,'g');
plot(Vrms,r,'m');
plot(Vrms,ry,'c');
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%R) Dados Empíricos
Dados_Emp = dist_cum_retRMS';
%1) CDF LogNormal Teórica
LogN=L';
%2) CDF Normal Teórica
NormT=norm';
%3) CDF Weibull Teórica
WeiT=w';
%4) CDF Nakagami Teórica
NakT=n';
%5) CDF Rice Teórica
RicT=r';
%6) CDF Rayleigh Teórica
RayT=ry';

% % % % % % % % % % % % % % Meida do  Error

ME_LogN = mean(LogN-Dados_Emp);
ME_NormT = mean(NormT-Dados_Emp);
ME_WeiT = mean(WeiT-Dados_Emp);
ME_NakT = mean(NakT-Dados_Emp);
ME_RicT = mean(RicT-Dados_Emp);
ME_RayT = mean(RayT-Dados_Emp);

% % % % % % % % % % % % Desvio Padrão do Erro

Tam_DE = size(Dados_Emp);
Sigma_LogN = sqrt(sum(((LogN-Dados_Emp)-ME_LogN).^2)/(Tam_DE(1)-1));
% SL=std(LogN-Dados_Emp);
Sigma_NormT = sqrt(sum(((NormT-Dados_Emp)-ME_NormT).^2)/(Tam_DE(1)-1));
% SN=std(NormT-Dados_Emp);
Sigma_WeiT = sqrt(sum(((WeiT-Dados_Emp)-ME_WeiT).^2)/(Tam_DE(1)-1));
% SW=std(WeiT-Dados_Emp);
Sigma_NakT = sqrt(sum(((NakT-Dados_Emp)-ME_NakT).^2)/(Tam_DE(1)-1));
% SN1=std(NakT-Dados_Emp);
Sigma_RicT = sqrt(sum(((RicT-Dados_Emp)-ME_RicT).^2)/(Tam_DE(1)-1));
% SR=std(RicT-Dados_Emp);
Sigma_RayT = sqrt(sum(((RayT-Dados_Emp)-ME_RayT).^2)/(Tam_DE(1)-1));
% SR1=std(RayT-Dados_Emp);

% % % % % % % % % % % % Root Mean Squared Error

RMSD_LogN = sqrt(mean((Dados_Emp - LogN).^2)); 
% RMSD_LogN_L = sqrt((ME_LogN).^2+(Sigma_LogN).^2);
RMSD_NormT = sqrt(mean((Dados_Emp - NormT).^2));
% RMSD_NormT_L  = sqrt((ME_NormT).^2+(Sigma_NormT).^2);
RMSD_WeiT = sqrt(mean((Dados_Emp - WeiT).^2));
% RMSD_WeiT_L = sqrt((ME_WeiT).^2+(Sigma_WeiT).^2);
RMSD_NakT = sqrt(mean((Dados_Emp - NakT).^2));
% RMSD_NakT_L = sqrt((ME_NakT).^2+(Sigma_NakT).^2);
RMSD_RicT = sqrt(mean((Dados_Emp - RicT).^2)); 
% RMSD_RicT_L = sqrt((ME_RicT).^2+(Sigma_RicT).^2);
RMSD_RayT = sqrt(mean((Dados_Emp - RayT).^2));
% RMSD_RayT_L = sqrt((ME_RayT).^2+(Sigma_RayT).^2);

%%          Qui
% % h_LOG1 = chi2gof(L);
% % h_NORM1 = chi2gof(norm);
% % h_WBL1 = chi2gof(w);
% % h_NAK1 = chi2gof(n);
% % h_RICE1 = chi2gof(r);
% % h_RICE1 = chi2gof(ry);
%%

% % % pd_logn = fitdist(Retardo_RMS','logn');
% % % pd_norm = fitdist(Retardo_RMS','norm');
% % % pd_weibull = fitdist(Retardo_RMS','Weibull');
% % % pd_nakagami = fitdist(Retardo_RMS','nakagami');
% % % pd_rician = fitdist(Retardo_RMS','rician');
% % % pd_rayl = fitdist(Retardo_RMS','rayl');
% % % 
% % % %% Qui-Quadrado
% % % [h_LOG1,p1] = chi2gof(Retardo_RMS,'CDF',pd_logn,'Alpha',0.01);
% % % [h_NORM1,p2] = chi2gof(Retardo_RMS,'CDF',pd_norm,'Alpha',0.01);
% % % [h_WBL1,p3] = chi2gof(Retardo_RMS,'CDF',pd_weibull,'Alpha',0.01);
% % % [h_NAK1,p4] = chi2gof(Retardo_RMS,'CDF',pd_nakagami,'Alpha',0.01);
% % % [h_RICE1,p5] = chi2gof(Retardo_RMS,'CDF',pd_rician,'Alpha',0.01);
% % % [h_RAYLEIGH ,p6] = chi2gof(Retardo_RMS,'CDF',pd_rayl,'Alpha',0.01);
% % % 
% % % %% Kolmogorov-Simirnov
% % % [H_LOG,p_LOG] = kstest(Retardo_RMS,'CDF',pd_logn ,'Alpha',0.01);
% % % [H_NORM,p_NORM] = kstest(Retardo_RMS,'CDF',pd_norm ,'Alpha',0.01);
% % % [H_WBL,p_WBL] = kstest(Retardo_RMS,'CDF',pd_weibull ,'Alpha',0.01);
% % % [H_NAK,p_NAK] = kstest(Retardo_RMS,'CDF',pd_nakagami ,'Alpha',0.01);
% % % [H_RICE,p_RICE] = kstest(Retardo_RMS,'CDF',pd_rician ,'Alpha',0.01);
% % % [H_RAYLEIH,p_RAYLEIH] = kstest(Retardo_RMS,'CDF',pd_rayl ,'Alpha',0.01);
% % % 
% % % 
% % % % Parametros=[Param_Logn Param_Norm Param_Weibull param_Nakagami Param_Rice Param_Rayl]
% % % % Parametros_media=[ME_LogN ME_NormT ME_WeiT ME_NakT ME_RicT ME_RayT]
% % % % Parametros_rms=[RMSD_LogN RMSD_NormT RMSD_WeiT RMSD_NakT RMSD_RicT RMSD_RayT]
% % % 
% % % %%https://www.mathworks.com/matlabcentral/fileexchange/3596-pearson-chi-square-hypothesis-test
