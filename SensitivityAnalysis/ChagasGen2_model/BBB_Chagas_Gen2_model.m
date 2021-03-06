function [QOIs,soln] = BBB_Chagas_Gen2_model(POIs,select,baseParams)
% This takes parameters, solves the ODE and returns desired quantities
qnames=select.QOI;
params=modify_params(POIs,select,baseParams);


% initial conditions for y=(S_SV, I_SV S_SS I_SS S_SR I_SR S_DV I_DV S_DR I_DR S_DD I_DD)
yzero=params.init;
% final integration time
tspan=params.tspan;

% Bake the parameters into ode_rhs (aka currying)
yzero = balance_model(yzero, params);
dydt_fn = @(t,y) Chagas_Gen2_ODEs(t, y, params);
%% Solve ODE
if ~((strcmpi(qnames{1},'R_0')||(strcmpi(qnames{1},'Algebraic Equilibrium Error'))) && length(qnames)==1)
%soln = ode23tb(dydt_fn, tspan, yzero);
[soln.x,soln.y]=ode45(dydt_fn, tspan, yzero);
%soln.y=soln.y'
        soln.py(:,1)=soln.y(:,1)./(soln.y(:,1)+soln.y(:,2));
        soln.py(:,2)=soln.y(:,2)./(soln.y(:,1)+soln.y(:,2));
        soln.py(:,3)=soln.y(:,3)./(soln.y(:,3)+soln.y(:,4));
        soln.py(:,4)=soln.y(:,4)./(soln.y(:,3)+soln.y(:,4));
        soln.py(:,5)=soln.y(:,5)./(soln.y(:,5)+soln.y(:,6));
        soln.py(:,6)=soln.y(:,6)./(soln.y(:,5)+soln.y(:,6));
        soln.py(:,7)=soln.y(:,7)./(soln.y(:,7)+soln.y(:,8));
        soln.py(:,8)=soln.y(:,8)./(soln.y(:,7)+soln.y(:,8));
        soln.py(:,9)=soln.y(:,9)./(soln.y(:,9)+soln.y(:,10));
        soln.py(:,10)=soln.y(:,10)./(soln.y(:,9)+soln.y(:,10));
        soln.py(:,11)=soln.y(:,11)./(soln.y(:,11)+soln.y(:,12));
        soln.py(:,12)=soln.y(:,12)./(soln.y(:,11)+soln.y(:,12));
        soln.py(:,13)=soln.y(:,13)./(soln.y(:,13)+soln.y(:,14));
        soln.py(:,14)=soln.y(:,14)./(soln.y(:,13)+soln.y(:,14));
    %soln.py=soln.py';
    %soln.y=soln.y';
%     plot(soln.x,soln.y(2:2:8,:))
%     legend
%     figure
%     plot(soln.x,soln.py(2:2:8,:))
%     legend
else
    soln=zeros(size(yzero));
end
%% Return quantities to analyze
QOIs=NaN(1,length(qnames));
for i=1:length(qnames)
    switch qnames{i}
%         case 'Final Number of Infected DV'
%              QOIs(i) = QOI_DV_number_infected_final_time(soln);
%              W=1;
        case 'Algebraic I^*_{DV} Error'
            QOIs(i)=QOI_Algebraic_Equil_Err(params);
        case 'Algebraic I^*_{DV}/_{N^*_{DV}} Error'
            QOIs(i)=QOI_Algebraic_Equil_PerErr(params);
        case 'Infected Feedings per Person per Day Error' 
             QOIs(i)= QOI_num_infected_feedings_per_humanErr(params,soln,POIs,select,baseParams);
        case 'Percent Error in Human Risk Estimation' 
             QOIs(i)= QOI_num_infected_feedings_per_humanErrProp(params,soln,POIs,select,baseParams);
        case 'Infected Feedings per Person per Day'
             QOIs(i)= QOI_num_infected_feedings_per_human(params,soln);
        case 'Number I_{DV} at equilibirium'
             QOIs(i)= QOI_DV_num_infected_final_time(soln);
        case 'Proportion I_{DV} at equilibirium'
             QOIs(i)= QOI_DV_prop_infected_final_time(soln);
        case 'Proportion I_{DD} at equilibirium'
             QOIs(i)= QOI_DD_prop_infected_final_time(soln);
        case 'Proportion I_{DR} at equilibirium'
             QOIs(i)= QOI_DR_prop_infected_final_time(soln);
        case 'Proportion I_{DS} at equilibirium'
             QOIs(i)= QOI_DS_prop_infected_final_time(soln);
%         case 'Number of I_{DV} at t=5'
%              QOIs(i) = QOI_DV_number_infected_fixed_time(soln,5);
        case 'Proportion I_{DV} at t=1'
             QOIs(i) = QOI_DV_prop_infected_fixed_time(soln,1);
        case 'R_0'
             QOIs(i) = QOI_R0(params,'numeric');
        case 'Derived Params'
            QOIs(i)=QOI_Derived_Params(params);
        case 'Error in R_0'
            QOIs(i)=QOI_R0Error(params,POIs,select,baseParams);
        case 'Proportion I_{DV} at equilibirium Error'
            QOIs(i)=QOI_DV_prop_infected_final_timeErr(soln,POIs,select,baseParams);
        case 'Time Derivatives'
            QOIs(i)=QOI_Time_Derivatives(soln,params);            
        case 'Time Derivatives at t=0'
            QOIs(i)=QOI_Time_Derivatives(soln,params,0);
        case 'Time Derivatives at Equil'
            QOIs(i)=QOI_Time_Derivatives(soln,params,max(soln.x));
        case 'Time Derivatives Err'
            QOIs(i)=QOI_Time_DerivativesErr(soln,POIs,select,baseParams);            
        case 'Time Derivatives at t=0 Err'
            QOIs(i)=QOI_Time_DerivativesErr(soln,POIs,select,baseParams,0);
        case 'Time Derivatives at Equil Err'
            QOIs(i)=QOI_Time_DerivativesErr(soln,POIs,select,baseParams,max(soln.x));
    otherwise
        error(['ERROR!!! ',qnames{i},' could not be identified as a QOI'])
    end
    %QOIs = QOIs'; % as col
end
end