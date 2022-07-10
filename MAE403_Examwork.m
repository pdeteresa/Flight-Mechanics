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
 m1_1 = +c/(b/2); % Leading Edge Slope, -
 b1_1 = 0; % Leading Edge Intercept, ft
 m1_2 = 0; % Trailing Edge Slope, -
 b1_2 = c; % Trailing Edge Intercept, ft
 y = linspace(0,+b/2,n1b).';
 z = +t/2;
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
% Calculate Component Surface - Right Wing Lower Surface (2)
% 2D Triangle
 n2a = 100; % Number of Chordwise Points, -
 n2b = 100; % Number of Spanwise Points, -
 m2_1 = +c/(b/2); % Leading Edge Slope, -
 b2_1 = 0; % Leading Edge Intercept, ft
 m2_2 = 0; % Trailing Edge Slope, -
 b2_2 = +c; % Trailing Edge Intercept, ft
 y = linspace(0,+b/2,n2b).';
 z = -t/2;
 x2_s = NaN(n2a,n2b); y2_s = NaN(n2a,n2b); z2_s = NaN(n2a,n2b);
 for j = 1:n2a
 for k = 1:n2b
 xle = m2_1*y(k) + b2_1;
 xte = m2_2*y(k) + b2_2;
 x = (xte-xle)*(j-1)/(n2a-1) + xle;
 x2_s(j,k) = x;
 y2_s(j,k) = y(k);
 z2_s(j,k) = z;
 end
 end
 xv2_1_s = m2_1*( 0 ) + b2_1; yv2_1_s = 0; zv2_1_s = z;
 xv2_2_s = m2_1*(+b/2) + b2_1; yv2_2_s = +b/2; zv2_2_s = z;
 xv2_3_s = m2_2*( 0 ) + b2_2; yv2_3_s = 0; zv2_3_s = z;
 xv2_s = [xv2_1_s xv2_2_s xv2_3_s].';
 yv2_s = [yv2_1_s yv2_2_s yv2_3_s].';
 zv2_s = [zv2_1_s zv2_2_s zv2_3_s].';
% Calculate Component Surface - Right Wing Outer Edge Surface (3)
% 2D Rectangle
 n3a = 100; % Number of Chordwise Points, -
 n3b = 100; % Number of Spanwise Points, -
 m3_1 = +c/(b/2); % Leading Edge Slope, -
 b3_1 = 0; % Leading Edge Intercept, ft
 y = linspace(0,+b/2,n3b).';
 z3_1 = -t/2;
 z3_2 = +t/2;
 x3_s = NaN(n3a,n3b); y3_s = NaN(n3a,n3b); z3_s = NaN(n3a,n3b);
 for j = 1:n3a
 for k = 1:n3b
 xle = m1_1*y(k) + b1_1;
 x = xle;
 z = (z3_2-z3_1)*(j-1)/(n3a-1) + z3_1;
 x3_s(j,k) = x;
 y3_s(j,k) = y(k);
 z3_s(j,k) = z;
 end
 end
 xv3_1_s = m3_1*( 0 ) + b3_1; yv3_1_s = 0; zv3_1_s = z3_1;
 xv3_2_s = m3_1*(+b/2) + b3_1; yv3_2_s = +b/2; zv3_2_s = z3_1;
 xv3_3_s = m3_1*(+b/2) + b3_1; yv3_3_s = +b/2; zv3_3_s = z3_2;
 xv3_4_s = m3_1*( 0 ) + b3_1; yv3_4_s = 0; zv3_4_s = z3_2;
 xv3_5_s = m3_1*( 0 ) + b3_1; yv3_5_s = 0; zv3_5_s = z3_1;
 xv3_s = [xv3_1_s xv3_2_s xv3_3_s xv3_4_s xv3_5_s].';
 yv3_s = [yv3_1_s yv3_2_s yv3_3_s yv3_4_s yv3_5_s].';
 zv3_s = [zv3_1_s zv3_2_s zv3_3_s zv3_4_s zv3_5_s].';
