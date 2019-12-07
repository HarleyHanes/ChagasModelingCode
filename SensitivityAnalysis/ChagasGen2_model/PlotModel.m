%Plot Chagas Model
clear;

params=baseline_params;
soln=BBB_Chagas_Gen2_model(params);
plot(soln.x/365,soln.py(:,2:2:end))
legend("SV","SS","SR","DV","DS","DR","DD")
xlabel('Years')
ylabel('% Infected')
soln.py(end,2:2:end)