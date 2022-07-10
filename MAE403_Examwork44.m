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

% psi = 284.97, theta = 0, phi = 14.97 (deg)
Ct = cos(Theta(3));Cs = cos(Psi(3));Cp = cos(Phi(3));
St = sin(Theta(3));Ss = sin(Psi(3));Sp = sin(Phi(3));
T5 = [Ct*Cs Ct*Ss -St;
    -Cp*Ss+Sp*St*Cs Cp*Cs+Sp*St*Ss Sp*Ct;
    Sp*Ss+Cp*St*Cs -Sp*Cs+Cp*St*Ss Cp*Ct];T6 = T5.';

f = 1; % scaling factor
dx=[x(1) x(250) x(500) x(750) x(1001)];
dy=[y(1) y(250) y(500) y(750) y(1001)];
dz=[z(1) z(250) z(500) z(750) z(1001)]; % x y z position of cm on trajectory

figure(1), clf
 plot3(x ,y ,z ,'--k'), hold
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
% third point, t = 5
v311=T6*v11;v312=T6*v12;v321=T6*v21;v322=T6*v22;
v331=T6*v31;v332=T6*v32;v341=T6*v41;v342=T6*v42;
v351=T6*v51;v352=T6*v52;v361=T6*v61;v362=T6*v62;

plot3([v311(1)+dx(3) v312(1)+dx(3)],[v311(2)+dy(3) v312(2)+dy(3)],[v311(3)+dz(3) v312(3)+dz(3)],'-k');
plot3([v321(1)+dx(3) v322(1)+dx(3)],[v321(2)+dy(3) v322(2)+dy(3)],[v321(3)+dz(3) v322(3)+dz(3)],'-k');
plot3([v331(1)+dx(3) v332(1)+dx(3)],[v331(2)+dy(3) v332(2)+dy(3)],[v331(3)+dz(3) v332(3)+dz(3)],'-k');
plot3([v341(1)+dx(3) v342(1)+dx(3)],[v341(2)+dy(3) v342(2)+dy(3)],[v341(3)+dz(3) v342(3)+dz(3)],'-k');
plot3([v351(1)+dx(3) v352(1)+dx(3)],[v351(2)+dy(3) v352(2)+dy(3)],[v351(3)+dz(3) v352(3)+dz(3)],'-k');
plot3([v361(1)+dx(3) v362(1)+dx(3)],[v361(2)+dy(3) v362(2)+dy(3)],[v361(3)+dz(3) v362(3)+dz(3)],'-k');

q = [dx(3) dy(3) dz(3)].';
avx1 = [0 0 0].'; avx2 = [8*f 0 0].';avx1=T6*avx1+q;avx2=T6*avx2+q;
avy1 = [0 0 0].'; avy2 = [0 8*f 0].';avy1=T6*avy1+q;avy2=T6*avy2+q;
avz1 = [0 0 0].'; avz2 = [0 0 8*f].';avz1=T6*avz1+q;avz2=T6*avz2+q;

plot3([avx1(1) avx2(1)],[avx1(2) avx2(2)],[avx1(3) avx2(3)],'-r');
plot3([avy1(1) avy2(1)],[avy1(2) avy2(2)],[avy1(3) avy2(3)],'-r');
plot3([avz1(1) avz2(1)],[avz1(2) avz2(2)],[avz1(3) avz2(3)],'-r');

text(avx2(1)+0.25,avx2(2)-0.5,avx2(3),'x_b','FontName','Times','Color','r')
 text(avy2(1)+2,avy2(2)-0.25,avy2(3)-0.25,'y_b','FontName','Times','Color','r')
 text(avz2(1)-0.5,avz2(2)+0.5,avz2(3)+0.75,'z_b','FontName','Times','Color','r')
 text(avz1(1)-0.5,avz1(2)+0.25,avz1(3)-0.5,'cm','FontName','Times','Color','r')
hold('off')
 a2_id = gca; 
 set(a2_id,'YDir','reverse')
 set(a2_id,'ZDir','reverse')
 aw = [dx(3)-10 dx(3)+10 dy(3)-10 dy(3)+10 dz(3)-10 dz(3)+10]; axis(aw),axis square,av = [135 20]; view(av)
 grid
 xlabel('X (ft)'), ylabel('Y (ft)'), zlabel('Z (ft)')
