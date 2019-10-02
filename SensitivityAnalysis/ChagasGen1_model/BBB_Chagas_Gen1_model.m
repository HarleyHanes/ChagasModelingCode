function [QOIs,soln] = BBB_Chagas_Gen1_model(POIs,select)
% This takes parameters, solves the ODE and returns desired quantities
qnames=select.QOI;
pnames=select.POI;
%% Initialize ODE solver
% convert the list of POIs into model variable names
% POIs will be same parameters as being optimized
params = get_p_struct_CG1(POIs,pnames);
%params=baseline_params();
% initial conditions for y=(S1_h, S2_h, I1_h, I2_h, R1_h, R2_h, S_v, E_v, I_v) )
yzero=get_init_CG1(params);
% final integration time

tspan=params.tspan;

% Bake the parameters into ode_rhs (aka currying)
yzero = balance_model(yzero, params);
dydt_fn = @(t,y) Chagas_Gen1_ODEs(t, y, params);
%% Solve ODE

%soln = ode23tb(dydt_fn, tspan, yzero);
[soln.x,soln.y]=ode45(dydt_fn, tspan, yzero);
%soln.y=soln.y'
        soln.py(:,1)=soln.y(:,1)./(soln.y(1,1)+soln.y(1,2));
        soln.py(:,2)=soln.y(:,2)./(soln.y(1,1)+soln.y(1,2));
        soln.py(:,3)=soln.y(:,3)./(soln.y(1,3)+soln.y(1,4));
        soln.py(:,4)=soln.y(:,4)./(soln.y(1,3)+soln.y(1,4));
        soln.py(:,5)=soln.y(:,5)./(soln.y(1,5)+soln.y(1,6));
        soln.py(:,6)=soln.y(:,6)./(soln.y(1,5)+soln.y(1,6));
        soln.py(:,7)=soln.y(:,7)./(soln.y(1,7)+soln.y(1,8));
        soln.py(:,8)=soln.y(:,8)./(soln.y(1,7)+soln.y(1,8));
    soln.py=soln.py';
    soln.y=soln.y';
%     plot(soln.x,soln.y(2:2:8,:))
%     legend
%     figure
%     plot(soln.x,soln.py(2:2:8,:))
%     legend
%% Return quantities to analyze
QOIs=NaN(1,length(qnames));
for i=1:length(qnames)
    W=0;
    switch qnames{i}
        case 'Final Number of Infected DV'
             QOIs(i) = QOI_DV_number_infected_final_time(soln);
             W=1;
        case 'Proportion I_{DV} at equilibirium'
             QOIs(i)= QOI_DV_prop_infected_final_time(soln);
             W=1;
        case 'Number of I_{DV} at t=5'
             QOIs(i) = QOI_DV_number_infected_fixed_time(soln,5);
             W=1;
        case 'Proportion I_{DV} at t=5'
             QOIs(i) = QOI_DV_prop_infected_fixed_time(soln,5);
             W=1;
        case 'R_0'
             QOIs(i) = QOI_R0(params,'numeric');
             W=1;
    end
    if W==0
        error(['ERROR!!! ',qnames{i},' could not be identified as a QOI'])
    end
    %QOIs = QOIs'; % as col
end
end