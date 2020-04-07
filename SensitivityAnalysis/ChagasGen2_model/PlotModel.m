%Plot Chagas Model
clear; close all; clc;

%% Get model Results
ParamSettings.paramset='base';
params=Gen2_params(ParamSettings);
POIs=0;%;[.0001,.00001]; 
select.QOI={'Proportion I_{DV} at equilibirium'};
%select.QOI={'Proportion I_{DV} at equilibirium','R_0'};
select.POI={"null"};%{"\gamma_{SV}", "\gamma_{DV}"};
[QOIs,soln]=BBB_Chagas_Gen2_model(POIs,select,params);


%% Check % infected
%Plot Vectors
%plot(soln.x(1:10:end)/365,soln.py(1:10:end,[2,8]))
hold on
%plot Synanthropes
plot(soln.x(1:10:end)/365,soln.py(1:10:end,[4,10]),"--","MarkerSize",2)
%Plot Rodents
plot(soln.x(1:10:end)/365,soln.py(1:10:end,[6,12]),".-","MarkerSize",2)
%Plot Pets
plot(soln.x(1:10:end)/365,soln.py(1:10:end,14),":","MarkerSize",.2)
legend("I_{SV}","I_{DV}","I_{SS}","I_{DS}","I_{SR}","I_{DR}","I_{DD}","Interpreter","LaTex")
%legend("SV","SS","SR","DV","DS","DR","DD")
xlabel('Years')
ylabel('Proportion Infected')


%% Calculate timeDerivatives
timeDerivatives=QOI_Time_Derivatives(soln,params);
figure
hold on
%plot Synanthropes
plot(soln.x(1:10:end)/365,timeDerivatives(1:10:end,[4,10]),"--","MarkerSize",2)
%Plot Rodents
plot(soln.x(1:10:end)/365,timeDerivatives(1:10:end,[6,12]),".-","MarkerSize",2)
%Plot Pets
plot(soln.x(1:10:end)/365,timeDerivatives(1:10:end,14),":","MarkerSize",.2)
legend("I_{SV}","I_{DV}","I_{SS}","I_{DS}","I_{SR}","I_{DR}","I_{DD}","Interpreter","LaTex")
%legend("SV","SS","SR","DV","DS","DR","DD")
xlabel('Years')
ylabel('d/dt*Proportion Infected')

%% Check Popsizes
figure
hold on
legendString=cell(1,0);
%plot Vectors
% plot(soln.x/365,soln.y(:,1)+soln.y(:,2))
% plot(soln.x/365,soln.y(:,7)+soln.y(:,8))
% legendString=[legendString {"N_{SV}"} {"N_{DV}"}];
%plot synanthropes
plot(soln.x/365,soln.y(:,3)+soln.y(:,4))
plot(soln.x/365,soln.y(:,9)+soln.y(:,10))
legendString=[legendString {"N_{SS}"} {"N_{DS}"}];
%plot rodents
plot(soln.x/365,soln.y(:,5)+soln.y(:,6))
plot(soln.x/365,soln.y(:,11)+soln.y(:,12))
legendString=[legendString {"N_{SR}"} {"N_{DR}"}];
%plot pets
plot(soln.x/365,soln.y(:,13)+soln.y(:,14))
legendString=[legendString {"N_{DD}"}];
%Format
title('Changes in total population sizes')
xlabel('Time (years)')
ylabel('Total Individuals')
legend(legendString,"Interpreter","LaTex")
%soln.py(end,2:2:end)