function str= CG2_change_default_params(str)
%% QOI_change_default_params change default parameters
%Load parameters
    str.baseParams=Gen2_params(str.ParamSettings);
        N=str.baseParams.N;
        sigma=str.baseParams.sigma;
        alpha=str.baseParams.alpha;
        r=str.baseParams.r;
        lambda=str.baseParams.lambda;
        gamma=str.baseParams.gamma;
        mu=str.baseParams.mu;
        if isfield(str.baseParams,'PopProportions')
            c=str.baseParams.PopProportions.c;
            d=str.baseParams.PopProportions.d;
        end
        %SelectModel 
        str.QOI_model_eval = @BBB_Chagas_Gen2_model;
switch str.QOI_model_name
    case 'Algebraic Compression'
%         str.POI_names={'\gamma_{DS}','\gamma_{DR}','\gamma_{DV}'... %Death
%             '\sigma_{DS}', '\sigma_{DR}' ,'\sigma_{DV}'... %Recruitment
%             '\alpha^{DS}_{DV}', '\alpha^{DR}_{DV}'... %Vec Infection
%              '\alpha^{DV}_{DS}', '\alpha^{DV}_{DR}'}; %Host Infection
          str.POI_names={'\gamma_{DR}','\gamma_{DV}'... %Death Rates
            '\alpha^{DS}_{DV}', '\alpha^{DR}_{DV}'... %Vec Infection
             '\alpha^{DV}_{DR}'}; %Host Infection
        str.QOI_names =  {'Algebraic I^*_{DV} Error','Algebraic I^*_{DV}/_{N^*_{DV}} Error'};
            str.nQOI=length(str.QOI_names);
        str.POI_baseline=[gamma.DR gamma.DV...
            alpha.DS_DV alpha.DR_DV ...
            alpha.DV_DR]';
