function total_infected = QOI_DV_number_infected_final_time(ode_soln)
% input: POIs and old_soln structure from ode solver
% output: return the final number of people who have been infected
% by the end of the calculation

total_infected = ode_soln.y(8,end);

end
