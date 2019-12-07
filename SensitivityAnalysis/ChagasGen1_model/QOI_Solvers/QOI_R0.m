function [R0,N_eig] = QOI_R0(params,bool)
% input: POIs and old_soln structure from ode solver
% output: Reproductive number
if strcmpi('numeric',bool)==1
    popsize=params.popsize;
    popsizeSH=popsize.SH;
    popsizeSV=popsize.SV;
    popsizeDH=popsize.DH;
    popsizeDV=popsize.DV;
    y=[popsize.SH-1;
        1;
        popsize.SV-1;
        1;
        popsize.DH-1;
        1;
        popsize.DV-1;
        1];
    theta=params.theta;
    p=params.p;
    lambda=params.lambda;
    ratio=params.ratio;
    a_1=theta.SV_SH*p.SV_SH;
    a_2=theta.DV_SH*p.DV_SH;
    a_3=theta.SH_SV*p.SH_SV;
    a_4=theta.DH_SV*p.DH_SV;
    a_5=theta.SV_DH*p.SV_DH;
    a_6=theta.DV_DH*p.DV_DH;
    a_7=theta.SH_DV*p.SH_DV;
    a_8=theta.DH_DV*p.DH_DV;
    % a_1=alpha.SV_SH;
    % a_2=alpha.DV_SH;
    % a_3=alpha.SH_SV;
    % a_4=alpha.DH_SV;
    % a_5=alpha.DV_DH;
    % a_6=alpha.SV_DH;
    % a_7=alpha.DH_DV;
    % a_8=alpha.SH_DV;
    g_SH=params.mu.SH;
    g_SV=params.mu.SV;
    g_DH=params.mu.DH;
    g_DV=params.mu.DV;
    l_DH_SH=lambda.H;
    l_SH_DH=lambda.H/ratio.SH_DH;
    l_DV_SV=lambda.V;
    l_SV_DV=lambda.V/ratio.SV_DV;
else
    syms a_1 a_2 a_3 a_4 a_5 a_6 a_7 a_8 
    syms popsizeSH popsizeSV popsizeDH popsizeDV
    syms g_SH g_SV g_DH g_DV ;
    syms l_SH_DH l_DH_SH l_SV_DV l_DV_SV;
%     a_1=0; 
%     a_2=0; 
%     a_3=0; 
%     %a_4=0; 
%     a_5=0; 
%     %a_6=0; 
%     a_7=0; 
%     a_8=0;
end


% F =[0                   a_1      0             a_2  ;
%     a_3           0        a_4          0           ;
%     0                   a_5      0             a_6  ;
%     a_7          0        a_8          0          ];
F =[0                   a_1      0             a_2  ;
    a_3           0        a_4          0           ;
    0                   a_5      0             a_6  ;
    a_7           0        a_8          0          ];
% F =[0                   a_1*popsizeSH/popsizeSV      0             a_2*popsizeSH/popsizeDV  ;
%     a_3*popsizeSV/popsizeSH           0        a_4*popsizeSV/popsizeDH          0           ;
%     0                   a_5*popsizeDH/popsizeSV      0             a_6*popsizeDH/popsizeDV  ;
%     a_7*popsizeDV/popsizeSH           0        a_8*popsizeDV/popsizeDH          0          ];
V =[g_SH+l_SH_DH    0       -l_SH_DH            0      ;
       0        g_SV+l_SV_DV     0          -l_SV_DV   ;
    -l_DH_SH        0        g_DH+l_DH_SH       0      ;
       0        -l_DV_SV        0         g_DV+l_DV_SV];

Vinv=inv(V);
N=F*Vinv;
%N=F/V;
N_eig=eig(N);
if strcmpi(bool,'numeric')==1
    %R0= max(N_eig);
    R0=max(abs(real(N_eig)));
    a=a_1*a_2*a_3*a_4*a_5*a_6*a_7*a_8;
    g=(g_SH+l_SH_DH)*(g_SV+l_SV_DV)*(g_DH+l_DH_SH)*(g_DV+l_DV_SV);
    r=(g_DH*g_SH+g_DH*l_DH_SH+g_SH*l_SH_DH)*(g_DV*g_SV+g_DV*l_DV_SV+g_SV*l_SV_DV);
    %R0(2)=(sqrt(sqrt(a)*g)/r^2)^(1/2);
    %R0(3)=(sqrt(sqrt(a)*g)/r^2)^(1/8);
    l=l_SH_DH*l_DH_SH*l_SV_DV*l_DV_SV;
    %R0=sqrt((a*l)^(1/4)*g^(3/16)/r);
else
    R0=latex(N_eig(3));
end
%a=a_1*a_2*a_3*a_4*a_5*a_6*a_7*a_8;
%g=(g_SH+l_SH_DH)*(g_SV+l_SV_DV)*(g_DH+l_DH_SH)*(g_DV+l_DV_SV);
%r=(g_DH*g_SH+g_DH*l_DH_SH+g_SH*l_SH_DH)*(g_DV*g_SV+g_DV*l_DV_SV+g_SV*l_SV_DV);
%R0=sqrt(sqrt(sqrt(a)*g)/r^2);

end
