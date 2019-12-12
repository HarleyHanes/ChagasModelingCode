function [QOIs,soln] = BBB_Chagas_Gen2_model(POIs,select,baseParams)
% This takes parameters, solves the ODE and returns desired quantities
qnames=select.QOI;
pnames=select.POI;
%% Initialize ODE solver
% convert the list of POIs into model variable names
% POIs will be same parameters as being optimized
params = get_p_struct_CG2(POIs,pnames,baseParams);
%params=baseParams;


% initial conditions for y=(S_SV, I_SV S_SS I_SS S_SR I_SR S_DV I_DV S_DR I_DR S_DD I_DD)
yzero=params.init;
% final integration time
tspan=params.tspan;

% Bake the parameters into ode_rhs (aka currying)
yzero = balance_model(yzero, params);
dydt_fn = @(t,y) Chagas_Gen2_ODEs(t, y, params);
%% Solve ODE
if ~(strcmpi(qnames{1},'R_0') && length(qnames)==1)
%soln = ode23tb(dydt_fn, tspan, yzero);
[soln.x,soln.y]=ode45(dydt_fn, tspan, yzero);
%soln.y=soln.y'
        soln.py(:,1)=soln.y(:,1)./(soln.y(:,1)+soln.y(:,2));
        soln.py(:,2)=soln.y(:,2)./(soln.y(:,1)+soln.y(:,2));
        soln.py(:,3)=soln.y(:,3)./(soln.y(:,3)+soln.y(:,4));
        soln.py(:,4)=soln.y(:,4)./(soln.y(:,3)+soln.y(:,4));
        soln.py(:,5)=soln.y(:,5)./(soln.y(:,5)+soln.y(:,6));
        soln.py(:,6)=soln.y(:,6)./(soln.y(:,5)+soln.y(:,6));
        soln.py(:,7)=soln.y(:,7)./(soln.y(:,7)+soln.y(:,8));
        soln.py(:,8)=soln.y(:,8)./(soln.y(:,7)+soln.y(:,8));
        soln.py(:,9)=soln.y(:,9)./(soln.y(:,9)+soln.y(:,10));
        soln.py(:,10)=soln.y(:,10)./(soln.y(:,9)+soln.y(:,10));
        soln.py(:,11)=soln.y(:,11)./(soln.y(:,11)+soln.y(:,12));
        soln.py(:,12)=soln.y(:,12)./(soln.y(:,11)+soln.y(:,12));
        soln.py(:,13)=soln.y(:,13)./(soln.y(:,13)+soln.y(:,14));
        soln.py(:,14)=soln.y(:,14)./(soln.y(:,13)+soln.y(:,14));
    %soln.py=soln.py';
    %soln.y=soln.y';
%     plot(soln.x,soln.y(2:2:8,:))
%     legend
%     figure
%     plot(soln.x,soln.py(2:2:8,:))
%     legend
end
%% Return quantities to analyze
QOIs=NaN(1,length(qnames));
for i=1:length(qnames)
    switch qnames{i}
%         case 'Final Number of Infected DV'
%              QOIs(i) = QOI_DV_number_infected_final_time(soln);
%              W=1;
        case 'Proportion I_{DV} at equilibirium'
             QOIs(i)= QOI_DV_prop_infected_final_time(soln);
%         case 'Number of I_{DV} at t=5'
%              QOIs(i) = QOI_DV_number_infected_fixed_time(soln,5);
        case 'Proportion I_{DV} at t=1'
             QOIs(i) = QOI_DV_prop_infected_fixed_time(soln,1);
        case 'R_0'
             QOIs(i) = QOI_R0(params,'numeric');
        case 'Derived Params'
            QOIs(i)=QOI_Derived_Params(params);
    otherwise
        error(['ERROR!!! ',qnames{i},' could not be identified as a QOI'])
    end
    %QOIs = QOIs'; % as col
end
end