% Calculate Component Surface - Right Wing Aft Edge Surface (4)
% 2D Rectangle
 n4a = 100; % Number of Chordwise Points, -
 n4b = 100; % Number of Spanwise Points, -
 m4_2 = 0; % Trailing Edge Slope, -
 b4_2 = +c; % Trailing Edge Intercept, ft
 y = linspace(0,+b/2,n4b).';
 z4_1 = -t/2;
 z4_2 = +t/2;
 x4_s = NaN(n4a,n4b); y4_s = NaN(n4a,n4b); z4_s = NaN(n4a,n4b);
 for j = 1:n4a
 for k = 1:n4b
 xte = m4_2*y(k) + b4_2;
 x = xte;
 z = (z4_2-z4_1)*(j-1)/(n4a-1) + z4_1;
 x4_s(j,k) = x;
 y4_s(j,k) = y(k);
 z4_s(j,k) = z;
 end
 end
 xv4_1_s = m4_2*( 0 ) + b4_2; yv4_1_s = 0; zv4_1_s = z4_1;
 xv4_2_s = m4_2*(+b/2) + b4_2; yv4_2_s = +b/2; zv4_2_s = z4_1;
 xv4_3_s = m4_2*(+b/2) + b4_2; yv4_3_s = +b/2; zv4_3_s = z4_2;
 xv4_4_s = m4_2*( 0 ) + b4_2; yv4_4_s = 0; zv4_4_s = z4_2;
 xv4_s = [xv4_1_s xv4_2_s xv4_3_s xv4_4_s].';
 yv4_s = [yv4_1_s yv4_2_s yv4_3_s yv4_4_s].';
 zv4_s = [zv4_1_s zv4_2_s zv4_3_s zv4_4_s].';
% Calculate Component Surface - Left Wing Upper Surface (5)
% 2D Triangle
 n5a = 100; % Number of Chordwise Points, -
 n5b = 100; % Number of Spanwise Points, -
 m5_1 = -c/(b/2); % Leading Edge Slope, -
 b5_1 = 0; % Leading Edge Intercept, ft
 m5_2 = 0; % Trailing Edge Slope, -
 b5_2 = +c; % Trailing Edge Intercept, ft
 y = linspace(-b/2,0,n5b).';
 z = +t/2;
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
% Calculate Component Surface - Right Wing Lower Surface (6)
% 2D Triangle
 n6a = 100; % Number of Chordwise Points, -
 n6b = 100; % Number of Spanwise Points, -
 m6_1 = -c/(b/2); % Leading Edge Slope, -
 b6_1 = 0; % Leading Edge Intercept, ft
 m6_2 = 0; % Trailing Edge Slope, -
 b6_2 = +c; % Trailing Edge Intercept, ft
 y = linspace(-b/2,0,n6b).';
 z = -t/2;
 x6_s = NaN(n6a,n6b); y6_s = NaN(n6a,n6b); z6_s = NaN(n6a,n6b);
 for j = 1:n6a
 for k = 1:n6b
 xle = m6_1*y(k) + b6_1;
 xte = m6_2*y(k) + b6_2;
 x = (xte-xle)*(j-1)/(n6a-1) + xle;
 x6_s(j,k) = x;
 y6_s(j,k) = y(k);
 z6_s(j,k) = z;
 end
 end
 xv6_1_s = m6_1*( 0 ) + b6_1; yv6_1_s = 0; zv6_1_s = z;
 xv6_2_s = m6_1*(-b/2) + b6_1; yv6_2_s = -b/2; zv6_2_s = z;
 xv6_3_s = m6_2*( 0 ) + b6_2; yv6_3_s = 0; zv6_3_s = z;
 xv6_s = [xv6_1_s xv6_2_s xv6_3_s].';
 yv6_s = [yv6_1_s yv6_2_s yv6_3_s].';
 zv6_s = [zv6_1_s zv6_2_s zv6_3_s].';
