%% Optomize host and vector infection rates

%Find scaling parameters
%initScale=[0.4533 0.0009 0.0087 0.0021 0.0117 0.0001];
%initScale=[.5,.5,.5,.5,.5,.5];
initScale=[.5, .001, .01, .001,.01,  .0005];

%Run lsq nonlin
%%Scale=lsqnonlin(@(scale)OptomizeInfection(scale),initScale)
Scale=fminsearch(@(scale)OptomizeInfection(scale,1),initScale);

%Plot model with scaling
params=Gen2_params;
alpha=params.alpha;
params.tmax=60;
%Apply Scaling
    %Hosts
    alpha.SV_SS=alpha.SV_SS*Scale(2);%.000788;
    alpha.SV_SR=alpha.SV_SR*Scale(3);%.0057;
    alpha.DV_DS=alpha.DV_DS*Scale(4);%.000788;
    alpha.DV_DR=alpha.DV_DR*Scale(5);%.0057;
    alpha.DV_DD=alpha.DV_DD*Scale(6);%000161;
    %Vectors  
    alpha.SS_SV=alpha.SS_SV*Scale(1);%.000788;
    alpha.SR_SV=alpha.SR_SV*Scale(1);%.0057;
    alpha.DS_DV=alpha.DS_DV*Scale(1);%.000788;
    alpha.DR_DV=alpha.DR_DV*Scale(1);%.0057;
    alpha.DD_DV=alpha.DD_DV*Scale(1);%000161;
%Load Scaled params
params.alpha=alpha;
%Run model
POIs=0;%;[.0001,.00001]; 
select.QOI={'Proportion I_{DV} at equilibirium'};
    select.POI=cell(1);
select.POI{1}="null";%{"\gamma_{SV}", "\gamma_{DV}"};
[~,soln]=BBB_Chagas_Gen2_model(POIs,select,params);
figure
hold on
%Plot Vectors
plot(soln.x(1:10:end)/365,soln.py(1:10:end,2),"r--","MarkerSize",2)
plot(soln.x(1:10:end)/365,soln.py(1:10:end,8),"r:","MarkerSize",2)
%plot Synanthropes
plot(soln.x(1:10:end)/365,soln.py(1:10:end,4),"b--","MarkerSize",2)
plot(soln.x(1:10:end)/365,soln.py(1:10:end,10),"b:","MarkerSize",2)
%Plot Rodents
plot(soln.x(1:10:end)/365,soln.py(1:10:end,6),"m--","MarkerSize",2)
plot(soln.x(1:10:end)/365,soln.py(1:10:end,12),"m:","MarkerSize",2)
%Plot Pets
plot(soln.x(1:10:end)/365,soln.py(1:10:end,14),"k:","MarkerSize",.2)
legend("I_{SV}","I_{DV}","I_{SS}","I_{DS}","I_{SR}","I_{DR}","I_{DD}","Interpreter","LaTex")
%legend("SV","SS","SR","DV","DS","DR","DD")
xlabel('Years')
ylabel('Proportion Infected')



%function
function pyError=OptomizeInfection(Scale,printBool)
params=Gen2_params;
alpha=params.alpha;
%Apply Scaling
    %Hosts
    alpha.SV_SS=alpha.SV_SS*Scale(2);%.000788;
    alpha.SV_SR=alpha.SV_SR*Scale(3);%.0057;
    alpha.DV_DS=alpha.DV_DS*Scale(4);%.000788;
    alpha.DV_DR=alpha.DV_DR*Scale(5);%.0057;
    alpha.DV_DD=alpha.DV_DD*Scale(6);%000161;
    %Vectors  
    alpha.SS_SV=alpha.SS_SV*Scale(1);%.000788;
    alpha.SR_SV=alpha.SR_SV*Scale(1);%.0057;
    alpha.DS_DV=alpha.DS_DV*Scale(1);%.000788;
    alpha.DR_DV=alpha.DR_DV*Scale(1);%.0057;
    alpha.DD_DV=alpha.DD_DV*Scale(1);%000161;
%Load Scaled params
params.alpha=alpha;
%Run model
POIs=0;%;[.0001,.00001]; 
select.QOI={'Proportion I_{DV} at equilibirium'};
    select.POI=cell(1);
select.POI={"null"};%{"\gamma_{SV}", "\gamma_{DV}"};
[~,soln]=BBB_Chagas_Gen2_model(POIs,select,params);
pyPredicted=soln.py(end,2:2:14);

%Add error terms
    %weigting
        weights=[1 1 1 1 1 1 1];
    %Tikinov
        lambdaTikinov=1e-6;
    %negative penalty for Scalings
        lambdaNeg=100;
pyExpected=[.75 .5 .15 .75 .5 .15 .16];
pyError=sum(((pyPredicted-pyExpected).*weights).^2)+... %Nonlin-LeastSquares
    lambdaTikinov*sum((pyPredicted-[1 1 1 1 1 1 1]).^2)+... %Tikinov Regularization
    lambdaNeg*sum(Scale(Scale<0).^2);
%pyError=pyError(1);
if printBool
    fprintf(['\nPredicted Scalings: [%.3g, %.3g, %.3g, %.3g, %.3g, %.3g]\n'...
             'pyError: %.4g\n'],...
             Scale,pyError)
end
end