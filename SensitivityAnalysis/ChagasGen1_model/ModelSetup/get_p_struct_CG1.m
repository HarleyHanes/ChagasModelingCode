function params= get_p_struct_CG1(POIs,pnames,baseParams)
%Parameter Loading
params=baseParams;
alpha=params.alpha;
lambda=params.lambda;
gamma=params.gamma;
for i=1:length(pnames)
    switch pnames{i}
        case '\alpha^{SV}_{SH}'
            alpha.SV_SH=POIs(i);
        case '\alpha^{DV}_{SH}'
            alpha.DV_SH=POIs(i);
        case '\alpha^{SH}_{SV}'
            alpha.SH_SV=POIs(i);
        case '\alpha^{DH}_{SV}'
            alpha.DH_SV=POIs(i);
        case '\alpha^{SV}_{DH}'
            alpha.SV_DH=POIs(i);
        case '\alpha^{DV}_{DH}'
            alpha.DV_DH=POIs(i);
        case '\alpha^{SH}_{DV}'
            alpha.SH_DV=POIs(i);
        case '\alpha^{DH}_{DV}'
            alpha.DH_DV=POIs(i);
        case '\lambda_H'
            lambda.H=POIs(i);
        case '\lambda_V'
            lambda.V=POIs(i);
        case '\gamma_{SH}'
            gamma.SH=POIs(i);
        case '\gamma_{SV}'
            gamma.SV=POIs(i);
        case '\gamma_{DH}'
            gamma.DH=POIs(i);
        case '\gamma_{DV}'
            gamma.DV=POIs(i); 
        case 'null'
        otherwise
            warning("Error!! '%s' could not be identified as a parameter",pnames{i})
    end
end
params.alpha=alpha;
params.lambda=lambda;
params.gamma=gamma;

end