% Calculate Component Surface - Left Wing Outer Edge Surface (7)
% 2D Rectangle
 n7a = 100; % Number of Chordwise Points, -
 n7b = 100; % Number of Spanwise Points, -
 m7_1 = -c/(b/2); % Leading Edge Slope, -
 b7_1 = 0; % Leading Edge Intercept, ft
 y = linspace(-b/2,0,n7b).';
 z7_1 = -t/2;
 z7_2 = +t/2;
 x7_s = NaN(n7a,n7b); y7_s = NaN(n7a,n7b); z7_s = NaN(n7a,n7b);
 for j = 1:n7a
 for k = 1:n7b
 xle = m7_1*y(k) + b7_1;
 x = xle;
 z = (z7_2-z7_1)*(j-1)/(n7a-1) + z7_1;
 x7_s(j,k) = x;
 y7_s(j,k) = y(k);
 z7_s(j,k) = z;
 end
 end
 xv7_1_s = m7_1*( 0 ) + b7_1; yv7_1_s = 0; zv7_1_s = z7_1;
 xv7_2_s = m7_1*(-b/2) + b7_1; yv7_2_s = -b/2; zv7_2_s = z7_1;
 xv7_3_s = m7_1*(-b/2) + b7_1; yv7_3_s = -b/2; zv7_3_s = z7_2;
 xv7_4_s = m7_1*( 0 ) + b7_1; yv7_4_s = 0; zv7_4_s = z7_2;
 xv7_5_s = m7_1*( 0 ) + b7_1; yv7_5_s = 0; zv7_5_s = z7_1;
 xv7_s = [xv7_1_s xv7_2_s xv7_3_s xv7_4_s xv7_5_s].';
 yv7_s = [yv7_1_s yv7_2_s yv7_3_s yv7_4_s yv7_5_s].';
 zv7_s = [zv7_1_s zv7_2_s zv7_3_s zv7_4_s zv7_5_s].';
 % Calculate Component Surface - Left Wing Aft Edge Surface (8)
% 2D Rectangle
 n8a = 100; % Number of Chordwise Points, -
 n8b = 100; % Number of Spanwise Points, -
 m8_2 = 0; % Trailing Edge Slope, -
 b8_2 = +c; % Trailing Edge Intercept, ft
 y = linspace(-b/2,0,n8b).';
 z8_1 = -t/2;
 z8_2 = +t/2;
 x8_s = NaN(n8a,n8b); y8_s = NaN(n8a,n8b); z8_s = NaN(n8a,n8b);
 for j = 1:n8a
 for k = 1:n8b
 xte = m8_2*y(k) + b8_2;
 x = xte;
 z = (z8_2-z8_1)*(j-1)/(n8a-1) + z8_1;
 x8_s(j,k) = x;
 y8_s(j,k) = y(k);
 z8_s(j,k) = z;
 end
 end
 xv8_1_s = m8_2*( 0 ) + b8_2; yv8_1_s = 0; zv8_1_s = z8_1;
 xv8_2_s = m8_2*(-b/2) + b8_2; yv8_2_s = -b/2; zv8_2_s = z8_1;
 xv8_3_s = m8_2*(-b/2) + b8_2; yv8_3_s = -b/2; zv8_3_s = z8_2;
 xv8_4_s = m8_2*( 0 ) + b8_2; yv8_4_s = 0; zv8_4_s = z8_2;
 xv8_s = [xv8_1_s xv8_2_s xv8_3_s xv8_4_s].';
 yv8_s = [yv8_1_s yv8_2_s yv8_3_s yv8_4_s].';
 zv8_s = [zv8_1_s zv8_2_s zv8_3_s zv8_4_s].';
