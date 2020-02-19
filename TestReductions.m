%Define full params
params.sigma1=2;
params.sigma2=2;
params.sigma3=10;
params.lambda1=5;
params.lambda2=3;
params.lambda3=6;
params.epsilon1=1;
params.epsilon2=2;

x=linspace(0,10,500);

yFull=[1 1 1 1];
yReduced=[1 1 2];

ODE1=@(t,y) ODEFull(t,y,params);
ODE2=@(t,y) ODESimplified(t,y,params);
ResultsFull=ode45(ODE1,x,yFull);

ResultsReduced=ode45(ODE2,x,yReduced);

yFull=ResultsFull.y;
yReduced=ResultsReduced.y;

yFull(3,:)=yFull(3,:)+yFull(4,:);
yFull(4,:)=[];

if size(yFull,2)>=size(yReduced,2)
    yFull(:,1:size



function dydt=ODEFull(t,y,params)
sigma1=params.sigma1;
sigma2=params.sigma2;
sigma3=params.sigma3;
epsilon1=params.epsilon1;
epsilon2=params.epsilon2;
lambda1=params.lambda1;
lambda2=params.lambda2;
lambda3=params.lambda3;
dydt=NaN(4,1);
dydt(1)=sigma1-epsilon1*y(3)*y(1)-epsilon2*y(4)*y(1);
dydt(2)=epsilon1*y(3)*y(1)-epsilon2*y(4)*y(1)-lambda1*y(2);
dydt(3)=sigma2-y(3)*lambda2;
dydt(4)=sigma3-y(4)*lambda3;
end
function dydt=ODESimplified(t,y,params)

sigma1=params.sigma1;
sigma2=params.sigma2;
sigma3=params.sigma3;
epsilon1=params.epsilon1;
epsilon2=params.epsilon2;
lambda1=params.lambda1;
lambda2=params.lambda2;
lambda3=params.lambda3;

%Convert Params
s1=sigma1;
s2=sigma2;
e1=(epsilon1*(sigma2*lambda3)+epsilon2*sigma3*lambda2)/(sigma2*lambda3+sigma3*lambda2);
l1=lambda1;
l2=lambda2;
dydt=NaN(3,1);
dydt(1)=s1-e1*y(3)*y(1);
dydt(2)=e1*y(3)*y(1)-l1*y(2);
dydt(3)=s2-y(3)*l2;

end