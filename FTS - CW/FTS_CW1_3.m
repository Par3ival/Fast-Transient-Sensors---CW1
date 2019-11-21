clear

% Question 3

resis=27.2e-9; %Resistivity
a=4e-3;
b=10e-3;
La=10e-3;
Lb=10e-3;

mu0=(4*pi)*10^(-7);

%DC Resistance of Conductor

%Resistance of cylinders
Rcl=resis*((La)/(pi*(a^2)));
%Resistance of Cones
Rco=resis*((Lb)/(pi*(a*b)));
%Total DC Resistance
Rdc=(2*Rcl)+(2*Rco);

%Low Frequency Conductor Resistance Variation
f=1:5:200;
sigma=1/resis; %1/rho
fleng=length(f);
Ract=zeros(1,fleng);

for i=1:fleng
fuse=f(i);
%delta=503*sqrt((resis)/(1*fuse)); %Skin Depth approximation
delta=sqrt((resis)/(pi*fuse*mu0));

Sa=2*a*pi*delta*(1-((delta)/(2*a)));
Sb=2*b*pi*delta*(1-((delta)/(2*b)));

Raca=(La)/(sigma*Sa);
Racb=(Lb)/(sigma*Sb);
Ract(i)=2*(Raca+Racb);
end

figure
semilogx(f,Ract);
title('Resistance Variation of a Conductor')
xlabel('Frequency(Hz)')
ylabel('Resistance(mOhms)')





