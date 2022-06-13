clear
clc
close all

%% Parameters

m1 = 1;     % kg
m2 = 0.25;     % kg
l1 = 0.5;   % m
l2 = 0.25;   % m
g = 9.81;   % ms^-2

p = [m1, m2, l1, l2, g];

%%

x0 = [0.9*pi/2, 0, 0.8*pi/2, 0];
tstep = 0.1;
time = 0:tstep:10;

data = [];
for t = time
    [T,X] = ode15s(@DoublePendulum,[t t+tstep],x0,[],p);
    x0 = X(end,:);
    data = [data; T(2:end) X(2:end,:)];
end

%% Animation

figure
set(gcf,'position',[560,320,1000,700])
set(groot,'defaultAxesTickLabelInterpreter','latex');  

for i = 1:size(data,1)
    if rem(i,3) == 0
        th = data(i,2); ps = data(i,4);
        clf
        plot([0 l1*sin(th)],[0 -l1*cos(th)],'k','LineWidth',1.2)
        hold on
        plot([l1*sin(th) l1*sin(th)+l2*sin(ps)], [-l1*cos(th) -l1*cos(th)-l2*cos(ps)],'k','LineWidth',1.2)
        plot(l1*sin(th),-l1*cos(th),'ro','LineWidth',5)
        plot(l1*sin(th)+l2*sin(ps),-l1*cos(th)-l2*cos(ps),'ro','LineWidth',5)
        hold off    
        axis('equal')
        xlim([-l1-l2 l1+l2])
        ylim([(-l1-l2)*1.1 (l1+l2)*0.2])
        set(gca,'xtick',[])
        set(gca,'xticklabel',[])
        set(gca,'ytick',[])
        set(gca,'yticklabel',[])
        title(['Time ',num2str(data(i,1),'%0.2f'),'s'],'Interpreter','latex','FontSize',14)
        drawnow
    end
end