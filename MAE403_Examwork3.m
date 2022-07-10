clear;clc;format short e;
b = 10;c = 10;xscm = 6.8148;d2r = pi/180;d=6;h=2;
psi = [30 0 0 0 0]*(d2r);theta = [45 0 0 0 0]*d2r;phi = ([120 0 0 0 0]+180)*d2r;% euler angles
% can also use eul2rotm(eul)
% eul = [psi theta phi] in radians, but y and z axes are reversed
Ct = cos(theta(1));Cs = cos(psi(1));Cp = cos(phi(1));
St = sin(theta(1));Ss = sin(psi(1));Sp = sin(phi(1));
T1 = [Ct*Cs Ct*Ss -St;
    -Cp*Ss+Sp*St*Cs Cp*Cs+Sp*St*Ss Sp*Ct;
    Sp*Ss+Cp*St*Cs -Sp*Cs+Cp*St*Ss Cp*Ct];
T2 = T1.';% Body -> Earth axes

f = 1; % scaling factor
dx=0;dy=0;dz=0; % x y z position of cm on trajectory

figure(2);clf
hold('on')

x1 = f.*(-c+xscm)*ones(1,6).';
x2 = f.*[-c+xscm xscm xscm xscm -c+xscm xscm-d].';
y1 = f.*(b/2)*[-1 1 -1 0 0 0].';
y2 = f.*(b/2)*[1 0 0 0 0 0].';
z1 = f.*[0 0 0 0 0 h].';z2=f.*[0 0 0 0 h 0].';
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
q=[dx dy dz].';
v11=T2*v11;v12=T2*v12;v21=T2*v21;v22=T2*v22;
v31=T2*v31;v32=T2*v32;v51=T2*v51;v52=T2*v52;
v61=T2*v61;v62=T2*v62;v41=T2*v41;v42=T2*v42;

plot3([v11(1)+q(1) v12(1)+q(1)],[v11(2)+q(2) v12(2)+q(2)],[v11(3)+q(3) v12(3)+q(3)],'-k');
plot3([v21(1)+q(1) v22(1)+q(1)],[v21(2)+q(2) v22(2)+q(2)],[v21(3)+q(3) v22(3)+q(3)],'-k');
plot3([v31(1)+q(1) v32(1)+q(1)],[v31(2)+q(2) v32(2)+q(2)],[v31(3)+q(3) v32(3)+q(3)],'-k');
plot3([v41(1)+q(1) v42(1)+q(1)],[v41(2)+q(2) v42(2)+q(2)],[v41(3)+q(3) v42(3)+q(3)],'-k');
plot3([v51(1)+q(1) v52(1)+q(1)],[v51(2)+q(2) v52(2)+q(2)],[v51(3)+q(3) v52(3)+q(3)],'-k');
plot3([v61(1)+q(1) v62(1)+q(1)],[v61(2)+q(2) v62(2)+q(2)],[v61(3)+q(3) v62(3)+q(3)],'-k');

avx1 = [0 0 0].'; avx2 = [8*f 0 0].';avx1=T2*avx1+q;avx2=T2*avx2+q;
avy1 = [0 0 0].'; avy2 = [0 -8*f 0].';avy1=T2*avy1+q;avy2=T2*avy2+q;
avz1 = [0 0 0].'; avz2 = [0 0 8*f].';avz1=T2*avz1+q;avz2=T2*avz2+q;
plot3([avx1(1) avx2(1)],[avx1(2) avx2(2)],[avx1(3) avx2(3)],'-r');
plot3([avy1(1) avy2(1)],[avy1(2) avy2(2)],[avy1(3) avy2(3)],'-r');
plot3([avz1(1) avz2(1)],[avz1(2) avz2(2)],[avz1(3) avz2(3)],'-r');
a2_id = gca;
set(a2_id,'YDir','reverse')
set(a2_id,'ZDir','reverse')
aw = [-10 10 -10 10 -10 10]; axis(aw), axis square, av = [315 20]; view(av), grid('on')
xlabel('x_i (ft)'), ylabel('y_i (ft)'), zlabel('z_i (ft)')
 text(avx2(1)+0.25,avx2(2)-0.25,avx2(3)-0.5,'x_b','FontName','Times','Color','r')
 text(avy2(1)+0.5,avy2(2)-0.25,avy2(3)+0.25,'y_b','FontName','Times','Color','r')
 text(avz2(1)+0.5,avz2(2)-0.25,avz2(3)+0.5,'z_b','FontName','Times','Color','r')
 text(avz1(1)+0.5,avz1(2)+0.5,avz1(3)-0.5,'cm','FontName','Times','Color','r')
 plot3(avx1(1),avx1(2),avx1(3),'*r');

 plot3([0 avx1(1)],[0 avx1(2)],[0 avx1(3)],'--b');
hold('off')
