clear;clc;
% problem 1
d2r = pi/180;r2d = 180/pi;
% syms delta_E;

A_lon = [-1.0889e-2 +2.8539e+1 -2.3779e+1 -3.2154e+1
-9.1949e-5 -7.9044e-1 +9.4864e-1 -1.6017e-3
+3.1611e-5 -6.3460e-1 -1.0254e+0 0
0 0 1 0];
B_lon = [+9.9851e+0 +1.6333e+1
-1.0219e-1 0
-1.1464e+1 0
0 0];
A_lat = [-2.2351e-1 +3.4561e-2 -9.9532e-1 +4.5935e-2
-3.0041e+1 -2.7294e+0 +5.1704e-1 0
+8.3569e+0 -1.4062e-2 -3.6752e-1 0
0 +1 +3.4868e-2 0];
B_lat = [+1.3281e-2 +3.5281e-2
-4.3692e+1 +7.7641e+0
-1.8776e+0 -3.8313e+0
0 0];
C = eye(4);
D = zeros(4,2);


t = linspace(0,1000,1001);
u = [-1.*flip(gensig('square',18,10,0.01))'
zeros(1,1001)].';
% u = flip(u,2);

sys = ss(A_lon,B_lon,C,D);
systf = tf(sys);
[y_lat,x_lat] = lsim(A_lat,B_lat,C,D,u,t);

% transfer function for alpha & theta due to delta_E
% first input of u, second and fourth transfer functions
alpha_tf = systf(2,1)
theta_tf = systf(4,1)
figure(1);
rlocus(alpha_tf);title('\alpha(s) pole-zero plot');
xlim([-3,1]);ylim([-2,2]);
figure(2);
rlocus(theta_tf);title('\theta(s) pole-zero plot');
xlim([-3,1]);ylim([-2,2]);
alpha_zeros = [-107.5 0;-0.0058 0.0552;-0.0058 -0.0552];
alpha_poles = [-0.0056 0.0431;-0.0056 -0.0431;-0.9080 0.7678;-0.9080 -0.7678];
[y_lon,x_lon] = lsim(A_lon,B_lon,C,D,u,t);
% figure(1);
% plot(t,x_lon(:,2));grid;title('\alpha,  \delta_E = -0.1 deg = -0.0017453 rad');
% xlabel('time (s)');ylabel('Amplitude');
% figure(2);
% plot(t,x_lon(:,4));grid;title('\theta,  \delta_E = -0.1 deg = -0.0017453 rad');
% xlabel('time (s)');ylabel('Amplitude');