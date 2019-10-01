function time_Imax = QOI_DTtime_Imax(POIs, ode_soln)
% input: POIs and ode_soln structure from ode solver
% output: time the epidemic peaks

[~,index]=max(ode_soln.y(8,:));
time_Imax = ode_soln.x(index);

end