% F-16 data: (H,V) = (20,000 ft, 300 ft/s)
M_dth = -0.52756; M_th = -2.2060; M_de = -2.1293;
de_in = -10;
s = -(1/2)*M_dth;
w_d = sqrt(-M_th - 0.25*(-M_dth)^2);
z = -(1/2)*(M_dth/sqrt(-M_th));
w_n = sqrt(-M_th);
b = (-M_de/M_th)*de_in;
m = pi/180;
phi = acos(w_d/w_n);

tmin = 0; tmax = 10; nt = 10000;
t_vector = linspace(tmin, tmax, nt);
for i = 1:nt
    t = t_vector(i);
    theta(i) = b*(1-(w_n/w_d)*exp(-s*t)*cos((w_d*t-phi)));
    d_theta(i) = -b*exp(-s*t)*(w_n*sin(phi-t*w_d)-s*(w_d/w_n)*cos(phi-t*w_d));
end
figure(1);

subplot 211;
hold('on');
plot(t_vector,theta,'r')
plot(t_vector,b*ones(1,length(t_vector)),'--k')
ylim([0 16]);title('Pitch angle vs time');ylabel('\theta(t) (deg)');xlabel('t (sec)');
hold('off');grid('on');
subplot 212;
hold('on');
plot(t_vector,d_theta,'r')
plot(t_vector,zeros(1,length(t_vector)),'--k')
ylim([-10 15]);title('Pitch angle rate vs time');ylabel('d\theta/dt (deg/sec)');xlabel('t (sec)');
hold('off');grid('on');