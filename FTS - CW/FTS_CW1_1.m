clear

% Question 1

%Magnetic Flux Density

p=1e-3;
N=50;
d=10e-3;
a=20e-3;
I=100;

mu0=(4*pi)*10^(-7);
%k=legendre(1,);

leng=p*N;
radius=d/2;
halfleng=leng/2;

fn1=(mu0*N*I)/(2*leng);
fn2=(a+halfleng)/(sqrt((radius^2)+(a+halfleng)^2));
fn3=(a-halfleng)/(sqrt((radius^2)+(a-halfleng)^2));

B=fn1*(fn2-fn3);%Magnetic Flux Density for a coil

%Total Magnetic Flux Density at the Origin

Borigin=sqrt(2*(B^2));

%Total Magnetic Field; Opposite Magnetic Flux Density
%Flux density should be the same but directed in a different
%direction which is 90degrees different to the previous MFD.

Htotal=Borigin/mu0;

%Flux Density Plot
%Changing the value of a from source to origin

a2=0:0.0001:0.02;
aleng=length(a2);
Bgraph=zeros(1,aleng);

for i=1:aleng 
ause=a2(i);    
fn4=(ause+halfleng)./(sqrt((radius^2)+(ause+halfleng).^2));
fn5=(ause-halfleng)./(sqrt((radius^2)+(ause-halfleng).^2));
Bgraph(i)=fn1*(fn4-fn5);
end

figure
f=plot(a2,Bgraph);
f.XData=f.XData*1000;%mm
f.YData=f.YData*1000;%mT
title('Magnetic Flux Density of a Helical Coil Along its Axis')
xlabel('Distance from Source(mm)')
ylabel('Magnetic Flux Density(mT)')
