%% Set 1: Single Patch
syms a_m a_t g_m g_t
F=[0 a_m; a_t 0];
V=[g_m 0; 0 g_t];
M=F*inv(V)
M_eig=eig(M)
%% Set 2: Double Patch, no migration
n=1;
if n==1
    %Pathway 1: SM<->ST
    syms a_sm1 a_sm2 a_st1 a_st2 a_dm1 a_dm2 a_dt1 a_dt2 g_sm g_st g_dm g_dt
    a_sm2=0;a_st2=0;a_dm1=0; a_dm2=0; a_dt1=0; a_dt2=0;
    F =[0    a_sm1   0  a_sm2;
        a_st1  0   a_st2    0;
        0    a_dm1   0  a_dm2;
        a_dt1  0   a_dt2   0];
    V =[g_sm 0   0    0   ;
         0  g_st 0    0   ;
         0   0  g_dm  0   ;
         0   0   0   g_dt];
    M=F*inv(V);
    M_eig=eig(M);
    R01=M_eig(3)
    % SM<->DT
    syms a_sm1 a_sm2 a_st1 a_st2 a_dm1 a_dm2 a_dt1 a_dt2 g_sm g_st g_dm g_dt
    a_sm1=0; a_st1=0; a_st2=0; a_dm1=0; a_dm2=0; a_dt2=0;
    F =[0    a_sm1   0  a_sm2;
        a_st1  0   a_st2    0;
        0    a_dm1   0  a_dm2;
        a_dt1  0   a_dt2   0];
    V =[g_sm 0   0    0   ;
         0  g_st 0    0   ;
         0   0  g_dm  0   ;
         0   0   0   g_dt];
    M=F*inv(V);
    M_eig=eig(M);
    R02=M_eig(3)
    % ST<->DM
    syms a_sm1 a_sm2 a_st1 a_st2 a_dm1 a_dm2 a_dt1 a_dt2 g_sm g_st g_dm g_dt
    a_sm1=0; a_sm2=0; a_st1=0; a_dm2=0; a_dt1=0; a_dt2=0;
    F =[0    a_sm1   0  a_sm2;
        a_st1  0   a_st2    0;
        0    a_dm1   0  a_dm2;
        a_dt1  0   a_dt2   0];
    V =[g_sm 0   0    0   ;
         0  g_st 0    0   ;
         0   0  g_dm  0   ;
         0   0   0   g_dt];
    M=F*inv(V);
    M_eig=eig(M);
    R03=M_eig(3)
    % DM<->DT
    syms a_sm1 a_sm2 a_st1 a_st2 a_dm1 a_dm2 a_dt1 a_dt2 g_sm g_st g_dm g_dt
    a_sm1=0; a_sm2=0;a_st1=0; a_st2=0; a_dm1=0; a_dt1=0;
    F =[0    a_sm1   0  a_sm2;
        a_st1  0   a_st2    0;
        0    a_dm1   0  a_dm2;
        a_dt1  0   a_dt2   0];
    V =[g_sm 0   0    0   ;
         0  g_st 0    0   ;
         0   0  g_dm  0   ;
         0   0   0   g_dt];
    M=F*inv(V);
    M_eig=eig(M);
    R04=M_eig(3)
end
R0=sqrt(sqrt(R01*R02*R03*R04))

%% Set 2
syms a_1 a_2 a_3 a_4 a_5 a_6 a_7 a_8 g_sm g_st g_dm g_dt l_m l_t S_SM S_ST S_DT S_DM
%Key:
%a_1=a^st_sm, a_2=a^dt_sm, a_3=a^sm_st, a_4=a^dm_st
%a_5=a^dt_dm, a_6=a^st_dm, a_7=a^dm_dt, a_8=a^sm_dt

