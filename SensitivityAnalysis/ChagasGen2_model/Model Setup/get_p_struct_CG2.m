function params= get_p_struct_CG2(POIs,pnames,baseParams)
%Parameter Loading
params=baseParams;
beta=params.beta;
alpha=params.alpha;
gamma=params.gamma;
b=params.b;
lambda=params.lambda;
for i=1:length(pnames)
    switch pnames{i}
        case '\alpha^{SV}_{SS}'
             alpha.SV_SS=POIs(i);
        case '\alpha^{SV}_{SR}'
            alpha.SV_SR=POIs(i);
        case '\alpha^{DV}_{DS}'
            alpha.DV_DS=POIs(i);
        case '\alpha^{DV}_{DR}'
            alpha.DV_DR=POIs(i);
        case '\alpha^{DV}_{DD}'
            alpha.DV_DD=POIs(i);
        case '\alpha^{SS}_{SV}'
             alpha.SS_SV=POIs(i);
        case '\alpha^{SR}_{SV}'
            alpha.SR_SV=POIs(i);
        case '\alpha^{DS}_{DV}'
            alpha.DS_DV=POIs(i);
        case '\alpha^{DR}_{DV}'
            alpha.DR_DV=POIs(i);
        case '\alpha^{DD}_{DV}'
            alpha.DD_DV=POIs(i); 
        case '\beta^{SV}_{SS}'  %Currently have it where you can only change b, will need to be changed later
            b.SS=b.SS*POIs(i)/beta.SV_SS;
            beta.SV_SS=POIs(i);
        case '\beta^{SV}_{SR}'
            b.SR=b.SR*POIs(i)/beta.SV_SR;
            beta.SV_SR=POIs(i);
        case '\beta^{DV}_{DS}'
            b.DS=b.DS*POIs(i)/beta.DV_DS;
            beta.SV_DS=POIs(i);
        case '\beta^{DV}_{DR}'
            b.DR=b.DR*POIs(i)/beta.DV_DR;
            beta.DV_DR=POIs(i);
        case '\beta^{DV}_{DD}'
            b.DD=b.DD*POIs(i)/beta.DV_DD;
            beta.DV_DD=POIs(i);
        case'\gamma_{SV}'
            gamma.SV=POIs(i);
        case'\gamma_{SS}'
            gamma.SS=POIs(i);
        case'\gamma_{SR}'
            gamma.SR=POIs(i);
        case'\gamma_{DV}'
            gamma.DV=POIs(i);
        case'\gamma_{DS}'
            gamma.DS=POIs(i);
        case'\gamma_{DR}'
            gamma.DR=POIs(i);
        case'\gamma_{DD}'
            gamma.DD=POIs(i);
        case '\lambda_S'
            lambda.S=POIs(i);
        case '\lambda_R'
            lambda.R=POIs(i);
        case '\lambda_V'
            lambda.V=POIs(i);
        case 'null'
        otherwise
            warning("Error!! '%s' could not be identified as a parameter",pnames{i})
    end
end

params.alpha=alpha;
params.gamma=gamma;
params.b=b;
params.lambda=lambda;

end