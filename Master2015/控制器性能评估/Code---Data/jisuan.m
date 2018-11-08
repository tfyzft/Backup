clear all;
close all;
load('C:\Users\Administrator\Desktop\Data\imc_v_u.txt');
load('C:\Users\Administrator\Desktop\Data\imc_v_y.txt');
% imc_v_u=[0.0362823320000000;0.0178914050000000;0.0468134600000000;0.0211466310000000;0.0340929910000000;0.0168471240000000;0.0435528840000000;0.0198314330000000;0.0379181030000000;0.0186625120000000;0.0492104410000000;0.0221056200000000];
% imc_v_y=[0.785426660000000;0.716306320000000;1.03559310000000;0.869819380000000;0.737751060000000;0.673320310000000;0.975705380000000;0.831840530000000;0.821410000000000;0.747993830000000;1.08109810000000;0.899139250000000];
% 
x=0.0008881*imc_v_u.^(-1.141)+0.4642;
y=((imc_v_y-0.4642)./0.0008881).^(-1/1.141);

%%
a1=[imc_v_u(1)
imc_v_u(5)
imc_v_u(9)
imc_v_u(3)
imc_v_u(7)
imc_v_u(11)
];
b1=[y(1)
y(5)
y(9)
y(3)
y(7)
y(11)
];
c1=b1./a1;
a2=[imc_v_u(2)
imc_v_u(6)
imc_v_u(10)
imc_v_u(4)
imc_v_u(8)
imc_v_u(12)
];
b2=[y(2)
y(4)
y(6)
y(8)
y(10)
y(12)
];
c2=b2./a2;
% b-a
c2-c1

%%
a11=[imc_v_y(1)
imc_v_y(5)
imc_v_y(9)
imc_v_y(3)
imc_v_y(7)
imc_v_y(11)
];
b11=[x(1)
x(5)
x(9)
x(3)
x(7)
x(11)
];
c11=b11./a11;
a22=[imc_v_y(2)
imc_v_y(6)
imc_v_y(10)
imc_v_y(4)
imc_v_y(8)
imc_v_y(12)
];
b22=[x(2)
x(4)
x(6)
x(8)
x(10)
x(12)
];
c22=b22./a22;
% b-a
c22-c11

