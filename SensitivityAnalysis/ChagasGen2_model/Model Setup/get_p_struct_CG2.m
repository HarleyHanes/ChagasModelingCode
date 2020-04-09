function params= get_p_struct_CG2(POIs,pnames,baseParams)
%Parameter Loading
params=baseParams;
alpha=params.alpha;
sigma=params.sigma;
gamma=params.gamma;
r=params.r;
mu=params.mu;
lambda=params.lambda;
for i=1:length(pnames)
    switch pnames{i}
        case '\sigma_{SV}'
             sigma.SV=POIs(i);
        case '\sigma_{SS}'
             sigma.SS=POIs(i);
        case '\sigma_{SR}'
             sigma.SR=POIs(i);
        case '\sigma_{DV}'
             sigma.DV=POIs(i);
        case '\sigma_{DS}'
             sigma.DS=POIs(i);
        case '\sigma_{DR}'
             sigma.DR=POIs(i);
        case '\sigma_{DD}'
             sigma.DD=POIs(i);
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
        case'\mu_{DD}'
            mu.DD=POIs(i);        
        case'r_R'
            r.R=POIs(i);
        case '\lambda_S'
            lambda.S=POIs(i);
        case '\lambda_R'
            lambda.R=POIs(i);
        case '\lambda_V'
            lambda.V=POIs(i);
        case 'c^{SS}_{ST}'
            params.PopProportions.c.SS_ST=POIs(i);
        case 'd_{SS}'
            params.PopProportions.d.SS=POIs(i);
        case 'd_{SR}'
            params.PopProportions.d.SR=POIs(i);
        case 'c^{DS}_{DT}'
            params.PopProportions.c.DS_DT=POIs(i);
        case 'd_{DS}'
            params.PopProportions.d.DS=POIs(i);
        case 'd_{DR}'
            params.PopProportions.d.DR=POIs(i);
        case 'c^{DD}_{DH}'
            params.PopProportions.c.DD_DH=POIs(i);
        case'd_{DD}'
            params.PopProportions.d.DD=POIs(i);
        case 'null'
        otherwise
            warning("Error!! '%s' could not be identified as a parameter",pnames{i})
    end
end

params.alpha=alpha;
params.gamma=gamma;
params.sigma=sigma;
params.mu=mu;
params.r=r;
params.lambda=lambda;

end