% Calculate Component Surface - Right Vertical Tail Surface (9)
% 2D Triangle
 n9a = 100; % Number of Chordwise Points, -
 n9b = 100; % Number of Spanwise Points, -
 m9_1 = +(c-d)/h; % Leading Edge Slope, -
 b9_1 = +(c-d)/h*(-t/2) + d ; % Leading Edge Intercept, ft
 m9_2 = 0; % Trailing Edge Slope, -
 b9_2 = +c; % Trailing Edge Intercept, ft
 y = +t/2;
 z = linspace(+t/2,+t/2+h,n9b).';
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
 xv9_1_s = m9_1*(+t/2 ) + b9_1; yv9_1_s = y; zv9_1_s = +t/2;
 xv9_2_s = m9_1*(+t/2+h) + b9_1; yv9_2_s = y; zv9_2_s = +t/2+h;
 xv9_3_s = m9_2*(+t/2 ) + b9_2; yv9_3_s = y; zv9_3_s = +t/2;
 xv9_4_s = m9_1*(+t/2 ) + b9_1; yv9_4_s = y; zv9_4_s = +t/2;
 xv9_s = [xv9_1_s xv9_2_s xv9_3_s xv9_4_s].';
 yv9_s = [yv9_1_s yv9_2_s yv9_3_s yv9_4_s].';
 zv9_s = [zv9_1_s zv9_2_s zv9_3_s zv9_4_s].';
% Calculate Component Surface - Left Vertical Tail Surface (10)
% 2D Triangle
 n10a = 100; % Number of Chordwise Points, -
 n10b = 100; % Number of Spanwise Points, -
 m10_1 = +(c-d)/h; % Leading Edge Slope, -
 b10_1 = +(c-d)/h*(-t/2) + d ; % Leading Edge Intercept, ft
 m10_2 = 0; % Trailing Edge Slope, -
 b10_2 = +c; % Trailing Edge Intercept, ft
 y = -t/2;
 z = linspace(+t/2,+t/2+h,n10b).';
 x10_s = NaN(n10a,n10b); y10_s = NaN(n10a,n10b); z10_s = NaN(n10a,n10b);
 for j = 1:n10a
 for k = 1:n10b
 xle = m10_1*z(k) + b10_1;
 xte = m10_2*z(k) + b10_2;
 x = (xte-xle)*(j-1)/(n10a-1) + xle;
 x10_s(j,k) = x;
 y10_s(j,k) = y;
 z10_s(j,k) = z(k);
 end
 end
 xv10_1_s = m10_1*(+t/2 ) + b10_1; yv10_1_s = y; zv10_1_s = +t/2;
 xv10_2_s = m10_1*(+t/2+h) + b10_1; yv10_2_s = y; zv10_2_s = +t/2+h;
 xv10_3_s = m10_2*(+t/2 ) + b10_2; yv10_3_s = y; zv10_3_s = +t/2;
 xv10_4_s = m10_1*(+t/2 ) + b10_1; yv10_4_s = y; zv10_4_s = +t/2;
 xv10_s = [xv10_1_s xv10_2_s xv10_3_s xv10_4_s].';
 yv10_s = [yv10_1_s yv10_2_s yv10_3_s yv10_4_s].';
 zv10_s = [zv10_1_s zv10_2_s zv10_3_s zv10_4_s].';
