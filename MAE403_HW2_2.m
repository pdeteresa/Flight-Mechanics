% F-16 data: (H,V) = (20,000 ft, 300 ft/s)
M_dth = -0.52756; M_th = -2.2060; M_de = -2.1293;
de_in = -10;z = 0.7;b = 10;
K_dth = (2*z*sqrt(-M_th)+M_dth)/M_de;
K_de_in = -b*M_th/(M_de*de_in);
s = -(1/2)*(M_dth-K_dth*M_de);
w_d = sqrt(-M_th - 0.25*(-M_dth+K_dth*M_de)^2);
w_n = sqrt(-M_dth+K_dth*M_de);
phi1 = acos(w_d/w_n);
phi2 = atan(s/w_d);

tmin = 0; tmax = 10; nt = 10000;
t_vector = linspace(tmin, tmax, nt);
for i = 1:nt
    t = t_vector(i);
    theta(i) = b*(1-(w_n/w_d)*exp(-s*t)*cos((w_d*t-phi1)));
    d_theta(i) = -b*exp(-s*t)*(w_n*sin(phi2-t*w_d)-s*(w_n/w_d)*cos(phi2-t*w_d));
end
figure(1);

subplot 211;
hold('on');
plot(t_vector,theta,'b','LineWidth',1)
plot(t_vector,b*ones(1,length(t_vector)),'--k')
ylim([0 16]);title('Pitch angle vs time');
hold('off');grid('on');
subplot 212;
hold('on');
plot(t_vector,d_theta,'b','LineWidth',1)
plot(t_vector,zeros(1,length(t_vector)),'--k')
ylim([-10 15]);title('Pitch angle rate vs time');
hold('off');grid('on');
