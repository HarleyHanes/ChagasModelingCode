clear; close all;
%Generate Params
    ParamSettings.paramset='scaled';
    params=Gen2_params(ParamSettings);
    N=params.N;
    c.SS_ST=N.SS/(N.SS+N.SR); c.DS_DT=N.DS/(N.SS+N.SR);
    c.DD_DH=N.DD/(N.DD+N.SS+N.SR);
    %Inits
    d.SS=params.fracinfect.SS; d.SR=params.fracinfect.SR; 
    d.DS=params.fracinfect.DS; d.DR=params.fracinfect.DR;
    d.DD=params.fracinfect.DD;
    PopProportions.c=c;
    PopProportions.d=d;

    ODE10Params=CG2toODE10params(params,PopProportions);

    SmallParams=CG2toCG1params(params,PopProportions);
%Run Model


    POIs=0;%;[.0001,.00001]; 
    select.QOI={'Proportion I_{DV} at equilibirium','R_0'};
    select.POI={"null"};%{"\gamma_{SV}", "\gamma_{DV}"};
    [QOIsTrue,solnTrue]=BBB_Chagas_Gen2_model(POIs,select,params);
    [QOIs10,soln10]=BBB_Chagas_Gen2_model(POIs,select,ODE10Params);
    [QOIsSmall,solnSmall]=BBB_Chagas_Gen2_model(POIs,select,SmallParams);
    
    figure
    plot(solnTrue.x, solnTrue.y(:,2))
    hold on
    plot(solnTrue.x,soln10.y(:,2))
    hold on
    plot(solnTrue.x,solnSmall.y(:,2))
    legend('14 ODEs','10 ODEs', '8 ODEs')
    title('Infected Vectors')
    
    figure
    plot(solnTrue.x, solnTrue.y(:,4)+solnTrue.y(:,6))
    hold on
    plot(solnTrue.x,soln10.y(:,4))
    hold on
    plot(solnTrue.x,solnSmall.y(:,4))
    legend('14 ODEs','10 ODEs', '8 ODEs')
    title('Infected Sylvatic Hosts')

    figure
    plot(solnTrue.x, solnTrue.y(:,10)+solnTrue.y(:,12)++solnTrue.y(:,14))
    hold on
    plot(solnTrue.x,soln10.y(:,10)+solnTrue.y(:,14))
    hold on
    plot(solnTrue.x,solnSmall.y(:,10))
    legend('14 ODEs','10 ODEs', '8 ODEs')
    title('Infected Peridomestic Hosts')
    
    figure
    plot(solnTrue.x, sum(solnTrue.y(:,3:6),2))
    hold on
    plot(solnTrue.x,sum(solnTrue.y(:,3:6),2))
    hold on
    plot(solnTrue.x,sum(solnTrue.y(:,3:6),2))
    legend('14 ODEs','10 ODEs', '8 ODEs')
    title('Total Sylvatic Hosts')

    figure
    plot(solnTrue.x, sum(solnTrue.y(:,9:14),2))
    hold on
    plot(solnTrue.x,sum(solnTrue.y(:,9:14),2))
    hold on
    plot(solnTrue.x,sum(solnTrue.y(:,9:14),2))
    legend('14 ODEs','10 ODEs', '8 ODEs')
    title('Total Peridomestic Hosts')
%% Test no synanthropes

ParamSettings.paramset='scaled';
params=Gen2_params(ParamSettings);
params.N.SS=0;params.N.DS=0;
params.init(3:4,1)=zeros(2,1); params.init(7:8,1)=zeros(2,1);
POIs=0;%;[.0001,.00001]; 
select.QOI={'Proportion I_{DV} at equilibirium','R_0'};
select.POI={"null"};%{"\gamma_{SV}", "\gamma_{DV}"};
[QOIsTrue,solnTrue]=BBB_Chagas_Gen2_model(POIs,select,params);
