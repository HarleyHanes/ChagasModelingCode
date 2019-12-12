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
        str.POI_names={'\alpha^{SS}_{SV}' '\alpha^{SR}_{SV}' '\alpha^{DS}_{DV}' '\alpha^{DR}_{DV}' '\alpha^{DD}_{DV}'};
        
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