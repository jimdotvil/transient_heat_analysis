%% limpieza de workspace y ventanas
clc
clear
close all

%% "TPS MATERIAL ANALYSIS"
%% constantes, input data
TIMEFINAL=600;   %time of exposure
Q=1000000;      %W/m^2 heat flux input
t=0.04;          %meters thickness
C= 520;           %specific heat
den= 4510;        %density
K= 15.6;          %conductivity
alfa=6.65188e-6; %thermal diffusivity
boltz=5.670e-8;   %stefan-boltzmann ctant
emiss=0.7;          %emissivity
area=10;           %area
Tinit= 310;       % K° initial temp    
elements=100;      % no. elementos
%% dimensiones matriz temperaturas
dx=t/elements;                                      
dt=0.001;
x=0:dx:t;
time=0:dt:TIMEFINAL;
T=zeros(length(time),length(x));

%%
T(:,end)=Tinit; %T init right
T(1,:)=Tinit;   %T init left 0s

for i=1:length(time)-1 %obtiene temps en frontera
    T(i+1,1)=T(i,1)+((1/area)*((dt)/(dx*den*C))*...
    (Q-((K*area*(T(i,1)-T(i,2)))/(dx))-(emiss*boltz*T(i,1))));
         for w=2:length(x)-1
            T(i+1,w)=T(i,w)+(dt*alfa*((T(i,w-1)-2*T(i,w)+...
                T(i,w+1))/(dx^2)));  
         end
end
figure(1)
plot(time, T(:,1))
title('@ x=0')
xlabel('time s')
ylabel('surface temperature K')
figure(2)
plot(x, T(end,:))
title('@ 600 sec')
xlabel('thickness m')
    ylabel('Temperature K')