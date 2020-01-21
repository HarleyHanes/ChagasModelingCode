%Plot Chagas Model
clear; close all;
ParamSettings.paramset='Identicle Compartments (Scaled)';
params=Gen2_params(ParamSettings);
POIs=0;%;[.0001,.00001]; 
select.QOI={'Proportion I_{DV} at equilibirium','R_0'};
select.POI={"null"};%{"\gamma_{SV}", "\gamma_{DV}"};
[QOIs,soln]=BBB_Chagas_Gen2_model(POIs,select,params);
%Check %infected
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

figure
%Check Popsizes
plot(soln.x/365,soln.y(:,1:2:end-1)+soln.y(:,2:2:end))
legend("N_{SV}","N_{SS}","N_{SR}","N_{DV}","N_{DS}","N_{DR}","N_{DD}","Interpreter","LaTex")
%soln.py(end,2:2:end)