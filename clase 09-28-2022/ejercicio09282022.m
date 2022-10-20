clc
close all
clear all



Ptx = 20;
[Gtx, Grx] = deal(10,10);
[Acctx, Acgrx]= deal(3,3);
%d = [1 2 3 4 5 6 7 8 9 10] ;
%f1 = 700;
%f2 = 0.1;
%f2 = f2*1000;
%f3 = 5;
%f3 = f3 * 1000;
%f = [f1 f2 f3]
c = 0;
for m=700:100:5000
    c = c + 1;
        for n=1:10
            T = 32.44+20*log10(n)+20*log10(m);
            L(n, c) = T; 
            leyends(c) = string(m) + " mhz";
        end
end

%X = transpose(L);
PRX = Ptx +  Gtx + Acctx + Acgrx - L;
figure(1)
plot(L)
legend(leyends)
ylabel("Perdida")
xlabel("Distancia [KM]")
figure(2)
plot(PRX)
legend(leyends)
ylabel("Potencia Recibida")
xlabel("Distancia [KM]")
%L1 = 32.44+20*log10(d)+20*log10(f1)
%PRX1 = Ptx +  Gtx + Acctx + Acgrx - L1

%L2 = 32.44+20*log10(d)+20*log10(f2)
%PRX2 = Ptx +  Gtx + Acctx + Acgrx - L2

%L3 = 32.44+20*log10(d)+20*log10(f3)
%PRX3 = Ptx +  Gtx + Acctx + Acgrx - L3

