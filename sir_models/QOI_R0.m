function R0 = QOI_R0(params, ode_soln)
% input: POIs and old_soln structure from ode solver
% output: Reproductive number
y=[params.session.popsize.SV-1;
    1;
    params.session.popsize.ST-1;
    1;
    params.session.popsize.DV-1;
    1;
    params.session.popsize.DT-1;
    1];
theta=params.theta;
p=params.p;
alpha=get_alpha(y,theta,p);

a_1=alpha.ST_SV;
a_2=alpha.DT_SV;
a_3=alpha.SV_ST;
a_4=alpha.DV_ST;
a_5=alpha.DT_DV;
a_6=alpha.ST_DV;
a_7=alpha.DV_DT;
a_8=alpha.SV_DT;
g_sm=params.mu.SV;
g_st=params.mu.ST;
g_dm=params.mu.DV;
g_dt=params.mu.DT;
l_SM_DM=params.lambda.SV_DV;
l_DM_SM=params.lambda.DV_SV;
l_ST_DT=params.lambda.ST_DT;
l_DT_ST=params.lambda.DT_ST;


F =[0    a_1+a_2   0      0  ;
    a_3+a_4 0      0      0   ;
    0       0      0    a_5+a_6  ;
    0       0   a_7+a_8   0  ];
V =[g_sm+l_DM_SM    0       -l_SM_DM            0      ;
       0        g_st+l_DT_ST     0          -l_ST_DT   ;
    -l_DM_SM        0        g_dm+l_SM_DM       0      ;
       0        -l_DT_ST        0         g_dt+l_ST_DT];
N=F/V;
N_eig=eig(N);
R0 = max(N_eig);
a=a_1*a_2*a_3*a_4*a_5*a_6*a_7*a_8;
g=(g_sm+l_SM_DM)*(g_st+l_ST_DT)*(g_dm+l_DM_SM)*(g_dt+l_DT_ST);
r=(g_dm*g_sm+g_dm*l_DM_SM+g_sm*l_SM_DM)*(g_dt*g_st+g_dt*l_DT_ST+g_st*l_ST_DT);
R0=sqrt(sqrt(sqrt(a)*g/(r^2)));

end
