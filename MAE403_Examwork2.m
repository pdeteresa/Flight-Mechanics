clear;clc;format short e;
% Mass, Mass Center, Inertia Calculation
% Three View Drawing
% Compute Aircraft Parameters
 b = 10; % ft
 c = 10; % ft
 d = 6; % ft
 h = 2; % ft
 t = 0.2; % ft
 rho = 4; % slug/ft^3
% Comnpute Mass
 m = 1/2*rho*t*( b*c + h*(c-d) );
% Compute Mass Center
 xscm = 1/3*rho*t*( b*c^2 + 1/2*h*(c-d)*(2*c+d ) )/m;
 yscm = 0;
 zscm = 1/2*rho*t*( h*(c-d)*(1/2*t+1/3*h) )/m;
% Compute Inertia
 ixx = 1/2*rho*t*( ...
 + b*c *( (b/2)^2/18 + (t )^2/12 + (zscm )^2 + (b/2/3 )^2 ) ...
 + h*(c-d) *( (h )^2/18 + (t )^2/12 + (zscm-1/2*t-1/3*h)^2 ) ...
 );
 iyy = 1/2*rho*t*( ...
 + b*c *( (c )^2/18 + (t )^2/12 + (xscm-2/3*c )^2 + (zscm )^2 ) ...
 + h*(c-d) *( (h )^2/18 + (c-d)^2/18 + (xscm-2/3*c-1/3*d)^2 + (zscm-1/2*t-1/3*h)^2 ) ...
 );
 izz = 1/2*rho*t*( ...
 + b*c *( (b/2)^2/18 + (c )^2/18 + (xscm-2/3*c )^2 + (b/2/3 )^2 ) ...
 + h*(c-d) *( (c-d)^2/18 + (t )^2/12 + (xscm-2/3*c-1/3*d)^2 ) ...
 );
 ixy = 0;
 iyz = 0;
 izx = 1/2*rho*t*( ...
 + b*c *( (xscm-2/3*c ) * (zscm ) ) ...
 + h*(c-d) *( (h )*(c-d)/36 + (xscm-2/3*c-1/3*d) * (zscm-1/2*t-1/3*h) ) ...
 );
% Calculate Aircraft Surface - Structural Axes
% Calculate Component Surface - Right Wing Upper Surface (1)
% 2D Triangle
 n1a = 100; % Number of Chordwise Points, -
 n1b = 100; % Number of Spanwise Points, -
 m1_1 = -c/(b/2); % Leading Edge Slope, -
 b1_1 = xscm; % Leading Edge Intercept, ft
 m1_2 = 0; % Trailing Edge Slope, -
 b1_2 = -(c-xscm); % Trailing Edge Intercept, ft
 y = linspace(0,b/2,n1b).';
 z = -zscm;
 x1_s = NaN(n1a,n1b); y1_s = NaN(n1a,n1b); z1_s = NaN(n1a,n1b);
 for j = 1:n1a
 for k = 1:n1b
 xle = m1_1*y(k) + b1_1;
 xte = m1_2*y(k) + b1_2;
 x = (xte-xle)*(j-1)/(n1a-1) + xle;
 x1_s(j,k) = x;
 y1_s(j,k) = y(k);
 z1_s(j,k) = z;
  end
 end
 xv1_1_s = m1_1*( 0 ) + b1_1; yv1_1_s = 0; zv1_1_s = z;
 xv1_2_s = m1_1*(+b/2) + b1_1; yv1_2_s = +b/2; zv1_2_s = z;
 xv1_3_s = m1_2*(+t/2) + b1_2; yv1_3_s = +t/2; zv1_3_s = z;
 xv1_4_s = d; yv1_4_s = +t/2; zv1_4_s = z;
 xv1_s = [xv1_1_s xv1_2_s xv1_3_s xv1_4_s].';
 yv1_s = [yv1_1_s yv1_2_s yv1_3_s yv1_4_s].';
 zv1_s = [zv1_1_s zv1_2_s zv1_3_s zv1_4_s].';
 
 % Calculate Component Surface - Left Wing Upper Surface (5)
