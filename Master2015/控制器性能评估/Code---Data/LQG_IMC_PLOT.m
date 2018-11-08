clear all
close all

load('C:\Users\Administrator\Desktop\Data\imc_v_u.txt');
load('C:\Users\Administrator\Desktop\Data\imc_v_y.txt');
load('C:\Users\Administrator\Desktop\Data\lqg_v_u.txt');
load('C:\Users\Administrator\Desktop\Data\lqg_v_y.txt');

plot(lqg_v_u,lqg_v_y,'.b','markersize',12)
% plot(v_u,v_y,':k','linewidth',1)
hold on
x=0.003:0.0001:0.2;
y=0.0008881*x.^(-1.141)+0.4642;
plot(x,y,':k','linewidth',1.5)
hold on
% plot(lqg_v_u,lqg_v_y,':k','linewidth',1)
% hold on

plot(imc_v_u(1),imc_v_y(1),'*b','markersize',5)
hold on
plot(imc_v_u(2),imc_v_y(2),'*r','markersize',5)
hold on
plot(imc_v_u(3),imc_v_y(3),'xb','markersize',5)
hold on
plot(imc_v_u(4),imc_v_y(4),'xr','markersize',5)
hold on
plot(imc_v_u(5),imc_v_y(5),'sb','markersize',5)
hold on
plot(imc_v_u(6),imc_v_y(6),'sr','markersize',5)
hold on
plot(imc_v_u(7),imc_v_y(7),'vb','markersize',5)
hold on
plot(imc_v_u(8),imc_v_y(8),'vr','markersize',5)
hold on
plot(imc_v_u(9),imc_v_y(9),'db','markersize',5)
hold on
plot(imc_v_u(10),imc_v_y(10),'dr','markersize',5)
hold on
plot(imc_v_u(11),imc_v_y(11),'pb','markersize',5)
hold on
plot(imc_v_u(12),imc_v_y(12),'pr','markersize',5)

h=legend('The Variance of Fitting Point','Achievable Performance Curve',...
'Current Parameter (Model 1) Setpoint 600 ^oC','Improved Parameter (Model 1) Setpoint 600 ^oC',...
'Current Parameter (Model 1) Setpoint 605 ^oC','Improved Parameter (Model 1) Setpoint 605 ^oC',...
'Current Parameter (Model 2) Setpoint 600 ^oC','Improved Parameter (Model 2) Setpoint 600 ^oC',...
'Current Parameter (Model 2) Setpoint 605 ^oC','Improved Parameter (Model 2) Setpoint 605 ^oC',...
'Current Parameter (Model 3) Setpoint 600 ^oC','Improved Parameter (Model 3) Setpoint 600 ^oC',...
'Current Parameter (Model 3) Setpoint 605 ^oC','Improved Parameter (Model 3) Setpoint 605 ^oC')

set(h,'Fontsize',10);
xlabel('Variance of Duty-Ratio')
ylabel('Variance of Temperature(^oC)')