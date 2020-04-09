clear; close all; clc;
set(0,'DefaultAxesFontSize',18,'defaultlinelinewidth',2);set(gca,'FontSize',18);close(gcf);% increase font size

lambda=linspace(0,1,30);
for il=1:length(lambda)
%% Get model Results
ParamSettings.paramset='base';
params=Gen2_params(ParamSettings);
params.lambda.V=params.lambda.V*lambda(il);
params.lambda.S=params.lambda.S*lambda(il);
params.lambda.R=params.lambda.R*lambda(il);
POIs=0;%;[.0001,.00001]; 
select.QOI={'Proportion I_{DV} at equilibirium', 'Proportion I_{DD} at equilibirium',...
            'Proportion I_{DR} at equilibirium', 'Proportion I_{DS} at equilibirium'};
%select.QOI={'Proportion I_{DV} at equilibirium','R_0'};
select.POI={"null"};%{"\gamma_{SV}", "\gamma_{DV}"};
[QOIs,soln]=BBB_Chagas_Gen2_model(POIs,select,params);
I(il,:)=soln.py(end,[2 4 6 8 10 12 14]);
end
plot(lambda,I)
ylabel('Equilibrium Proportion Infected')
xlabel('\lambda Scaling')
legend('I_{SV}','I_{SS}','I_{SR}','I_{DV}','I_{DS}','I_{DR}','I_{DD}')

p=logspace(-5,0,30);
figure
for ip=1:length(p)
%% Get model Results
ParamSettings.paramset='Test pHost';
ParamSettings.pScale=p(ip);
params=Gen2_params(ParamSettings);
POIs=0;%;[.0001,.00001]; 
select.QOI={'Proportion I_{DV} at equilibirium', 'Proportion I_{DD} at equilibirium',...
            'Proportion I_{DR} at equilibirium', 'Proportion I_{DS} at equilibirium'};
%select.QOI={'Proportion I_{DV} at equilibirium','R_0'};
select.POI={"null"};%{"\gamma_{SV}", "\gamma_{DV}"};
[QOIs,soln]=BBB_Chagas_Gen2_model(POIs,select,params);
I(ip,:)=soln.py(end,[2 4 6 8 10 12 14]);
end
semilogx(p,I)
ylabel('Equilibrium Proportion Infected')
xlabel('\alpha_{Host} Scaling')
legend('I_{SV}','I_{SS}','I_{SR}','I_{DV}','I_{DS}','I_{DR}','I_{DD}')
