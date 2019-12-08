%% TESTLambdaCode
%-Test code seeking to assess variable model sensitivity to movement rate
%   parameters depending on model properties
% 1)Level of tfprintf("Loading parameters\n")ransmission accross spatial areas
% 2)Decreased infectiveness in peridomestic areas
clear;clc;
%Parameter Set up
%Binary SpatialTrans
    ParamSettings.paramset='InvestigateLambda';
    PropSpatialTrans=[0,.2];
    PropDomestDefficient=linspace(0,1,15);
for i=1:length(PropSpatialTrans)
    ParamSettings.PropSpatialTrans=PropSpatialTrans(i);
    for j=1:length(PropDomestDefficient)
        ParamSettings.PropDomestDefficient=PropDomestDefficient(j);
        [POI,QOI]=main_Q0I_UQ_analysis('Chagas-Gen1-AssessLambda',ParamSettings);
        EquillambdaH(j,i)=max(QOI.ESA.range(1,1,:))-min(QOI.ESA.range(1,1,:));
        EquillambdaV(j,i)=max(QOI.ESA.range(2,1,:))-min(QOI.ESA.range(2,1,:));
       
        tlambdaH(j,i)=max(QOI.ESA.range(1,2,:))-min(QOI.ESA.range(1,2,:));
        tlambdaV(j,i)=max(QOI.ESA.range(2,2,:))-min(QOI.ESA.range(2,2,:));
    end
end
%%
for i=1:length(PropSpatialTrans)
    EquillambdaHPlot=EquillambdaH(:,i);
    tlambdaHPlot=tlambdaH(:,i);
    
    EquillambdaVPlot=EquillambdaV(:,i);
    tlambdaVPlot=tlambdaV(:,i);
    subplot(2,2,2*i-1)
    plot(PropDomestDefficient*100,[EquillambdaVPlot tlambdaVPlot]*100)
    subplot(2,2,2*i)
    plot(PropDomestDefficient*100,[EquillambdaHPlot tlambdaHPlot]*100)
end
subplot(2,2,1)
ylabel(sprintf('Trans-spatial -\n%% I_{DT}'))
title('\lambda_V')
subplot(2,2,2)
legend('Equilibrium Max-Min Dif','t=5 Max-Min Dif')
title('\lambda_H')
subplot(2,2,3)
ylabel(sprintf('Trans-spatial +\n%% I_{DT}'))
xlabel('% Decreased Peridomestic Transmission')
subplot(2,2,4)
xlabel('% Decreased Peridomestic Transmission')
