w = (pi/180)*[3 0 3]';
theta = 0; phi = 0; psi = 270*pi/180;
Ct = cos(theta);Cph = cos(phi);Cps = cos(psi);
St = sin(theta);Sph = sin(phi);Sps = sin(psi);
C1 = [1 Sph*St/Ct Cph*St/Ct;
    0 Cph -Sph;
    0 Sph/Ct Cph/Ct];
C_matrix = [Ct*Cps Sph*St*Cps-Cph*Sps Cph*St*Cps+Sph*Sps;
    Ct*Sps Sph*St*Sps+Cph*Cps Cph*St*Sps-Sph*Cps;
    -St Sph*Ct Cph*Ct];
b = [500 30 30]';
t = linspace(0,10,1000);
dx = 30.*t;dy = -500.*t;dz = 30.*t;
for i = 1:length(t)
    x(i) = 1000+dx(i);
    y(i) = 1000+dy(i);
    z(i) = -10000+dz(i);
end
plot3(x,y,z)
