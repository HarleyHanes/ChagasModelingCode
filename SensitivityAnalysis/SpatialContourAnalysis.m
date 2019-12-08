%% Spatial Contour Analysis
% Assess Identifiability of lambda vs. transspatial thetas
% Assess QOI of %I_DV at equilibrium
clear; clc;
%% Simulation settings
nsamples=25;
Select.POI={"null"};
Select.QOI={'Final Number of Infected DV'};
POIs={"null"};
paramsBase=baseline_params();
%% One at a time
%Get Sample vectors
lambdamin=0; lambdamax=2;
lambdaRange=linspace(lambdamin, lambdamax, nsamples);
lambdaHRange=lambdaRange*paramsBase.lambda.H;
lambdaVRange=lambdaRange*paramsBase.lambda.V;
thetamin=0; thetamax=2;
thetaRange=linspace(thetamin, thetamax, nsamples);
thetaDHSVRange=paramsBase.theta.DH_SV*thetaRange;
thetaSHDVRange=paramsBase.theta.SH_DV*thetaRange;
thetaDVSHRange=paramsBase.theta.DV_SH*thetaRange;
thetaSVDHRange=paramsBase.theta.SV_DH*thetaRange;
lambdaRange=[lambdaHRange; lambdaVRange];
thetaRange=[thetaDHSVRange; thetaSHDVRange; thetaDVSHRange; thetaSVDHRange];


for ilam=1:2
    for itheta=1:4
        Results=NaN(nsamples);
        for lamsamp=1:nsamples
            for thetasamp=1:nsamples
                %Set parameter settings
                params=paramsBase;
                if ilam==1
                    params.lambda.H=lambdaRange(ilam,lamsamp);
                elseif ilam==2
                    params.lambda.V=lambdaRange(ilam,lamsamp);
                end
                switch itheta
                    case 1
                        params.theta.DH_SV=thetaRange(itheta,thetasamp);
                    case 2
                        params.theta.SH_DV=thetaRange(itheta,thetasamp);
                    case 3
                        params.theta.DV_SH=thetaRange(itheta,thetasamp);
                    case 4
                        params.theta.SV_DH=thetaRange(itheta,thetasamp);
                end
                %Run Model-Results are not saved after iteration
                Results(lamsamp,thetasamp)=BBB_Chagas_Gen1_model(POIs,Select,params);
            end
        end
        %Plot Results
        subplot(2,4,4*(ilam-1)+itheta)
        [C,h]=contour(thetaRange(itheta,:),lambdaRange(ilam,:),Results);
        %Make labels
        clabel(C,h)
        if ilam==1
            ylabel("$\lambda_H$",'Interpreter',"latex")
        elseif ilam==2
            ylabel("$\lambda_V$",'Interpreter',"latex")
        end
        switch itheta
            case 1
                xlabel("$\theta^{DH}_{SV}$",'Interpreter',"latex")
            case 2
                xlabel("$\theta^{SH}_{DV}$",'Interpreter',"latex")
            case 3
                xlabel("$\theta^{DV}_{SH}$",'Interpreter',"latex")
            case 4
                xlabel("$\theta^{SV}_{DH}$",'Interpreter',"latex")
        end
    end
end
        

%% All at once
figure
lambdaRange=linspace(0,2,nsamples);
thetaRange=linspace(0,2,nsamples);
Sol=NaN(nsamples);
params=paramsBase;
for i=1:length(lambdaRange)
    params.lambda.H=lambdaRange(i)*paramsBase.lambda.H;
    params.lambda.V=lambdaRange(i)*paramsBase.lambda.V;
    for j=1:length(thetaRange)
        params.theta.DH_SV=thetaRange(j)*paramsBase.theta.DH_SV;
        params.theta.SH_DV=thetaRange(j)*paramsBase.theta.SH_DV;
        params.theta.DV_SH=thetaRange(j)*paramsBase.theta.DV_SH;
        params.theta.SV_DH=thetaRange(j)*paramsBase.theta.SV_DH;
        [Sol(i,j),~]=BBB_Chagas_Gen1_model(POIs,Select,params);
    end
end
[C,h]=contour(thetaRange,lambdaRange,Sol);

ylabel("$\Sigma\frac{\lambda}{\lambda_{base}}$",'Interpreter',"latex")

xlabel("$\Sigma\frac{\theta^{transpatial}}{\theta^{transpatial}_{base}}$",'Interpreter',"latex")

clabel(C,h)


% %% Set up sampling
% paramsBase=baseline_params();   %Load baseline params
% %Set up Sampling Ranges
% lambdaVRange=[0 2*paramsBase.lambda.V];
% lambdaHRange=[0 2*paramsBase.lambda.H];
% thetaDH_SVRange=[0 2*paramsBase.theta.DH_SV];
% thetaSH_DVRange=[0 2*paramsBase.theta.SH_DV];
% thetaDV_SHRange=[0 2*paramsBase.theta.DV_SH];
% thetaSV_DHRange=[0 2*paramsBase.theta.SV_DH];
% SamplingRanges=[lambdaVRange; lambdaHRange; thetaDH_SVRange;
%                 thetaSH_DVRange; thetaDV_SHRange; thetaSV_DHRange];
% minRange=min(SamplingRanges')';
% maxRange=max(SamplingRanges')';
% %Conduct Sampling
% Samples=rand(size(SamplingRanges,1),nsamples);
% Samples=Samples.*(maxRange-minRange)+minRange;
% QOIs=NaN(1,nsamples);
% for i=1:nsamples
%     TestParams=paramsBase;
%     TestParams.lambda.V=Samples(1,i);
%     TestParams.lambda.H=Samples(2,i);
%     TestParams.theta.DH_SV=Samples(3,i);
%     TestParams.theta.SH_DV=Samples(4,i);
%     TestParams.theta.DV_SH=Samples(5,i);
%     TestParams.theta.SV_DH=Samples(6,i);
%     [QOIs(i),~]=BBB_Chagas_Gen1_model(POIs,Select,TestParams);
% end
%     

