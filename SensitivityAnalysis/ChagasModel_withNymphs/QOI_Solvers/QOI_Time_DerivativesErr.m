function [timeDerivativesErr] = QOI_Time_DerivativesErr(soln,POIs,select,baseParams,varargin)
%QOI_Time_Derivatives Extracts the time derivatives for the whoel tspan
%   Detailed explanation goes here
if nargin==5
    tindex=varargin{1};
elseif nargin>5
    error('More than 3 arguments entered to QOI_Time_Derivatives')
end


paramsReduced=modify_params(POIs,select,baseParams);
if nargin<3
    timeDerivatives=NaN(size(soln.y));
    t=soln.x;
    for it=1:length(t)
        timeDerivatives(it,:)=(Chagas_Gen2_ODEs(t,soln.y(it,:),paramsReduced))';
    end
elseif nargin==3
    %Find index equal to tindex
        %check t assessed
        if sum(soln.x==tindex)~=1
            error('Non-unique/existent point with given index')
        end
        t=find(soln.x==tindex);
        
    timeDerivatives=(Chagas_Gen2_ODEs(t,soln.y(t,:),paramsReduced))';
end

%Don't change params because modified params variable is assumed to be
%modified params rather than baseparams.
selectTrue=select;
selectTrue.model='full';
if nargin<3
    selectTrue.QOI={'Time Derivatives at t=0'};
elseif tindex==0
    selectTrue.QOI={'Time Derivatives at t=0'};
elseif tindex>0
    selectTrue.QOI={'Time Derivatives at Equil'};
end
timeDerivativesTrue=BBB_Chagas_Gen2_model(POIs,selectTrue,baseParams);
if strcmpi(model,'10ODE')||strcmpi(model,'8ODE')
    timeDerivativesTrue(:,3:4)=timeDerivativesTrue(:,3:4)+timeDerivativesTrue(:,5:6);
    timeDerivativesTrue(:,9:10)=timeDerivativesTrue(:,9:10)+timeDerivativesTrue(:,11:12);
end
if strcmpi(model,'8ODE')
    timeDerivativesTrue(:,9:10)=timeDerivativesTrue(:,9:10)+timeDerivativesTrue(:,13:14);
end
timeDerivativesErr=timeDerivativesTrue-timeDerivatives;
end



