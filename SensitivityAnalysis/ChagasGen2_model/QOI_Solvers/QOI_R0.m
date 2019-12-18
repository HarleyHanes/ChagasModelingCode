function [R0,N_eig] = QOI_R0(params,bool)
% input: POIs and old_soln structure from ode solver
% output: Reproductive number
if strcmpi('numeric',bool)==1
    N=params.N;
    NSV=N.SV;
    NDV=N.DV;
    NSS=N.SS;
    NDS=N.DS;
    NSR=N.SR;
    NDR=N.DR;
    NDD=N.DD;
%     y=[NSV-1;
%         1;
%         NSS-1;
%         1;
%         NSR-1;
%         1;
%         NDV-1;
%         1;
%         NDS-1;
%         1;
%         NDR-1;
%         1;
%         NDD-1;
%         1];
    alpha=params.alpha;
    beta=params.beta;
    gamma=params.gamma;
    lambda=params.lambda;
    
    aSV_SS=alpha.SV_SS;
    aSV_SR=alpha.SV_SR;
    aDV_DS=alpha.DV_DS;
    aDV_DR=alpha.DV_DR;
    aDV_DD=alpha.DV_DD;
    aSS_SV=alpha.SS_SV;
    aSR_SV=alpha.SR_SV;
    aDS_DV=alpha.DS_DV;
    aDR_DV=alpha.DR_DV;
    aDD_DV=alpha.DD_DV;
    
    betaSV_SS=beta.SV_SS;
    betaSV_SR=beta.SV_SR;
    betaDV_DS=beta.DV_DS;
    betaDV_DR=beta.DV_DR;
    betaDV_DD=beta.DV_DD;
    
    bSS=params.b.SS;
    bSR=params.b.SR;
    bDS=params.b.DS;
    bDR=params.b.DR;
    bDD=params.b.DD;
    
    gSV=gamma.SV;
    gDV=gamma.DV;
    gSS=gamma.SS;
    gDS=gamma.DS;
    gSR=gamma.SR;
    gDR=gamma.DR;
    gDD=gamma.DD;
    
    lDV_SV=lambda.V;
    lSV_DV=lambda.V*(NSV/(NDV+10^(-12)));   %Check this is correct

    lDS_SS=lambda.S;
    lSS_DS=lambda.S*(NSS/(NDS+10^(-12)));   %Check this is correct

    lDR_SR=lambda.R;
    lSR_DR=lambda.R*(NSR/(NDR+10^(-12)));   %Check this is correct

else
    syms aSV_SS aSV_SR aDV_DS aDV_DR aDV_DD aSS_SV aSR_SV aDS_DV aDR_DV aDD_DV
    syms bSV_SS bSV_SR bDV_DS bDV_DR bDV_DD
    syms NSV NDV NSS NDS NSR NDR NDD
    syms gSV gDV gSS gDS gSR gDR gDD
    syms l_SS_DS l_DS_SS l_SV_DV l_DV_SV l_SR_DR l_DR_SR

end

% [   SV       SS            SR       DV          DS      DR      DD ]
F=[   0  aSS_SV*N.SV/N.SS   aSR_SV*N.SV/N.SR     0           0       0       0 ;  %SV
  (aSV_SS+betaSV_SS)*N.SS/N.SV 0       0        0           0       0       0 ;  %SS
  (aSV_SR+betaSV_SR)*N.SR/N.SV 0       0        0           0       0       0 ;  %SR
      0         0       0        0        aDS_DV*N.DV/N.DS  aDR_DV*N.DV/N.DR aDD_DV*N.DV/N.DD   ;  %DV
      0         0       0  (aDV_DS+betaDV_DS)*N.DS/N.DV     0       0       0 ;  %DS
      0         0       0  (aDV_DR+betaDV_DR)*N.DR/N.DV     0       0       0 ;  %DR
      0         0       0  (aDV_DD+betaDV_DD)*N.DD/N.DV     0       0       0    %DD
];


%[   SV            SS             SR         DV          DS            DR             DD ]
V=[gSV+lDV_SV  bSS*NSS/NSV^2  bSR*NSR/NSV^2   -lSV_DV        0             0              0     ;  %SV
      0        gSS+lDS_SS         0          0        -lSS_DS          0              0     ;  %SS
      0            0          gSR+lDR_SR     0           0          -lSR_DR           0     ;  %SR
    -lDV_SV        0              0      gDV+lSV_DV  bDS*NDS/NDV^2   bDR*NDR/NDV^2   bDD*NDD/NDV^2;  %DV
      0         -lDS_SS           0          0        gDS+lSS_DS       0              0     ;  %DS
      0            0          -lDR_SR        0           0         gDR+lSR_DR         0     ;  %DR
      0            0              0          0           0             0              gDD      %DD
];
% 
% V=[gSV+lDV_SV   0      0    -lSV_DV        0       0       0 ;  %SV
%       0    gSS+lDS_SS   0        0        -lSS_DS    0       0 ;  %SS
%       0        0   gSR+lDR_SR   0           0    -lSR_DR    0 ;  %SR
%     -lDV_SV     0       0    gDV+lSV_DV     0      0       0 ;  %DV
%       0      -lDS_SS    0        0        gDS+lSS_DS  0       0 ;  %DS
%       0         0     -lDR_SR    0           0   gDR+lSR_DR  0 ;  %DR
%       0         0       0        0           0       0      gDD   %DD
% ];
% V=[gSV+lDV_SV   0      0    -lSV_DV        0       0       0 ;  %SV
%       bSS    gSS+lDS_SS   0        0        -lSS_DS    0       0 ;  %SS
%       bSR       0   gSR+lDR_SR   0           0    -lSR_DR    0 ;  %SR
%     -lDV_SV     0       0    gDV+lSV_DV     0      0       0 ;  %DV
%       0      -lDS_SS    0        bDS       gDS+lSS_DS  0       0 ;  %DS
%       0         0     -lDR_SR    bDR           0   gDR+lSR_DR  0 ;  %DR
%       0         0       0        bDR           0       0      gDD   %DD
% ];

%Resize V for 0's
i=1;
while i<=length(V)
    if sum(V(:,i))==0
        V(:,i)=[];
        V(i,:)=[];
        F(:,i)=[];
        F(i,:)=[];
    else
        i=i+1;
    end
end
Vinv=inv(V);
N=F*Vinv;
%N=F/V;
N_eig=eig(N);
if strcmpi(bool,'numeric')==1
    R0=max(abs(real(N_eig)));
else
    R0=latex(N_eig(3));
end

end
