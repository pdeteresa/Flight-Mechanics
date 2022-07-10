clear;clc;
% problem 3
th_1 = 1.9970;
d2r = pi/180;r2d = 180/pi;
A_lat = [-2.2351e-1 +3.4561e-2 -9.9532e-1 +4.5935e-2
-3.0041e+1 -2.7294e+0 +5.1704e-1 0
+8.3569e+0 -1.4062e-2 -3.6752e-1 0
0 +1 +3.4868e-2 0];
B_lat = [+1.3281e-2 +3.5281e-2
-4.3692e+1 +7.7641e+0
-1.8776e+0 -3.8313e+0
0 0];
% C = eye(4);
% D = zeros(4,2);
A_lat5 = [A_lat zeros(4,1)
    0 0 1/cosd(th_1) 0 0];
B_lat5 = [B_lat;0 0];
C5 = eye(5);D5 = zeros(5,2);

tfinal = 15;

t = linspace(0,tfinal,tfinal*100+1);
u = [-1.*flip(gensig('square',2*tfinal-1,tfinal,0.01))'
zeros(1,tfinal*100+1)].';
[x_lat5, y_lat5] = lsim(A_lat5,B_lat5,C5,D5,u,t);

sys5 = ss(A_lat5,B_lat5,C5,D5);
systf5 = tf(sys5)
beta_tf = systf5(1,1);
phi_tf = systf5(4,1);
psi_tf = systf5(5,1);

% % figure(1)
% % hold
% % plot(t,x_lat5(:,1)) % beta / delta_A tf
% % 
% % title1 = append('\beta(s) / \delta_A(s) response, t_{final} = ',num2str(tfinal),' sec');
% % title(title1);
% % grid('on');hold('off');

figure(2)
hold
plot(t,x_lat5(:,4)) % phi / delta_A tf

title2 = append('\phi(s) / \delta_A(s) response, t_{final} = ',num2str(tfinal),' sec');
title(title2);
grid('on');hold('off');

% % figure(1)
% % rlocus(beta_tf);
% % xlim([-7,1]);ylim([-4,4]);
% % title('\beta(s) / \delta_A(s)');
% % figure(2)
% % rlocus(phi_tf);
% % xlim([-7,1]);ylim([-4,4]);
% % title('\phi(s) / \delta_A(s)');
% % figure(3)
% % rlocus(psi_tf);
% % xlim([-7,1]);ylim([-4,4]);
% % title('\psi(s) / \delta_A(s)');