%Sub-R0's
%a_2=0;a_4=0;a_5=0;a_6=0;a_7=0;a_8=0;         %r_1  a_1&a_3
%a_1=0;a_2=0;a_3=0;a_4=0;a_6=0;a_8=0;         %r_2  a_5&a_7
%a_1=0;a_3=0;a_4=0;a_5=0;a_6=0;a_7=0;         %r_3  a_2&a_8
%a_1=0;a_2=0;a_3=0;a_5=0;a_7=0;a_8=0;         %r_4  a_4&a_6
%a_2=0;a_3=0;a_5=0;a_6=0;a_7=0;a_8=0;         %r_5  a_1&a_4
%a_2=0;a_3=0;a_4=0;a_5=0;a_6=0;a_8=0;         %r_6  a_1&a_7
%a_2=0;a_3=0;a_4=0;a_5=0;a_6=0;a_7=0;         %r_7  a_1&a_8
%a_1=0;a_4=0;a_5=0;a_6=0;a_7=0;a_8=0;         %r_8  a_2&a_3
%a_1=0;a_3=0;a_5=0;a_6=0;a_7=0;a_8=0;         %r_9  a_2&a_4
%a_1=0;a_3=0;a_4=0;a_5=0;a_6=0;a_8=0;         %r_10 a_2&a_7
%a_1=0;a_2=0;a_4=0;a_6=0;a_7=0;a_8=0;         %r_11 a_5&a_3
%a_1=0;a_2=0;a_3=0;a_6=0;a_7=0;a_8=0;         %r_12 a_5&a_4
%a_1=0;a_2=0;a_3=0;a_4=0;a_6=0;a_7=0;         %r_13 a_5&a_8
%a_1=0;a_2=0;a_4=0;a_5=0;a_7=0;a_8=0;         %r_14 a_6&a_3
%a_1=0;a_2=0;a_3=0;a_4=0;a_5=0;a_8=0;         %r_15 a_6&a_7
%a_1=0;a_2=0;a_3=0;a_4=0;a_5=0;a_7=0;         %r_16 a_6&a_8

%Data Input
params=baseline_params();
a_1=params.alpha.ST_SV;
a_2=params.alpha.DT_SV;
a_3=params.alpha.SV_ST;
a_4=params.alpha.DV_DT;
a_5=params.alpha.DT_DV;
a_6=params.alpha.ST_DV;
a_7=params.alpha.DV_DT;
a_8=params.alpha.SV_DT;
g_sm=params.gamma.SV;
g_st=params.gamma.ST;
g_dm=params.gamma.DV;
g_dt=params.gamma.DT;
l_SM_DM=params.lambda.SV_DV;
l_DM_SM=params.lambda.DV_SV;
l_ST_DT=params.lambda.ST_DT;
l_DT_ST=params.lambda.DT_ST;


F =[0    a_1   0   a_2  ;
    a_3       a_4   0   ;
    0    a_5   0   a_6  ;
    a_7   0   a_8   0  ];
V =[g_sm+l_DM_SM    0       -l_SM_DM            0      ;
       0        g_st+l_DT_ST     0          -l_ST_DT   ;
    -l_DM_SM        0        g_dm+l_SM_DM       0      ;
       0        -l_DT_ST        0         g_dt+l_ST_DT];
N=F/V;
N_eig=eig(N);
latex(N_eig(3));



%% Set 1
%syms a_sv a_st a_dv a_dt g_sv g_st g_dv g_dt l_sv l_st l_dv l_dt
syms a_sv a_st a_dv a_dt g_sv g_st g_dv g_dt l_v l_t S_SV S_ST S_DT S_DV
% params=baseline_params();
% a_sv=params.theta.ST_SV*params.p.ST_SV;
% a_st=params.theta.SV_ST*params.p.SV_ST;
% a_dv=params.theta.DT_DV*params.p.DT_DV;
% a_dt=params.theta.DV_DT*params.p.DV_DT;
% g_sv=params.gamma.SV;
% g_st=params.gamma.ST;
% g_dv=params.gamma.DV;
% g_dt=params.gamma.DT;
% l_v=params.lambda.SV_DV;
% l_t=params.lambda.ST_DT;
a_dt=0; a_dv=0; %r1
a_st=0; a_sv=0; %r2
a_dt=0; a_sv=0; %r3

%r2
%r3
%r4
%a_sv=0;
%a_st=0;
a_dv=0;
a_dt=0;
%l_m=0;l_t=0;
F =[0   a_sv 0    0;
    a_st 0   0    0;
    0    0   0   a_dv;
    0    0 a_dt   0];
V =[g_sv+l_v    0       -l_v        0;
       0     g_st+l_t     0       -l_t;
    -l_v        0     g_dv+l_v      0;
       0      -l_t        0    g_dt+l_t];
Vinv=inv(V);
N=F*Vinv;
N_eig=eig(N)
