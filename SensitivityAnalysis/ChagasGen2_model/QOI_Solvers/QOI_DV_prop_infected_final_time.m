function prop_infected = QOI_DV_prop_infected_final_time(ode_soln)
% input: POIs and old_soln structure from ode solver
% output: return the proportion of infected DV
% by the end of the calculation

prop_infected = ode_soln.y(end,8)/(ode_soln.y(end,8)+ode_soln.y(end,7));

end
