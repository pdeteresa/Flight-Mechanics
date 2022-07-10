clear;clc;format short e;
c = 10;xscm = 6.8148;d = 6;h = 2;b = 10;
 r2d = 180/pi; d2r = pi/180; % deg/rad, rad/deg
% Compute Aircraft Motion-Load Data
 p = -30*d2r; q = +10*d2r; r = -20*d2r; % deg/s
 pd = -28*d2r; qd = +12*d2r; rd = +3 *d2r; % deg/s^2
 l = -5000; m = +1500; n = -2300; % ft lbf
 hcm = +24000; % slug ft^2/s

 r2d = 180/pi; d2r = pi/180; % deg/rad, rad/deg
% Compute Aircraft Motion Profile Data
 p_s = +3*d2r; thta_s = +0*d2r; r_s = +3*d2r; % deg/s, deg, deg/s
 u_s = +500; v_s = +30; w_s = +30; % ft/s, ft/s, ft/s
 phi_1 = +0*d2r; thta_1 = +0*d2r; psi_1 = +270*d2r; % deg, deg, deg
 x_1 = +1000; y_1 = +1000; z_1 = -10000; % ft, ft, ft
 t_1 = +0; t_2 = +10; % s, s
% Compute Trajectories
 n = 1001; t = linspace(t_1,t_2,n).';
 phi = NaN(n,1); thta = NaN(n,1); psi = NaN(n,1);
 x = NaN(n,1); y = NaN(n,1); z = NaN(n,1);
 for i = 1:n
 phi(i) = p_s*t(i);
 thta(i) = thta_1 ;
 psi(i) = psi_1 + r_s*t(i);
 c_pt = cos(p_s*t(i)); s_pt = sin(p_s*t(i));
 c_rt = cos(r_s*t(i)); s_rt = sin(r_s*t(i));
 x(i) = x_1 + u_s/r_s*(1-c_rt) + v_s/p_s/2*s_pt*c_pt + w_s/p_s/2*s_pt^2;
 y(i) = y_1 - u_s/r_s*s_rt - v_s/p_s/2*s_pt^2 - w_s/p_s/2*(s_pt*c_pt-p_s*t(i));
 z(i) = z_1 + v_s/p_s *(1-c_pt) + w_s/p_s *s_pt;
 end
 
Psi = [psi(1) psi(250) psi(500) psi(750) psi(1000)];
Theta = [thta(1) thta(250) thta(500) thta(750) thta(1000)];
Phi = [phi(1) phi(250) phi(500) phi(750) phi(1000)];% euler angles
% psi = 270, theta = phi = 0 (deg)
Ct = cos(Theta(1));Cs = cos(Psi(1));Cp = cos(Phi(1));
St = sin(Theta(1));Ss = sin(Psi(1));Sp = sin(Phi(1));
T1 = [Ct*Cs Ct*Ss -St;
    -Cp*Ss+Sp*St*Cs Cp*Cs+Sp*St*Ss Sp*Ct;
    Sp*Ss+Cp*St*Cs -Sp*Cs+Cp*St*Ss Cp*Ct];T2 = T1.';% Body -> Earth axes
% psi = 277.47, theta = 0, phi = 7.47 (deg)
Ct = cos(Theta(2));Cs = cos(Psi(2));Cp = cos(Phi(2));
St = sin(Theta(2));Ss = sin(Psi(2));Sp = sin(Phi(2));
T3 = [Ct*Cs Ct*Ss -St;
    -Cp*Ss+Sp*St*Cs Cp*Cs+Sp*St*Ss Sp*Ct;
    Sp*Ss+Cp*St*Cs -Sp*Cs+Cp*St*Ss Cp*Ct];T4 = T3.';
% psi = 284.97, theta = 0, phi = 14.97 (deg)
Ct = cos(Theta(3));Cs = cos(Psi(3));Cp = cos(Phi(3));
St = sin(Theta(3));Ss = sin(Psi(3));Sp = sin(Phi(3));
T5 = [Ct*Cs Ct*Ss -St;
    -Cp*Ss+Sp*St*Cs Cp*Cs+Sp*St*Ss Sp*Ct;
    Sp*Ss+Cp*St*Cs -Sp*Cs+Cp*St*Ss Cp*Ct];T6 = T5.';
% psi = 292.47, theta = 0, phi = 22.47 (deg)
Ct = cos(Theta(4));Cs = cos(Psi(4));Cp = cos(Phi(4));
St = sin(Theta(4));Ss = sin(Psi(4));Sp = sin(Phi(4));
T7 = [Ct*Cs Ct*Ss -St;
    -Cp*Ss+Sp*St*Cs Cp*Cs+Sp*St*Ss Sp*Ct;
    Sp*Ss+Cp*St*Cs -Sp*Cs+Cp*St*Ss Cp*Ct];T8 = T7.';
% psi = 299.97, theta = 0, phi = 29.97 (deg)
Ct = cos(Theta(5));Cs = cos(Psi(5));Cp = cos(Phi(5));
St = sin(Theta(5));Ss = sin(Psi(5));Sp = sin(Phi(5));
T9 = [Ct*Cs Ct*Ss -St;
    -Cp*Ss+Sp*St*Cs Cp*Cs+Sp*St*Ss Sp*Ct;
    Sp*Ss+Cp*St*Cs -Sp*Cs+Cp*St*Ss Cp*Ct];T10 = T9.';

