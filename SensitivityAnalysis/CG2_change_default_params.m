function str= CG2_change_default_params(str)
%% QOI_change_default_params change default parameters
%Load parameters
    str.baseParams=Gen2_params(str.ParamSettings);
        alpha=str.baseParams.alpha;
        beta=str.baseParams.beta;
        b=str.baseParams.b;
        r=str.baseParams.r;
        lambda=str.baseParams.lambda;
        gamma=str.baseParams.gamma;
        %SelectModel 
        str.QOI_model_eval = @BBB_Chagas_Gen2_model;
switch str.QOI_model_name
    case 'lambda'
        %Select POI's and QOI's
        str.POI_names =  {'\lambda_R','\lambda_S','\lambda_V'};
                      str.nPOI=length(str.POI_names);
        str.QOI_names =  {'Proportion I_{DV} at equilibirium', 'R_0'};
        str.nQOI=length(str.QOI_names);
        
        %Set parameter Sampling
        str.POI_baseline=[lambda.R lambda.S lambda.V]';
        if length(str.POI_baseline)~=str.nPOI
            error("Different number of parameters named than entered")
        end
        str.POI_min=zeros(size(str.POI_baseline));
        str.POI_max=str.POI_baseline+.8*str.POI_baseline;
        str.POI_mode=str.POI_baseline;
    case 'Vec Infection'
        str.POI_names={'\alpha^{SS}_{SV}' '\alpha^{SR}_{SV}' '\alpha^{DS}_{DV}'...
            '\alpha^{DR}_{DV}' '\alpha^{DD}_{DV}'};
        str.QOI_names =  {'Proportion I_{DV} at equilibirium', 'R_0'};
        str.nQOI=length(str.QOI_names);
        str.nPOI=length(str.POI_names);
        
        
        str.POI_baseline=[alpha.SS_SV alpha.SR_SV alpha.DS_DV alpha.DR_DV alpha.DD_DV]';
        if length(str.POI_baseline)~=str.nPOI
            error("Different number of parameters named than entered")
        end
        str.POI_min=str.POI_baseline-.8*str.POI_baseline;
        str.POI_max=str.POI_baseline+.8*str.POI_baseline;
        str.POI_mode=str.POI_baseline;
    case 'Host Infection'
                str.POI_names={'\alpha^{SV}_{SS}' '\alpha^{SV}_{SR}' '\alpha^{DV}_{DS}'...
            '\alpha^{DV}_{DR}' '\alpha^{DV}_{DD}' '\beta^{SV}_{SS}' '\beta^{SV}_{SR}'...
            '\beta^{DV}_{DS}' '\beta^{DV}_{DR}' '\beta^{DV}_{DD}'};
        str.QOI_names =  {'Proportion I_{DV} at equilibirium', 'R_0'};
        str.nQOI=length(str.QOI_names);
        str.nPOI=length(str.POI_names);
        
        
        str.POI_baseline=[alpha.SV_SS alpha.SV_SR alpha.DV_DS alpha.DV_DR alpha.DV_DD...
            beta.SV_SS beta.SV_SR beta.DV_DS beta.DV_DR beta.DV_DD]';
        if length(str.POI_baseline)~=str.nPOI
            error("Different number of parameters named than entered")
        end
        str.POI_min=str.POI_baseline-.8*str.POI_baseline;
        str.POI_max=str.POI_baseline+.8*str.POI_baseline;
        str.POI_mode=str.POI_baseline;
    case 'All Infection'
        str.POI_names={'\alpha^{SS}_{SV}' '\alpha^{SR}_{SV}' '\alpha^{DS}_{DV}'...
            '\alpha^{DR}_{DV}' '\alpha^{DD}_{DV}' '\alpha^{SV}_{SS}' '\alpha^{SV}_{SR}' '\alpha^{DV}_{DS}'...
            '\alpha^{DV}_{DR}' '\alpha^{DV}_{DD}' '\beta^{SV}_{SS}' '\beta^{SV}_{SR}'...
            '\beta^{DV}_{DS}' '\beta^{DV}_{DR}' '\beta^{DV}_{DD}'};
        %str.QOI_names =  {'Proportion I_{DV} at equilibirium', 'R_0'};
        str.QOI_names={'R_0'};
        str.nQOI=length(str.QOI_names);
        str.nPOI=length(str.POI_names);
        
        
        str.POI_baseline=[alpha.SS_SV alpha.SR_SV alpha.DS_DV alpha.DR_DV alpha.DD_DV...
            alpha.SV_SS alpha.SV_SR alpha.DV_DS alpha.DV_DR alpha.DV_DD...
            beta.SV_SS beta.SV_SR beta.DV_DS beta.DV_DR beta.DV_DD]';
        if length(str.POI_baseline)~=str.nPOI
            error("Different number of parameters named than entered")
        end
        str.POI_min=str.POI_baseline-.8*str.POI_baseline;
        str.POI_max=str.POI_baseline+.8*str.POI_baseline;
        str.POI_mode=str.POI_baseline;
        
    otherwise
        error([' str.QOI_model =',str.QOI_model,' is not available'])
end

%Set Common Properties
    %Sampling
    str.POI_pdf='beta';% uniform triangle beta
    str.number_ESA_samples = 15;
    
    %Pass selected parameters to ODE
    str.select.POI=str.POI_names;
    str.select.QOI=str.QOI_names;
end