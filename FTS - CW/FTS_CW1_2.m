clear

% Question 2

x=1e-2;
n1=2;
n2=3;
R1=0.1;
R2=0.02;
I1=200;
I2=300;

mu0=(4*pi)*10^(-7);

%Magnetic Flux Density Midway point

mid=x/2;

B1=(mu0*(R1^2)*I1)/(2*(((R1^2)+(mid^2))^(3/2)));
B2=(mu0*(R2^2)*I2)/(2*(((R2^2)+(mid^2))^(3/2)));

%Using helmholtz coils as a base, the equation has been interpreted
%to obtain the mag flux density at the midway point

Bmidsame=B1+B2;%Both Currents flowing in the same direction
Bmiddiff=B1-B2;%Both Currents flowing in the opposite direction

%Magnetic Flux Density at point x and estimate of Mutual Inductance

B1x=(mu0*(R1^2)*I1)/(2*(((R1^2)+(x^2))^(3/2)));
M12estimate=B1x*(pi*(R2^2));
M12estimate2=(n2*B1x)/(I1);

%Magnetic Flux Density at point P

xmidp=sqrt((R2^2)+(mid^2));

B1p=(mu0*(R1^2)*I1)/(2*(((R1^2)+(xmidp^2))^(3/2)));
B2p=(mu0*(R2^2)*I2)/(2*(((R2^2)+(xmidp^2))^(3/2)));

BpTotal=sqrt((B1p^2)+(B2p^2));

%More accurate Mutual Inductance

k=(2*sqrt(R1*R2))/(sqrt(((R1+R2)^2)+(x^2)));
[K,E] = ellipke(k);

Mfn1=(2*mu0*sqrt(R1*R2))/(k);
Mfn2=((1-((k^2)/(2)))*K)-E;
Macc=Mfn1*Mfn2;


