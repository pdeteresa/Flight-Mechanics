clear;clc;
d2r = pi/180;
syms delta_E;
A_lon = [-1.0889e-2 +2.8539e+1 -2.3779e+1 -3.2154e+1;
-9.1949e-5 -7.9044e-1 +9.4864e-1 -1.6017e-3;
+3.1611e-5 -6.3460e-1 -1.0254e+0 0;
0 0 0 0];
B_lon = [+9.9851e+0 +1.6333e+1;
-1.0219e-1 0;
-1.1464e+1 0;
0 0];

A_lat = [-2.2351e-1 +3.4561e-2 -9.9532e-1 +4.5935e-2;
-3.0041e+1 -2.7294e+0 +5.1704e-1 0;
+8.3569e+0 -1.4062e-2 -3.6752e-1 0;
0 +1 +3.4868e-2 0];
B_lat = [+1.3281e-2 +3.5281e-2;
-4.3692e+1 +7.7641e+0;
-1.8776e+0 -3.8313e+0;
0 0];
c = eye(4);d = zeros(4,2);
t = linspace(0,10,1001);t=t';%0:0.01:10;t=t';
u = [delta_E.*ones(1,1001)%*d2r% zeros(1,1001-100)
    zeros(1,1001)].';
sys = ss(A_lon,B_lon,c,d);
% sys = ss(A_lat,B_lat,c,d);
systf = tf(sys);
%  lsim(systf(3,1),u(:,1),t);
%  figure(2)
%  lsim(systf(3,2),u(:,1),t);
%[y,x] = lsim(A_lat,B_lat,c,d,u,t);
lsim(systf(1,2),u(:,1),t);
title('V_{cm}');grid
% figure(2);
% lsim(systf(2,1),u(:,1),t);
% title('\alpha');grid
% figure(3);
% lsim(systf(3,1),u(:,1),t);
% title('q');grid
% figure(4);
% lsim(systf(4,1),u(:,1),t);
% title('\theta');grid
% error('you are a horrible person')
