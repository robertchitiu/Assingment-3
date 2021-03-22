function [] = Electron_Modelling(FlowX,FlowY,nx,ny)

numpart=1000; 
color=['k' 'b' 'g' 'r' 'm'];
x0=rand(1,numpart)/10^7; %starting points
y0=rand(1,numpart)/10^7;

watchers = randi(numpart, 5,1);

Kb=1.38 * 10^ -23;%boltzman contant
T=300;%tempurature in K
m=9.1 * 10^ -31;%mass of electron
Vth=sqrt(2*Kb*T/m);%thermal velocity
dt=0.1*10^-12;%change in time 0.1 ps
q=1.6*10^-19;

o=rand(1,numpart)*2*pi; %angle of movement
Vx=Vth*sin(o);
Vy=Vth*cos(o);
    
clf   

for i=2:100
    x1=x0+Vx*dt ;
    y1=y0+Vy*dt ;
    
    %top bondary condition
    Vy(y1>=100*10^-9)=-1*Vy(y1>=100*10^-9);
    x1(y1>=100*10^-9)=(100*10^-9-y0(y1>=100*10^-9)).*(x1(y1>=100*10^-9)-x0(y1>=100*10^-9))./(y1(y1>=100*10^-9)-y0(y1>=100*10^-9)) + x0(y1>=100*10^-9);
    y1(y1>=100*10^-9)=100*10^-9;
    %bottom Bondary condition
    Vy(y1<=0)=-1*Vy(y1<=0);
    x1(y1<=0)=(0-y0(y1<=0)).*(x1(y1<=0)-x0(y1<=0))./(y1(y1<=0)-y0(y1<=0)) + x0(y1<=0);
    y1(y1<=0)=0;
    %left bondary condition
    y1(x1<0)=(y1(x1<0)-y0(x1<0))./(x1(x1<0)-x0(x1<0)).*(0-x0(x1<0))+y0(x1<0);
    x1(x1<0)=0;
    %right bondary condition
    y1(x1>150*10^-9)=(y1(x1>150*10^-9)-y0(x1>150*10^-9))./(x1(x1>150*10^-9)-x0(x1>150*10^-9)).*(150*10^-9-x0(x1>150*10^-9))+y0(x1>150*10^-9);
    x1(x1>150*10^-9)=150*10^-9;
    
    for j=1:5
    figure(5)
    plot([x0(watchers(j)) x1(watchers(j))], [y0(watchers(j)) y1(watchers(j))],color(j),'linewidth',1)
    xlim([0, 150*10^-9]);
    ylim([0, 100*10^-9]);
    hold on
    end
    %Left side condition
    x1(x1==150*10^-9 & Vx>0)=0;
    %Right side condition
    x1(x1==0 & Vx<0)=150*10^-9;
    
    
    
    
    x0=x1;
    y0=y1;
    pause(0.05);
end

      
