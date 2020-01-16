function Err = QOI_DV_prop_infected_final_timeErr(ode_soln,truesoln)
% input: POIs and old_soln structure from ode solver
% output: return the proportion of infected DV
% by the end of the calculation

Err=QOI_DV_prop_infected_final_time(ode_soln)-truesoln;
end
