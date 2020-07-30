function str= CG1_change_default_params(str)
%% QOI_change_default_params change default parameters
%Load parameters
    str.baseParams=Gen1_params(str.ParamSettings);
        alpha=str.baseParams.alpha;
        lambda=str.baseParams.lambda;
        gamma=str.baseParams.gamma;
switch str.QOI_model_name
    case 'lambda'
        %Select POI's and QOI's
        str.POI_names =  {'\lambda_H','\lambda_V'};
                      str.nPOI=length(str.POI_names);
        str.QOI_names =  {'Proportion I_{DV} at equilibirium','Proportion I_{DV} at t=5', 'R_0'};
        str.nQOI=length(str.QOI_names);
        
        %SelectModel 
        str.QOI_model_eval = @BBB_Chagas_Gen1_model;
        
        %Set parameter Sampling
        str.POI_baseline=[lambda.H lambda.V]';
        if length(str.POI_baseline)~=str.nPOI
            error("Different number of parameters named than entered")
        end
        str.POI_min=str.POI_baseline-.8*str.POI_baseline;
        str.POI_max=str.POI_baseline+.8*str.POI_baseline;
        str.POI_mode=str.POI_baseline;
    case 'PopParm'
        %Select POIs and QOIs
        str.POI_names =  {'\lambda_H','\lambda_V','\mu_{SH}','\mu_{SV}','\mu_{DH}','\mu_{DV}'};
              str.nPOI=length(str.POI_names);
        str.QOI_names = {'Proportion I_{DV} at equilibirium','Proportion I_{DV} at t=5', 'R_0'};
            str.nQOI=length(str.QOI_names);
        
        %Select Model
        str.QOI_model_eval = @BBB_Chagas_Gen1_model;        

        %Set Parameter Ranges
        str.POI_baseline=[lambda.H lambda.V mu.SH mu.SV mu.DH mu.DV ]';
        %str.POI_baseline=[.05 .05 .83/365 .271/365 .83/365 .271/365 ]';
        if length(str.POI_baseline)~=str.nPOI
            error("Different number of parameters named than entered")
        end
        str.POI_min=str.POI_baseline-.8*str.POI_baseline;
        str.POI_max=str.POI_baseline+.8*str.POI_baseline;
        str.POI_min(1:2)=0;                      %Set a wider sampling range
        str.POI_max(1:2)=2*str.POI_baseline(1:2);%for lambdas
        str.POI_mode=str.POI_baseline;
        %Set Sampling
        str.POI_pdf='beta';% uniform triangle beta
        str.number_ESA_samples = 30;
    case 'Thetas'
        %Select POIs and QOIs
        str.POI_names =  {'\theta^{SV}_{SH}','\theta^{DV}_{SH}','\theta^{SH}_{SV}','\theta^{DH}_{SV}',...
                          '\theta^{SV}_{DH}','\theta^{DV}_{DH}','\theta^{SH}_{DV}','\theta^{DH}_{DV}'};
            str.nPOI=length(str.POI_names);
        str.QOI_names =  {'Proportion I_{DV} at equilibirium','Proportion I_{DV} at t=5', 'R_0'};
            str.nQOI=length(str.QOI_names);
        str.QOI_model_eval = @BBB_Chagas_Gen1_model;
        
        %Set parameter ranges
        str.POI_baseline=[theta.SV_SH theta.DV_SH theta.SH_SV theta.DH_SV...
                          theta.SV_DH theta.DV_DH theta.SH_DV theta.DH_DV]';
        %str.POI_baseline=[.01 .002 .01 .002 .002 .01 .002 .01]';
        if length(str.POI_baseline)~=str.nPOI
            error("Different number of parameters named than entered")
        end
        str.POI_min=str.POI_baseline-.5*str.POI_baseline;
        str.POI_max=str.POI_baseline+.5*str.POI_baseline;
        str.POI_mode=str.POI_baseline;
    case 'Full'
        %Select POIs and QOIs
        str.POI_names =  {'\alpha^{SV}_{SH}','\alpha^{DV}_{SH}','\alpha^{SH}_{SV}','\alpha^{DH}_{SV}',...
                          '\alpha^{SV}_{DH}','\alpha^{DV}_{DH}','\alpha^{SH}_{DV}','\alpha^{DH}_{DV}',...
                          '\lambda_H','\lambda_V','\gamma_{SH}','\gamma_{SV}','\gamma_{DH}','\gamma_{DV}'};
            str.nPOI=length(str.POI_names);
        str.QOI_names =  {'Proportion I_{DV} at equilibirium','Proportion I_{DV} at t=1', 'R_0'};
            str.nQOI=length(str.QOI_names);
        
        %Select Model
        str.QOI_model_eval = @BBB_Chagas_Gen1_model;
        
        %Set ESA and GSA Ranges
        str.POI_baseline=[alpha.SV_SH alpha.DV_SH alpha.SH_SV alpha.DH_SV...
                          alpha.SV_DH alpha.DV_DH alpha.SH_DV alpha.DH_DV ...
                          lambda.H lambda.V gamma.SH gamma.SV gamma.DH gamma.DV ]';
        %str.POI_baseline=[.01 .002 .01 .002 .002 .01 .002 .01]';
        if length(str.POI_baseline)~=str.nPOI
           	error("Different number of parameters named than entered")
        end
        str.POI_min=str.POI_baseline-.75*str.POI_baseline;
        str.POI_max=str.POI_baseline+.75*str.POI_baseline;
        str.POI_min(9:10)=0;
        str.POI_max(9:10)=2*str.POI_baseline(9:10);
        str.POI_mode=str.POI_baseline;
    case 'Vis Project'
        %Select POIs and QOIs
        str.POI_names =  {'\alpha^{SV}_{SH}','\alpha^{SH}_{SV}',...
                          '\alpha^{DV}_{DH}','\alpha^{DH}_{DV}',...
                          '\lambda_V','\gamma_{DV}'};
            str.nPOI=length(str.POI_names);
        str.QOI_names =  {'Proportion I_{DV} at equilibirium','Proportion I_{DV} at t=1', 'R_0'};
            str.nQOI=length(str.QOI_names);
        
        %Select Model
        str.QOI_model_eval = @BBB_Chagas_Gen1_model;
        
        %Set ESA and GSA Ranges
        str.POI_baseline=[alpha.SV_SH alpha.SH_SV ...
                          alpha.DV_DH  alpha.DH_DV ...
                          lambda.V gamma.DV ]';
        %str.POI_baseline=[.01 .002 .01 .002 .002 .01 .002 .01]';
        if length(str.POI_baseline)~=str.nPOI
           	error("Different number of parameters named than entered")
        end
        str.POI_min=str.POI_baseline-.75*str.POI_baseline;
        str.POI_max=str.POI_baseline+.75*str.POI_baseline;
        str.POI_min(5)=0;
        str.POI_max(5)=2*str.POI_baseline(5);
        str.POI_mode=str.POI_baseline;
    case 'Chagas-Gen1-ConstrainedTrans' %Note: meant to be used with InvestigateLambda
        %Select POIs and QOIs
        str.POI_names =  {'\theta^{SV}_{SH}','\theta^{SH}_{SV}',...
                          '\theta^{DV}_{DH}','\theta^{DH}_{DV}',...
                          '\lambda_H','\lambda_V','\mu_{SH}',...
                          '\mu_{SV}','\mu_{DH}','\mu_{DV}'};
            str.nPOI=length(str.POI_names);
        str.QOI_names =  {'Proportion I_{DV} at equilibirium','Proportion I_{DV} at t=5', 'R_0'};
            str.nQOI=length(str.QOI_names);
            
        %Select Model
        str.QOI_model_eval = @BBB_Chagas_Gen1_model;
        
        %Set Parameter Settings
        str.POI_baseline=[theta.SV_SH  theta.SH_SV theta.DV_DH  theta.DH_DV ...
                          lambda.H lambda.V mu.SH mu.SV mu.DH mu.DV ]';
        %str.POI_baseline=[.01 .002 .01 .002 .002 .01 .002 .01]';
        if length(str.POI_baseline)~=str.nPOI
            error("Different number of parameters named than entered")
        end
        str.POI_min=str.POI_baseline-.75*str.POI_baseline;
        str.POI_max=str.POI_baseline+.75*str.POI_baseline;
        str.POI_min(5:6)=0;
        str.POI_max(5:6)=str.POI_baseline(5:6);
        str.POI_mode=str.POI_baseline;
    case 'AssessLambda'
        %Select POIs and QOIs
        str.POI_names =  {'\lambda_H','\lambda_V'};
            str.nPOI=length(str.POI_names);
        str.QOI_names =  {'Proportion I_{DV} at equilibirium','Proportion I_{DV} at t=5', 'R_0'};
            str.nQOI=length(str.QOI_names);
        
        %Select Model
        str.QOI_model_eval = @BBB_Chagas_Gen1_model;
        
        %Set Parameter Ranges
        str.POI_baseline=[lambda.H lambda.V]';
        %str.POI_baseline=[.01 .002 .01 .002 .002 .01 .002 .01]';
        if length(str.POI_baseline)~=str.nPOI
            error('Different number of parameters named than entered')
        end
        str.POI_min=zeros(2,1);
        str.POI_max=2*str.POI_baseline;
        str.POI_mode=str.POI_baseline;
    otherwise
        error([' str.QOI_model =',str.QOI_model_name,' is not available'])
end

%Set Common Properties
    %Sampling
    str.POI_pdf='beta';% uniform triangle beta
    str.number_ESA_samples = 15;
    
    %Pass selected parameters to ODE
    str.select.POI=str.POI_names;
    str.select.QOI=str.QOI_names;
end