%         str.POI_baseline=[gamma.DS gamma.DR gamma.DV...
%             sigma.DS sigma.DR sigma.DV  ...
%             alpha.DS_DV alpha.DR_DV ...
%             alpha.DV_DS alpha.DV_DR]';
        str.POI_min=str.POI_baseline*.8;
        str.POI_max=str.POI_baseline*1.2;
        str.POI_mode=str.POI_baseline;
    case 'High Sensitivities' %Not been adjusted for new model
        str.POI_names={'\gamma_{DR}','\gamma_{SR}','\gamma_{DV}'};
            str.nPOI=length(str.POI_names);
        str.QOI_names =  {'Proportion I_{DV} at equilibirium', 'R_0'};
            str.nQOI=length(str.QOI_names);
        str.POI_baseline=[gamma.DR gamma.SR gamma.DV]';
        str.POI_min=str.POI_baseline*.8;
        str.POI_max=str.POI_baseline*2;
        str.POI_mode=str.POI_baseline;
    case 'Low Confidence Params'
         str.POI_names ={'\lambda_R','\lambda_S','\lambda_V',... %Movement Rates
            '\alpha^{SS}_{SV}' '\alpha^{SR}_{SV}' '\alpha^{DS}_{DV}'...
            '\alpha^{DR}_{DV}' '\alpha^{DD}_{DV}'... %Vec Infection'
            '\mu_{DD}','r_R'};
            str.nPOI=length(str.POI_names);
        str.QOI_names =  {'Proportion I_{DV} at equilibirium', 'Proportion I_{DD} at equilibirium',...
            'Proportion I_{DR} at equilibirium', 'Proportion I_{DS} at equilibirium'};
            str.nQOI=length(str.QOI_names);
        str.POI_baseline=[lambda.R lambda.S lambda.V...
            alpha.SS_SV alpha.SR_SV alpha.DS_DV alpha.DR_DV alpha.DD_DV...
            mu.DD r.R]';
        str.POI_min=str.POI_baseline*.8;
        str.POI_max=str.POI_baseline*1.2;
        str.POI_mode=str.POI_baseline;
    case 'All Params'
         str.POI_names ={'\lambda_R','\lambda_S','\lambda_V',... %Movement Rates
            '\sigma_{SV}' '\sigma_{SS}' '\sigma_{SR}' '\sigma_{DV}'...
            '\sigma_{DS}' '\sigma_{DR}' '\sigma_{DD}'... %Recruitment Rates
            '\alpha^{SS}_{SV}' '\alpha^{SR}_{SV}' '\alpha^{DS}_{DV}'...
            '\alpha^{DR}_{DV}' '\alpha^{DD}_{DV}'... %Vec Infection
            '\alpha^{SV}_{SS}' '\alpha^{SV}_{SR}' '\alpha^{DV}_{DS}'...
            '\alpha^{DV}_{DR}' '\alpha^{DV}_{DD}' ... %Host Infection
            '\gamma_{SS}','\gamma_{SR}','\gamma_{SV}',...
            '\gamma_{DS}','\gamma_{DR}','\gamma_{DV}',... %DeathRates
            '\gamma_{DD}','\mu_{DD}','r_R'};
            str.nPOI=length(str.POI_names);
        str.QOI_names =  {'Proportion I_{DV} at equilibirium','Infected Feedings per Person'};
            str.nQOI=length(str.QOI_names);
        str.POI_baseline=[lambda.R lambda.S lambda.V...
            sigma.SV sigma.SS sigma.SR sigma.DV sigma.DS sigma.DR sigma.DD...
            alpha.SS_SV alpha.SR_SV alpha.DS_DV alpha.DR_DV alpha.DD_DV...
            alpha.SV_SS alpha.SV_SR alpha.DV_DS alpha.DV_DR alpha.DV_DD...
            gamma.SS gamma.SR gamma.SV gamma.DS gamma.DR gamma.DV gamma.DD...
            mu.DD r.R]';
        str.POI_min=str.POI_baseline*.8;
        str.POI_max=str.POI_baseline*1.2;
        str.POI_mode=str.POI_baseline;
    case 'All Params Error'
         str.POI_names ={'\lambda_R','\lambda_S','\lambda_V',... %Movement Rates
            '\sigma_{SV}' '\sigma_{SS}' '\sigma_{SR}' '\sigma_{DV}'...
            '\sigma_{DS}' '\sigma_{DR}' '\sigma_{DD}'... %Recruitment Rates
            '\alpha^{SS}_{SV}' '\alpha^{SR}_{SV}' '\alpha^{DS}_{DV}'...
            '\alpha^{DR}_{DV}' '\alpha^{DD}_{DV}'... %Vec Infection
            '\alpha^{SV}_{SS}' '\alpha^{SV}_{SR}' '\alpha^{DV}_{DS}'...
            '\alpha^{DV}_{DR}' '\alpha^{DV}_{DD}' ... %Host Infection
            '\gamma_{SS}','\gamma_{SR}','\gamma_{SV}',...
            '\gamma_{DS}','\gamma_{DR}','\gamma_{DV}',... %DeathRates
            '\gamma_{DD}','\mu_{DD}','r_R'};
            str.nPOI=length(str.POI_names);
        str.QOI_names =  {'Percent Error in Human Risk Estimation'};
            str.nQOI=length(str.QOI_names);
        str.POI_baseline=[lambda.R lambda.S lambda.V...
            sigma.SV sigma.SS sigma.SR sigma.DV sigma.DS sigma.DR sigma.DD...
            alpha.SS_SV alpha.SR_SV alpha.DS_DV alpha.DR_DV alpha.DD_DV...
            alpha.SV_SS alpha.SV_SR alpha.DV_DS alpha.DV_DR alpha.DV_DD...
            gamma.SS gamma.SR gamma.SV gamma.DS gamma.DR gamma.DV gamma.DD...
            mu.DD r.R]';
        str.POI_min=str.POI_baseline*.8;
        str.POI_max=str.POI_baseline*1.2;
        str.POI_mode=str.POI_baseline;
    case 'Model Params Error: Most Sensitive'
        
         str.POI_names ={'\alpha^{SS}_{SV}', '\alpha^{SV}_{SR}', '\alpha^{DV}_{DR}' ... %Host Infection
            '\gamma_{SR}','\gamma_{SV}'};
            str.nPOI=length(str.POI_names);
        str.QOI_names =  {'Percent Error in Human Risk Estimation'};
            str.nQOI=length(str.QOI_names);
        str.POI_baseline=[alpha.SS_SV alpha.SV_SR alpha.DV_DR...
            gamma.SR gamma.SV]';
        str.POI_min=str.POI_baseline*.8;
        str.POI_max=str.POI_baseline*1.2;
        str.POI_mode=str.POI_baseline;
    case 'Assumptions Error: d'
        str.POI_names={'d_{SS}','d_{SR}',...
            'd_{DS}','d_{DR}','d_{DD}'};
            str.nPOI=length(str.POI_names);
        str.QOI_names =  {'Percent Error in Human Risk Estimation'};
        %str.QOI_names =  {'Infected Feedings per Person per Day' 'Proportion I_{DV} at equilibirium Error'};
        %str.QOI_names =  {'Proportion I_{DV} at equilibirium Error'};
            str.nQOI=length(str.QOI_names);
            
       str.POI_baseline=[d.SS d.SR d.DS d.DR d.DD]';
       str.POI_min(1:5,1)=zeros(5,1);
       str.POI_max(1:5,1)=ones(5,1);
       str.POI_mode=str.POI_baseline;
        
    case 'Assumptions Error: All Assumptions'
        str.POI_names={'c^{SS}_{ST}','c^{DS}_{DT}','c^{DD}_{DH}','d_{SS}','d_{SR}',...
            'd_{DS}','d_{DR}','d_{DD}'};
            str.nPOI=length(str.POI_names);
        str.QOI_names =  {'Proportion I_{DV} at equilibirium Error', 'Error in R_0'};
            str.nQOI=length(str.QOI_names);
            
       str.POI_baseline=[c.SS_ST c.DS_DT c.DD_DH d.SS d.SR d.DS d.DR d.DD]';
       str.POI_min(1:3,1)=.8*str.POI_baseline(1:3);
       str.POI_min(4:8,1)=zeros(1,5)+.1;
       str.POI_max(1:3,1)=1.2*str.POI_baseline(1:3);
       str.POI_max(4:8,1)=ones(1,5)-.1;
       str.POI_mode=str.POI_baseline;
        
    case 'Assumptions: d'
        str.POI_names={'d_{SS}','d_{SR}',...
            'd_{DS}','d_{DR}','d_{DD}'};
            str.nPOI=length(str.POI_names);
        str.QOI_names =  {'Infected Feedings per Person per Day Error'};
            str.nQOI=length(str.QOI_names);
       str.POI_baseline=[d.SS d.SR d.DS d.DR d.DD]';
       str.POI_min(1:5,1)=zeros(5,1)+.1;
       str.POI_max(1:5,1)=ones(5,1)-.1;
       str.POI_mode=str.POI_baseline;
        
    case 'Assumptions: All Assumptions'
        str.POI_names={'c^{SS}_{ST}','c^{DS}_{DT}','c^{DD}_{DH}','d_{SS}','d_{SR}',...
            'd_{DS}','d_{DR}','d_{DD}'};
            str.nPOI=length(str.POI_names);
        str.QOI_names =  {'Proportion I_{DV} at equilibirium', 'R_0'};
            str.nQOI=length(str.QOI_names);
            
       str.POI_baseline=[c.SS_ST c.DS_DT c.DD_DH d.SS d.SR d.DS d.DR d.DD]';
       str.POI_min(1:3,1)=.8*str.POI_baseline(1:3);
       str.POI_min(4:8,1)=zeros(1,5)+.1;
       str.POI_max(1:3,1)=1.2*str.POI_baseline(1:3);
       str.POI_max(4:8,1)=ones(1,5)-.1;
       str.POI_mode=str.POI_baseline;
        
    case 'lambda'
        %Select POI's and QOI's
        str.POI_names =  {'\lambda_R','\lambda_S','\lambda_V'};
                      str.nPOI=length(str.POI_names);
        str.QOI_names =  {'Proportion I_{DV} at equilibirium','Infected Feedings per Person per Day'};