f = 75; % scaling factor
dx=[x(1) x(250) x(500) x(750) x(1001)];
dy=[y(1) y(250) y(500) y(750) y(1001)];
dz=[z(1) z(250) z(500) z(750) z(1001)]; % x y z position of cm on trajectory

% Plot Trajectories
%  figure(1), clf
%  plot3(phi *r2d,thta *r2d,psi *r2d,'-k'), hold
%  plot3(phi(1)*r2d,thta(1)*r2d,psi(1)*r2d,'*g')
%  plot3(phi(n)*r2d,thta(n)*r2d,psi(n)*r2d,'*r'), hold
%  aw = [-5 +35 -20 +20 +265 +305]; axis(aw)
%  av = [+20 +25]; view(av)
%  grid
%  xlabel('\Phi (deg)'), ylabel('\Theta (deg)'), zlabel('\Psi (deg)')
 figure(1), clf
 plot3(x ,y ,z ,'-k'), hold
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 plot3(x(1),y(1),z(1),'*g')
 plot3(x(n),y(n),z(n),'*r'), hold
 hold('on')
 
x1 = f.*(-c+xscm)*ones(1,6).';
x2 = f.*[-c+xscm xscm xscm xscm -c+xscm xscm-d].';
y1 = f.*(b/2)*[-1 1 -1 0 0 0].';
y2 = f.*(b/2)*[1 0 0 0 0 0].';
z1 = -f.*[0 0 0 0 0 h].';z2=-f.*[0 0 0 0 h 0].';
v11 = [x1(1),y1(1),z1(1)].';
v12 = [x2(1),y2(1),z2(1)].';
v21 = [x1(2),y1(2),z1(2)].';
v22 = [x2(2),y2(2),z2(2)].';
v31 = [x1(3),y1(3),z1(3)].';
v32 = [x2(3),y2(3),z2(3)].';
v41 = [x1(4),y1(4),z1(4)].';
v42 = [x2(4),y2(4),z2(4)].';
v51 = [x1(5),y1(5),z1(5)].';
v52 = [x2(5),y2(5),z2(5)].';
v61 = [x1(6),y1(6),z1(6)].';
v62 = [x2(6),y2(6),z2(6)].';
% first point, t = 0
v111=T2*v11;v112=T2*v12;v121=T2*v21;v122=T2*v22;
v131=T2*v31;v132=T2*v32;v141=T2*v41;v142=T2*v42;
v151=T2*v51;v152=T2*v52;v161=T2*v61;v162=T2*v62;

plot3([v111(1)+dx(1) v112(1)+dx(1)],[v111(2)+dy(1) v112(2)+dy(1)],[v111(3)+dz(1) v112(3)+dz(1)],'-k');
plot3([v121(1)+dx(1) v122(1)+dx(1)],[v121(2)+dy(1) v122(2)+dy(1)],[v121(3)+dz(1) v122(3)+dz(1)],'-k');
plot3([v131(1)+dx(1) v132(1)+dx(1)],[v131(2)+dy(1) v132(2)+dy(1)],[v131(3)+dz(1) v132(3)+dz(1)],'-k');
plot3([v141(1)+dx(1) v142(1)+dx(1)],[v141(2)+dy(1) v142(2)+dy(1)],[v141(3)+dz(1) v142(3)+dz(1)],'-k');
plot3([v151(1)+dx(1) v152(1)+dx(1)],[v151(2)+dy(1) v152(2)+dy(1)],[v151(3)+dz(1) v152(3)+dz(1)],'-k');
plot3([v161(1)+dx(1) v162(1)+dx(1)],[v161(2)+dy(1) v162(2)+dy(1)],[v161(3)+dz(1) v162(3)+dz(1)],'-k');

% second point, t = 2.5
v211=T4*v11;v212=T4*v12;v221=T4*v21;v222=T4*v22;
v231=T4*v31;v232=T4*v32;v241=T4*v41;v242=T4*v42;
v251=T4*v51;v252=T4*v52;v261=T4*v61;v262=T4*v62;
% third point, t = 5
v311=T6*v11;v312=T6*v12;v321=T6*v21;v322=T6*v22;
v331=T6*v31;v332=T6*v32;v341=T6*v41;v342=T6*v42;
v351=T6*v51;v352=T6*v52;v361=T6*v61;v362=T6*v62;
% fourth point, t = 7.5
v411=T8*v11;v412=T8*v12;v421=T8*v21;v422=T8*v22;
v431=T8*v31;v432=T8*v32;v441=T8*v41;v442=T8*v42;
v451=T8*v51;v452=T8*v52;v461=T8*v61;v462=T8*v62;
% fifth point, t = 10
v511=T10*v11;v512=T10*v12;v521=T10*v21;v522=T10*v22;
v531=T10*v31;v532=T10*v32;v541=T10*v41;v542=T10*v42;
v551=T10*v51;v552=T10*v52;v561=T10*v61;v562=T10*v62;


  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 hold('off')
 a2_id = gca; 
 set(a2_id,'YDir','reverse')
 set(a2_id,'ZDir','reverse')
 aw = [-1500 +5000 -5000 +1500 -11500 -5000]; axis(aw)
 av = [315 20]; view(av)
 grid
 xlabel('X (ft)'), ylabel('Y (ft)'), zlabel('Z (ft)')