% Calculate Component Surface - Vertical Tail Upper Edge Surface (11)
% 2D Rectangle
 n11a = 100; % Number of Chordwise Points, -
 n11b = 100; % Number of Spanwise Points, -
 m11_1 = +(c-d)/h; % Leading Edge Slope, -
 b11_1 = +(c-d)/h*(-t/2) + d ; % Leading Edge Intercept, ft
 y11_1 = -t/2;
 y11_2 = +t/2;
 z = linspace(+t/2,+t/2+h,n11b).';
 x11_s = NaN(n11a,n11b); y11_s = NaN(n11a,n11b); z11_s = NaN(n11a,n11b);
 for j = 1:n11a
 for k = 1:n11b
 xle = m11_1*z(k) + b11_1;
 x = xle;
 y = (y11_2-y11_1)*(j-1)/(n11a-1) + y11_1;
 x11_s(j,k) = x;
 y11_s(j,k) = y;
 z11_s(j,k) = z(k);
 end
 end
 xv11_1_s = m11_1*(+t/2 ) + b11_1; yv11_1_s = y11_1; zv11_1_s = +t/2;
 xv11_2_s = m11_1*(+t/2+h) + b11_1; yv11_2_s = y11_1; zv11_2_s = +t/2+h;
 xv11_3_s = m11_1*(+t/2+h) + b11_1; yv11_3_s = y11_2; zv11_3_s = +t/2+h;
 xv11_4_s = m11_1*(+t/2 ) + b11_1; yv11_4_s = y11_2; zv11_4_s = +t/2;
 xv11_5_s = m11_1*(+t/2 ) + b11_1; yv11_5_s = y11_1; zv11_5_s = +t/2;
 xv11_s = [xv11_1_s xv11_2_s xv11_3_s xv11_4_s xv11_5_s].';
 yv11_s = [yv11_1_s yv11_2_s yv11_3_s yv11_4_s yv11_5_s].';
 zv11_s = [zv11_1_s zv11_2_s zv11_3_s zv11_4_s zv11_5_s].';
% Calculate Component Surface - Vertical Tail Aft Edge Surface (12)
% 2D Rectangle
 n12a = 100; % Number of Chordwise Points, -
 n12b = 100; % Number of Spanwise Points, -
 m12_2 = 0; % Trailing Edge Slope, -
 b12_2 = +c; % Trailing Edge Intercept, ft
34
 y12_1 = -t/2;
 y12_2 = +t/2;
 z = linspace(+t/2,+t/2+h,n12b).';
 x12_s = NaN(n12a,n12b); y12_s = NaN(n12a,n12b); z12_s = NaN(n12a,n12b);
 for j = 1:n12a
 for k = 1:n12b
 xte = m12_2*z(k) + b12_2;
 x = xte;
 y = (y12_2-y12_1)*(j-1)/(n12a-1) + y12_1;
 x12_s(j,k) = x;
 y12_s(j,k) = y;
 z12_s(j,k) = z(k);
 end
 end
 xv12_1_s = m12_2*(+t/2 ) + b12_2; yv12_1_s = y12_1; zv12_1_s = +t/2;
 xv12_2_s = m12_2*(+t/2+h) + b12_2; yv12_2_s = y12_1; zv12_2_s = +t/2+h;
 xv12_3_s = m12_2*(+t/2+h) + b12_2; yv12_3_s = y12_2; zv12_3_s = +t/2+h;
 xv12_4_s = m12_2*(+t/2 ) + b12_2; yv12_4_s = y12_2; zv12_4_s = +t/2;
 xv12_5_s = m12_2*(+t/2 ) + b12_2; yv12_5_s = y12_1; zv12_5_s = +t/2;
 xv12_s = [xv12_1_s xv12_2_s xv12_3_s xv12_4_s xv12_5_s].';
 yv12_s = [yv12_1_s yv12_2_s yv12_3_s yv12_4_s yv12_5_s].';
 zv12_s = [zv12_1_s zv12_2_s zv12_3_s zv12_4_s zv12_5_s].';
% Construct Aircraft Perspective View - Structural Axes
 f1_id = figure(1); clf
