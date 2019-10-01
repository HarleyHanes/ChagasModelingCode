function QOIs = Big_Black_Box_Chagas_model(POIs,Ref)
% This takes parameters, solves the ODE and returns desired quantities

%% Initialize ODE solver
params=baseline_params();
%initialize conditions
yzero=params.init(1:8);
% final integration time
tspan=params.tspan;

%Redefine parameters based on POIs
for i=1:length(Ref)
    switch Ref(i)
%        case 1+i
%            params.theta.ST_SV=POIs(i);
%            params.theta.DT_SV=POIs(i)/5;
%            params.theta.DT_DV=POIs(i);
%            params.theta.ST_DV=POIs(i);
        case 1
            params.theta.ST_SV=POIs(i);
        case 2
            params.theta.DT_SV=POIs(i);
%        case 3+i
%            params.theta.SV_ST=POIs(i);
%            params.theta.DV_ST=POIs(i)/5;
%            params.theta.DV_DV=POIs(i);
%            params.theta.SV_DV=POIs(i)/5;
        case 3
            params.theta.SV_ST=POIs(i);
        case 4
            params.theta.DV_ST=POIs(i);
        case 5
            params.theta.ST_DV=POIs(i);
        case 6
            params.theta.DT_DV=POIs(i);
        case 7
            params.theta.SV_DT=POIs(i);
        case 8
            params.theta.DV_DT=POIs(i);
        case 9
            params.lambda.SV_DV=POIs(i);
        case 10
            params.lambda.ST_DT=POIs(i);
        case 11
            params.mu.SV=POIs(i);
        case 12
            params.mu.ST=POIs(i);
        case 13
            params.mu.DV=POIs(i);
        case 14
            params.mu.DT=POIs(i);            
    end
end

%I skipped this but may need to reassing
% convert the list of POIs into model variable names
%    beta = POIs(1);
%    gamma = POIs(2);
% Bake the parameters into sir_ode_rhs (aka currying)
dydt_fn = @(t,y) Chagas_Gen1ODEs(t, y, params);

%% Solve ODE
%soln = ode23tb(dydt_fn, tspan, yzero);
[soln.x,soln.y]=params.session.solver(dydt_fn, tspan, yzero);
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
%% Return quantities to analyze
QOIs(1) = QOI_DTtotal_infected_final_time(params, soln); % Total infected a tfinal
    %I think this may lose some meaning for our's
QOIs(2) = QOI_DTinf_at_fixed_time(params, soln);
%QOIs(2) = QOI_DTtime_Imax(params, soln); % number infected at a fixed time
QOIs(3) = QOI_R0(params, soln); % R0 for basic SIR
QOIs = QOIs'; % as col
end