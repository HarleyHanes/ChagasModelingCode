function params= get_p_struct_CG1(POIs,pnames,baseParams)
%Parameter Loading
params=baseParams;
theta=params.theta;
lambda=params.lambda;
mu=params.mu;
for i=1:length(pnames)
    switch pnames{i}
        case '\theta^{SV}_{SH}'
            theta.SV_SH=POIs(i);
        case '\theta^{DV}_{SH}'
            theta.DV_SH=POIs(i);
        case '\theta^{SH}_{SV}'
            theta.SH_SV=POIs(i);
        case '\theta^{DH}_{SV}'
            theta.DH_SV=POIs(i);
        case '\theta^{SV}_{DH}'
            theta.SV_DH=POIs(i);
        case '\theta^{DV}_{DH}'
            theta.DV_DH=POIs(i);
        case '\theta^{SH}_{DV}'
            theta.SH_DV=POIs(i);
        case '\theta^{DH}_{DV}'
            theta.DH_DV=POIs(i);
        case '\lambda_H'
            lambda.H=POIs(i);
        case '\lambda_V'
            lambda.V=POIs(i);
        case '\mu_{SH}'
            mu.SH=POIs(i);
        case '\mu_{SV}'
            mu.SV=POIs(i);
        case '\mu_{DH}'
            mu.DH=POIs(i);
        case '\mu_{DV}'
            mu.DV=POIs(i); 
        case 'null'
        otherwise
            warning("Error!! '%s' could not be identified as a parameter",pnames{i})
    end
end

% for i=1:length(index)
%     switch index(i)
%         case 1
%             theta.SV_SH=POIs(i);
%         case 2
%             theta.DV_SH=POIs(i);
%         case 3
%             theta.SH_SV=POIs(i);
%         case 4
%             theta.DH_SV=POIs(i);
%         case 5
%             theta.SV_DH=POIs(i);
%         case 6
%             theta.DV_DH=POIs(i);
%         case 7
%             theta.SH_DV=POIs(i);
%         case 8
%             theta.DH_DV=POIs(i);
%         case 9
%             lambda.H=POIs(i);
%         case 10
%             lambda.V=POIs(i);
%         case 11
%             mu.SH=POIs(i);
%         case 12
%             mu.SV=POIs(i);
%         case 13
%             mu.DH=POIs(i);
%         case 14
%             mu.DV=POIs(i);            
%     end
% end
params.theta=theta;
params.lambda=lambda;
params.mu=mu;

end