% 2D Triangle
 n5a = 100; % Number of Chordwise Points, -
 n5b = 100; % Number of Spanwise Points, -
 m5_1 = c/(b/2); % Leading Edge Slope, -
 b5_1 = xscm; % Leading Edge Intercept, ft
 m5_2 = 0; % Trailing Edge Slope, -
 b5_2 = -(c-xscm); % Trailing Edge Intercept, ft
 y = linspace(-b/2,0,n5b).';
 z = -zscm;
 x5_s = NaN(n5a,n5b); y5_s = NaN(n5a,n5b); z5_s = NaN(n5a,n5b);
 for j = 1:n5a
 for k = 1:n5b
 xle = m5_1*y(k) + b5_1;
 xte = m5_2*y(k) + b5_2;
 x = (xte-xle)*(j-1)/(n5a-1) + xle;
 x5_s(j,k) = x;
 y5_s(j,k) = y(k);
 z5_s(j,k) = z;
 end
 end
 xv5_1_s = m5_1*( 0 ) + b5_1; yv5_1_s = 0; zv5_1_s = z;
 xv5_2_s = m5_1*(-b/2) + b5_1; yv5_2_s = -b/2; zv5_2_s = z;
 xv5_3_s = m5_2*(-t/2) + b5_2; yv5_3_s = -t/2; zv5_3_s = z;
 xv5_4_s = d; yv5_4_s = -t/2; zv5_4_s = z;
 xv5_s = [xv5_1_s xv5_2_s xv5_3_s xv5_4_s].';
 yv5_s = [yv5_1_s yv5_2_s yv5_3_s yv5_4_s].';
 zv5_s = [zv5_1_s zv5_2_s zv5_3_s zv5_4_s].';
 
 % Calculate Component Surface - Right Vertical Tail Surface (9)
% 2D Triangle
 n9a = 100; % Number of Chordwise Points, -
 n9b = 100; % Number of Spanwise Points, -
 m9_1 = (c-d)/h; % Leading Edge Slope, -
 b9_1 = xscm-d; % Leading Edge Intercept, ft
 m9_2 = 0; % Trailing Edge Slope, -
 b9_2 = -(c-xscm); % Trailing Edge Intercept, ft
 y = 0;
 z = linspace(-t/2,-(t/2+h),n9b).';
 x9_s = NaN(n9a,n9b); y9_s = NaN(n9a,n9b); z9_s = NaN(n9a,n9b);
 for j = 1:n9a
 for k = 1:n9b
 xle = m9_1*z(k) + b9_1;
 xte = m9_2*z(k) + b9_2;
 x = (xte-xle)*(j-1)/(n9a-1) + xle;
 x9_s(j,k) = x;
 y9_s(j,k) = y;
 z9_s(j,k) = z(k);
 end
 end
 xv9_1_s = m9_1*(+t/2 ) + b9_1; yv9_1_s = y; zv9_1_s = 0;
 xv9_2_s = -(c-xscm); yv9_2_s = y; zv9_2_s = -h;
 xv9_3_s = m9_2*(+t/2 ) + b9_2; yv9_3_s = y; zv9_3_s = 0;
 xv9_4_s = m9_1*(+t/2 ) + b9_1; yv9_4_s = y; zv9_4_s = 0;
 xv9_s = [xv9_1_s xv9_2_s xv9_3_s xv9_4_s].';
 yv9_s = [yv9_1_s yv9_2_s yv9_3_s yv9_4_s].';
 zv9_s = [zv9_1_s zv9_2_s zv9_3_s zv9_4_s].';
 f1_id = figure(1); clf
 fa = 1.0; % 100% Opaque / 0 % Transparent
 hold
 s1s_id = surf(x1_s ,y1_s ,z1_s ); set(s1s_id ,'FaceAlpha',fa)
 s5s_id = surf(x5_s ,y5_s ,z5_s ); set(s5s_id ,'FaceAlpha',fa)
 s9s_id = surf(x9_s ,y9_s ,z9_s ); set(s9s_id ,'FaceAlpha',fa)
plot3(xv1_s ,yv1_s ,zv1_s ,'-k');

 plot3(xv5_s ,yv5_s ,zv5_s ,'-k');

 plot3(xv9_s ,yv9_s ,zv9_s ,'-k');

 plot3(0,0,0,'*r');
 plot3([0 10],[0 0],[-zscm -zscm],'-r')
 plot3([0 0],[0 6],[0 0],'-r')
 plot3([0 0],[0 0],[0 6],'-r')
 hold
colormap([0.90 0.90 0.90]), shading interp, lighting gouraud, material metal
 la = [+000 +100]; l1_id = lightangle(la(1),la(2));
 la = [+000 -080]; l2_id = lightangle(la(1),la(2));
 la = [+020 +010]; l3_id = lightangle(la(1),la(2));
 la = [+110 +010]; l4_id = lightangle(la(1),la(2));
 la = [+200 +010]; l5_id = lightangle(la(1),la(2));
 la = [+290 +010]; l6_id = lightangle(la(1),la(2));
a2_id = gca; 
set(a2_id,'YDir','reverse')
set(a2_id,'ZDir','reverse')
%set(a2_id,'XDir','reverse')
 aw = [-10 10 -10 10 -10 10]; axis(aw), axis square, av = [315 20]; view(av), grid
 xlabel('x_s (ft)'), ylabel('y_s (ft)'), zlabel('z_s (ft)')
 text(11,0,0,'x_b','FontName','Times','Color','r')
 text(0,7,0,'y_b','FontName','Times','Color','r')
 text(0,0,7,'z_b','FontName','Times','Color','r')