%         str.QOI_names =  {'Proportion I_{DV} at equilibirium', 'Proportion I_{DD} at equilibirium',...
%             'Proportion I_{DR} at equilibirium', 'Proportion I_{DS} at equilibirium'};
        str.nQOI=length(str.QOI_names);
        
        %Set parameter Sampling
        str.POI_baseline=[lambda.R lambda.S lambda.V]';
        str.POI_baseline=[lambda.R lambda.S .05]';
        if length(str.POI_baseline)~=str.nPOI
            error("Different number of parameters named than entered")
        end
        str.POI_min=zeros(size(str.POI_baseline));
        str.POI_max=str.POI_baseline+1.5*str.POI_baseline;
        str.POI_mode=str.POI_baseline;
    case 'Vec Infection'
        str.POI_names={'\alpha^{SS}_{SV}' '\alpha^{SR}_{SV}' '\alpha^{DS}_{DV}'...
            '\alpha^{DR}_{DV}' '\alpha^{DD}_{DV}'};
        str.QOI_names =  {'Proportion I_{DV} at equilibirium', 'Infected Feedings per Person per Day'};
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
            '\alpha^{DV}_{DR}' '\alpha^{DV}_{DD}'};
        str.QOI_names ={'Proportion I_{DV} at equilibirium', 'Infected Feedings per Person per Day'};
        str.nQOI=length(str.QOI_names);
        str.nPOI=length(str.POI_names);
        
        
        str.POI_baseline=[alpha.SV_SS alpha.SV_SR alpha.DV_DS alpha.DV_DR alpha.DV_DD]';
        if length(str.POI_baseline)~=str.nPOI
            error("Different number of parameters named than entered")
        end
        str.POI_min=str.POI_baseline-.8*str.POI_baseline;
        str.POI_max=str.POI_baseline+.8*str.POI_baseline;
        str.POI_mode=str.POI_baseline;
    case 'All Infection'
        str.POI_names={'\alpha^{SS}_{SV}' '\alpha^{SR}_{SV}' '\alpha^{DS}_{DV}'...
            '\alpha^{DR}_{DV}' '\alpha^{DD}_{DV}' '\alpha^{SV}_{SS}' '\alpha^{SV}_{SR}' '\alpha^{DV}_{DS}'...
            '\alpha^{DV}_{DR}' '\alpha^{DV}_{DD}'};
        %str.QOI_names =  {'Proportion I_{DV} at equilibirium', 'R_0'};
        str.QOI_names={'Proportion I_{DV} at equilibirium','R_0'};
        str.nQOI=length(str.QOI_names);
        str.nPOI=length(str.POI_names);
        
        
        str.POI_baseline=[alpha.SS_SV alpha.SR_SV alpha.DS_DV alpha.DR_DV alpha.DD_DV...
            alpha.SV_SS alpha.SV_SR alpha.DV_DS alpha.DV_DR alpha.DV_DD]';
        if length(str.POI_baseline)~=str.nPOI
            error("Different number of parameters named than entered")
        end
        str.POI_min=str.POI_baseline-.5*str.POI_baseline;
        str.POI_max=str.POI_baseline+.5*str.POI_baseline;
        str.POI_mode=str.POI_baseline;
        
    case 'Vector Demography'
        str.POI_names={'^{1}/{\gamma_{SV}}', '^{1}/{\gamma_{DV}}','\sigma_{SV}', '\sigma_{DV}'};
        %str.QOI_names =  {'Proportion I_{DV} at equilibirium', 'R_0'};
        str.QOI_names={'Proportion I_{DV} at equilibirium','Infected Feedings per Person per Day'};
        str.nQOI=length(str.QOI_names);
        str.nPOI=length(str.POI_names);
        
        
        str.POI_baseline=[1/gamma.SV 1/gamma.DV sigma.SV sigma.DV]';
        if length(str.POI_baseline)~=str.nPOI
            error("Different number of parameters named than entered")
        end
        str.POI_min=str.POI_baseline-.8*str.POI_baseline;
        str.POI_max=str.POI_baseline+.8*str.POI_baseline;
        str.POI_mode=str.POI_baseline;
    case 'Vector Demography Error'
        str.POI_names={'^{1}/{\gamma_{SV}}', '^{1}/{\gamma_{DV}}','\sigma_{SV}', '\sigma_{DV}'};
        %str.QOI_names =  {'Proportion I_{DV} at equilibirium', 'R_0'};
        str.QOI_names={'Percent Error in Human Risk Estimation'};
        str.nQOI=length(str.QOI_names);
        str.nPOI=length(str.POI_names);
        str.POI_baseline=[1/gamma.SV 1/gamma.DV sigma.SV sigma.DV]';
        if length(str.POI_baseline)~=str.nPOI
            error("Different number of parameters named than entered")
        end
        str.POI_min=str.POI_baseline-.8*str.POI_baseline;
        str.POI_max=str.POI_baseline+.8*str.POI_baseline;
        str.POI_mode=str.POI_baseline;
    case 'Recruitment'
        str.POI_names={'\sigma_{SV}', '\sigma_{DV}','\sigma_{SS}','\sigma_{DS}',...
            '\sigma_{SR}','\sigma_{DR}','\sigma_{DD}'};
        %str.QOI_names =  {'Proportion I_{DV} at equilibirium', 'R_0'};
        str.QOI_names={'Proportion I_{DV} at equilibirium','Infected Feedings per Person per Day'};
        str.nQOI=length(str.QOI_names);
        str.nPOI=length(str.POI_names);
        
        
        str.POI_baseline=[sigma.SV sigma.DV sigma.SS sigma.DS...
            sigma.SR sigma.DR sigma.DD]';
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