% fa = 0.5; % 50 % Opaque / 50% Transparent
 fa = 1.0; % 100% Opaque / 0 % Transparent
 hold
 dx = -xscm;dy = 0;dz = 0;
 s1s_id = surf(x1_s +dx,y1_s ,z1_s ); set(s1s_id ,'FaceAlpha',fa)
 s2s_id = surf(x2_s +dx,y2_s ,z2_s ); set(s2s_id ,'FaceAlpha',fa)
 s3s_id = surf(x3_s +dx,y3_s ,z3_s ); set(s3s_id ,'FaceAlpha',fa)
 s4s_id = surf(x4_s +dx,y4_s ,z4_s ); set(s4s_id ,'FaceAlpha',fa)
 s5s_id = surf(x5_s +dx,y5_s ,z5_s ); set(s5s_id ,'FaceAlpha',fa)
 s6s_id = surf(x6_s +dx,y6_s ,z6_s ); set(s6s_id ,'FaceAlpha',fa)
 s7s_id = surf(x7_s +dx,y7_s ,z7_s ); set(s7s_id ,'FaceAlpha',fa)
 s8s_id = surf(x8_s +dx,y8_s ,z8_s ); set(s8s_id ,'FaceAlpha',fa)
 s9s_id = surf(x9_s +dx,y9_s ,z9_s ); set(s9s_id ,'FaceAlpha',fa)
 s10s_id = surf(x10_s+dx,y10_s,z10_s); set(s10s_id,'FaceAlpha',fa)
 s11s_id = surf(x11_s+dx,y11_s,z11_s); set(s11s_id,'FaceAlpha',fa)
 s12s_id = surf(x12_s+dx,y12_s,z12_s); set(s12s_id,'FaceAlpha',fa)
 plot3(xv1_s +dx,yv1_s ,zv1_s ,'-k');
 plot3(xv2_s +dx,yv2_s ,zv2_s ,'-k');
 plot3(xv3_s +dx,yv3_s ,zv3_s ,'-k');
 plot3(xv4_s +dx,yv4_s ,zv4_s ,'-k');
 plot3(xv5_s +dx,yv5_s ,zv5_s ,'-k');
 plot3(xv6_s +dx,yv6_s ,zv6_s ,'-k');
 plot3(xv7_s +dx,yv7_s ,zv7_s ,'-k');
 plot3(xv8_s +dx,yv8_s ,zv8_s ,'-k');
 plot3(xv9_s +dx,yv9_s ,zv9_s ,'-k');
 plot3(xv10_s+dx,yv10_s,zv10_s,'-k');
 plot3(xv11_s+dx,yv11_s,zv11_s,'-k');
 plot3(xv12_s+dx,yv12_s,zv12_s,'-k');
 plot3(xscm+dx,yscm,zscm,'*r');
 plot3([xscm xscm-8]+dx,[yscm yscm+0],[zscm zscm-0],'-r')
 plot3([xscm xscm-0]+dx,[yscm yscm+5],[zscm zscm-0],'-r')
 plot3([xscm xscm-0]+dx,[yscm yscm+0],[zscm zscm-4],'-r')
 hold
 colormap([0.90 0.90 0.90]), shading interp, lighting gouraud, material metal
 la = [+000 +100]; l1_id = lightangle(la(1),la(2));
 la = [+000 -080]; l2_id = lightangle(la(1),la(2));
 la = [+020 +010]; l3_id = lightangle(la(1),la(2));
 la = [+110 +010]; l4_id = lightangle(la(1),la(2));
 la = [+200 +010]; l5_id = lightangle(la(1),la(2));
 la = [+290 +010]; l6_id = lightangle(la(1),la(2));
 aw = [-10 10 -10 10 -10 10]; axis(aw), axis square, av = [135 20]; view(av), grid
 xlabel('x_s (ft)'), ylabel('y_s (ft)'), zlabel('z_s (ft)')
 text(xscm-9+dx,yscm+0,zscm-0,'x_b','FontName','Times','Color','r')
 text(xscm-0+dx,yscm+6,zscm-0,'y_b','FontName','Times','Color','r')
 text(xscm-0+dx,yscm+0,zscm-5,'z_b','FontName','Times','Color','r')