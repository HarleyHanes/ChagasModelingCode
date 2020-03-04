function [timeDerivatives] = QOI_Time_Derivatives(soln,params,varargin)
%QOI_Time_Derivatives Extracts the time derivatives for the whoel tspan
%   Detailed explanation goes here
if nargin==3
    tindex=varargin{1};
elseif nargin>3
    error('More than 3 arguments entered to QOI_Time_Derivatives')
end



if nargin<3
    timeDerivatives=NaN(size(soln.y));
    t=soln.x;
    for it=1:length(t)
        timeDerivatives(it,:)=(Chagas_Gen2_ODEs(t,soln.y(it,:),params))';
    end
elseif nargin==3
    %Find index equal to tindex
        %check t assessed
        if sum(soln.x==tindex)~=1
            error('Non-unique/existent point with given index')
        end
        t=find(soln.x==tindex);
        
    timeDerivatives=(Chagas_Gen2_ODEs(t,soln.y(t,:),params))';
end
end

