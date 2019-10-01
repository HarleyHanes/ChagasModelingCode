function inf_at_time_tinf = QOI_DV_number_infected_fixed_time(ode_soln,tinf)
% input: POIs and old_soln structure from ode solver
% output: number of people infected at time t=tinf

% use piecewise Hermite interpolation 
inf_at_time_tinf = interp1(ode_soln.x,ode_soln.y(8,:),tinf);

end