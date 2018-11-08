clear all
close all

load('C:\Users\Administrator\Desktop\Data\imc_v_u.txt');
load('C:\Users\Administrator\Desktop\Data\imc_v_y.txt');
bar_v_u=[imc_v_u(1)        imc_v_u(2)
   imc_v_u(3)	imc_v_u(4)
   imc_v_u(5)	imc_v_u(6)
   imc_v_u(7)	imc_v_u(8)
   imc_v_u(9)	imc_v_u(10)
   imc_v_u(11)	imc_v_u(12)];
bar_v_y=[imc_v_y(1)        imc_v_y(2)
   imc_v_y(3)	imc_v_y(4)
   imc_v_y(5)	imc_v_y(6)
   imc_v_y(7)	imc_v_y(8)
   imc_v_y(9)	imc_v_y(10)
   imc_v_y(11)	imc_v_y(12)];
figure(1)
% subplot(121)
bar(bar_v_u);
% set(gca,'xticklabel',{'Model 1 (300^oC)','Model 2 (300^oC)','Model 3 (300^oC)',...
%     'Model 1 (305^oC)','Model 2 (305^oC)','Model 3 (305^oC)'});
set(gca,'xticklabel',{'Model 1 (600^oC)','Model 1 (605^oC)',...
    'Model 2 (600^oC)','Model 2 (605^oC)',...
    'Model 3 (600^oC)','Model 3 (605^oC)'});
% h = gca;
% th=rotateticklabel(h, 45);%调用下面的函数，坐标倾斜45度
h=legend('Current Parameter','Improved Parameter');
% set(h,'Fontsize',10);
ylabel('Variance of Duty Ratio');
% xlabel('Model')
% subplot(122)
figure(2)
bar(bar_v_y);
% set(gca,'xticklabel',{'Model 1(300^oC)','Model 2(300^oC)','Model 3(300^oC)',...
%     'Model 1(305^oC)','Model 2(305^oC)','Model 3(305^oC)'});
set(gca,'xticklabel',{'Model 1 (600^oC)','Model 1 (605^oC)',...
    'Model 2 (600^oC)','Model 2 (605^oC)',...
    'Model 3 (600^oC)','Model 3 (605^oC)'});
% h = gca;
% th=rotateticklabel(h, 45);%调用下面的函数，坐标倾斜45度
 h=legend('Current Parameter','Improved Parameter');
% set(h,'Fontsize',10);
ylabel('Variance of Temperature (^oC)');
% xlabel('Model')

