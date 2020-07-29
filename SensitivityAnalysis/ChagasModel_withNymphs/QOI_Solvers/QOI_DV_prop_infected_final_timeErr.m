function Err = QOI_DV_prop_infected_final_timeErr(ode_soln,POIs,select,baseParams)
% input: POIs and old_soln structure from ode solver
% output: return the proportion of infected DV
% by the end of the calculation
select.model='full';
select.QOI={'Proportion I_{DV} at equilibirium'};
[QOIs,~] = BBB_Chagas_Gen2_model(POIs,select,baseParams);
Err=QOI_DV_prop_infected_final_time(ode_soln)-QOIs;
end
