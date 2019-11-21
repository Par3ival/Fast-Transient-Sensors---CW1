clear

% Question 5

mu0=(4*pi)*10^(-7);

R=50; %Resistance
L=150e-9; %Inductance
C=60e-9; %Capacitance
V0=40e3;

cmp=2*sqrt(L/C);
%Since R>cmp use critically damped eqn
% Time Variation of Current in RLC
t=0:2e-7:4e-6;
tleng=length(t);
It=zeros(1,tleng);
newIt=zeros(1,tleng);
w=sqrt((((R)/(2*L))^2)-((1)/(L*C)));
fn1=(V0)/(2*w*L);

for i=1:tleng
    tuse=t(i);
    fn2=exp(((-1)*((R)/(2*L)))*tuse);
    fn3=exp(w*tuse)-exp((-1)*w*tuse);
    It(i)=fn1*fn2*fn3;
    
end

figure(1)
plot(t,It)
title('Current Over Time')
xlabel('Time')
ylabel('Current (Amps)')

newIt=gradient(It(:))./gradient(t(:));

figure(2)
plot(t,newIt)
title('Rate of change')
xlabel('Time')
ylabel('Current (Amps/s)')


% Chosen Radii for Rogowski Coil
major=0.2; %Initially 0.1
minor=0.15; %Initially 0.01
%using a rearranged eqn of 0.0723=(A*N)/L
%Where A is cross area of small radius and L is circumference
%of the large radius
N=400;%Number of turns (144.5)
%Using CCS (Copper Clad Steel)
wired=0.8e-2;%Wire diameter
wireres=50;%Standard 50ohm cable
wireresist=0.082296;%Resistivity ohms/m
viewR=1e6;%10kohm

%Self inductance and Resistance
pitch=(2*pi*major)/(N);

Lfn1=(mu0*minor)*((2*pi*major)/(pitch));
Lfn2=((pi*minor)/(pitch))+log((2*pitch)/(wired))-((5)/(4));
Lfnsum=log((2*pi*major)/(pitch));
Lfnsum0=(0.0007*((Lfnsum)^0));
Lfnsum1=(0.1773*((Lfnsum)^1));
Lfnsum2=(((-1)*0.0322)*((Lfnsum)^2));
Lfnsum3=(0.00197*((Lfnsum)^3));
Lfnsumtotal=Lfnsum0+Lfnsum1+Lfnsum2+Lfnsum3;

Lfinal=Lfn1*(Lfn2-Lfnsumtotal);%Self Inductance

freq1=(1)/(4e-6);

wirelength=N*sqrt((pitch^2)+((2*pi*minor)^2));
area=pi*wired*sqrt((wireresist)/(pi*freq1*mu0));
Rfinal=wireresist*((wirelength)/(area));

%Current through the Rogowski Coil Graph
%Finding phi

kdiff=mu0*N*(major-sqrt((major^2)-(minor^2)));
Isens=zeros(1,tleng);

for p=1:tleng
    tuse2=t(p);
    phidiff=kdiff*It(p);%If rate of change, change to newIt(p)
    Ix=exp((Rfinal/Lfinal)*tuse2);
    IsFn1=(((Lfinal)/(Rfinal))*(phidiff^2))*(Ix-1);
    Isens(p)=(IsFn1)/(Ix);
end 

figure(3)
plot(t,Isens)
title('Approximate Current In Rogowski Coil')
xlabel('Time')
ylabel('Current (Amps)')

%newIsens=gradient(Isens(:))./gradient(t(:)); %Differential of Isensor
newIsens=gradient(Isens(:),t(:));

figure(4)
plot(t,newIsens)
title('Approximate Current Rate of Change In Rogowski Coil')
xlabel('Time')
ylabel('Current (Amps/s)')

%Show its an integrating coil
cmp1=Lfinal.*(newIsens(:));
cmp2=Rfinal.*(Isens(:));
figure(5)
plot(t,cmp1)
hold on
plot(t,cmp2)
hold off
title('Proof of Rogowski Coil Integration Mode ')
xlabel('Time')
ylabel('Voltage Output(V)')
%Looking at the output data it can be seen that this is an integrator
%This is due to the magnitude of cmp1>>cmp2 at all points other
%than the zero crossing points.

%Calc output voltage Isens*Rcv where Rcv is current viewing resistor(50ohm)

Voutput=viewR.*(Isens(:));
figure(6)
plot(t,Voutput)
title('Voltage Across Viewing Resistor (Rcv)')
xlabel('Time')
ylabel('Voltage (V)')




