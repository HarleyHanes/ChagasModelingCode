function [params] = CG2toODE10params(CG2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
c=CG2.PopProportions.c;
d=CG2.PopProportions.d;
        N.SV=CG2.N.SV;
        N.DV=CG2.N.DV;
    %Synanthropic Hosts
        N.SS=CG2.N.SS+CG2.N.SR;
        N.DS=CG2.N.DS+CG2.N.DR;
    %Rodents
        N.SR=0;
        N.DR=0;
    %Domestic Mammals
        N.DD=CG2.N.DD;
%Death Rates -%weighted averages of each death rate according to density
    %Vectors
        gamma.SV=CG2.gamma.SV;
        gamma.DV=CG2.gamma.DV;
    %Synanthropic Hosts
        gamma.SS=(CG2.gamma.SS*c.SS_ST*d.SS+CG2.gamma.SR*(1-CG2.r.R)*(1-c.SS_ST)*d.SR)...
            /(c.SS_ST*d.SS+(1-c.SS_ST)*d.SR);
        gamma.DS=(CG2.gamma.DS*c.DS_DT*d.DS+CG2.gamma.DR*(1-CG2.r.R)*(1-c.DS_DT)*d.DR)...
            /(c.DS_DT*d.DS+(1-c.DS_DT)*d.DR);
    %Rodents
        gamma.SR=0;
        gamma.DR=0;
    %Domestic Mammals
        gamma.DD=CG2.gamma.DD;
%Host-->Vector transmission rates
     %Sylvatic Vectors
        alpha.SS_SV=(CG2.alpha.SS_SV*d.SS+CG2.alpha.SR_SV*d.SR)...
            /(d.SS*c.SS_ST+d.SR*(1-c.SS_ST));
        alpha.SR_SV=0;
     %Peridomestic Vectors
        alpha.DS_DV=(CG2.alpha.DS_DV*d.DS+CG2.alpha.DR_DV*d.DR)...
            /(d.DS*c.DS_DT+d.DR*(1-c.DS_DT));
        alpha.DR_DV=0;
        alpha.DD_DV=CG2.alpha.DD_DV;
%Vector-->Host transmission rates (stechorian)
    %Sylvatic Hosts
        alpha.SV_SS=(CG2.alpha.SV_SS*d.SS+CG2.alpha.SV_SR*d.SR)...
            /(d.SS*c.SS_ST+d.SR*(1-c.SS_ST));
        alpha.SV_SR=0;
    %Peridomestic Hosts
        alpha.DV_DS=((CG2.alpha.DV_DS+CG2.beta.DV_DS)*c.DS_DT*(1-d.DS)+(CG2.alpha.DV_DR+CG2.beta.DV_DR)*(1-c.DS_DT)*(1-d.DR))...
            /(c.DS_DT*(1-d.DS)+(1-c.DS_DT)*(1-d.DR));
        alpha.DV_DR=0;
        alpha.DV_DD=CG2.alpha.DV_DD;
%Vector-->Host transmission rates (oral)
    %Sylvatic Hosts
        beta.SV_SS=0;%q_V_H*b_SH;
        beta.SV_SR=0;%q_V_H*b_SH;
    %Peridomestic Hosts
        beta.DV_DS=0;%q_V_H*b_SH;
        beta.DV_DR=0;%q_V_H*b_SH;
        beta.DV_DD=0;%q_V_H*b_SH;
%Movement rates
        lambda.R=0;
        lambda.S=c.SS_ST*CG2.lambda.S+(1-c.SS_ST)*CG2.lambda.R;
        lambda.V=CG2.lambda.V;
%Host feeding rates
    b.SR=0;
    b.SS=CG2.b.SS*c.SS_ST+CG2.b.SR*(1-c.SS_ST);
    
    b.DR=0;
    b.DS=CG2.b.DS*c.DS_DT+CG2.b.DR*(1-c.DS_DT);
    b.DD=CG2.b.DD;
        
%Inits
    init=CG2.init;
    init(3:4,1)=init(3:4,1)+init(5:6,1);
    init(5:6,1)=zeros(2,1);
    init(9:10,1)=init(9:10,1)+init(11:12,1);
    init(11:12,1)=zeros(2,1);
    
    %Deprecated
    r.R=0;
%fracinfect
    fracinfect=CG2.fracinfect;
    fracinfect.SR=0;
    fracinfect.DR=0;
    params.PopProportions=CG2.PopProportions;
    params.b=b;
    params.bio=CG2.bio;
    params.N=N;
    params.gamma=gamma;
    params.alpha=alpha;
    params.beta=beta;
    params.lambda=lambda;
    params.r=r;
    params.init=init;
    params.fracinfect=fracinfect;
    params.tspan=CG2.tspan;    
end

