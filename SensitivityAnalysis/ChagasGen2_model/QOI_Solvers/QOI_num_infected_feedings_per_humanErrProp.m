function Err = QOI_num_infected_feedings_per_humanErrProp(params,ode_soln,POIs,select,baseParams)
% input: POIs and old_soln structure from ode solver
% output: return the proportion of infected DV
% by the end of the calculation
%Params
numContacts = QOI_num_infected_feedings_per_human(params,ode_soln);
select.model='full';
select.QOI={'Infected Feedings per Person per Day'};
[QOIs,~] = BBB_Chagas_Gen2_model(POIs,select,baseParams);
Err=(numContacts-QOIs)/(QOIs)*100;
end
