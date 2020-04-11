function numContacts = QOI_num_infected_feedings_per_human(params,ode_soln)
% input: POIs and old_soln structure from ode solver
% output: return the proportion of infected DV
% by the end of the calculation
numContacts = ode_soln.y(end,8)*params.bio.rho.Humans*params.bio.b.Vector/params.N.Humans;

end
