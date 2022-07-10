% delta_A = step input
delta_A = -3;to = 5;L1 = -0.8142;L2 = -6.6744;

% b = amplitude
b = -(-6.6744/-0.8142)*delta_A;

% L = decay rate
L = -0.8142;
D_phio = b*(1-exp(L*to)); % Roll rate at To
Phio = b*(to-exp(L*to)/L)+b/L; % Roll angle at To
tmin = 0; tmax = 10; nt = 10000;
t_vector = linspace(tmin, tmax, nt);

% create phi and D_phi vectors
for i = 1:((to/tmax)*nt)
    time = t_vector(i);
    Phi(i) = b*(time-exp(L*time)/L)+b/L;
end
for i = ((to/tmax)*nt):nt
    time = t_vector(i);
    Phi(i) = D_phio*exp(L*(time-to))/L+Phio-D_phio/L;
end
for i = 1:nt
    t = t_vector(i);
    if t >= to
        b = 0;
    end
    D_phi(i) = exp(L*(t-to))*(D_phio-b)+b;
end
  
% plot response

figure(1)
subplot 211;
hold('on')
plot(t_vector,Phi,'-r','LineWidth',1)
plot(t_vector,(Phio-D_phio/L)*ones(1,length(1:nt)),'--k')
title('Roll angle vs time')
xlabel('t (sec)'), ylabel('\phi (deg)')
grid('on');
hold('off');
subplot 212;
hold('on');
plot(t_vector,D_phi,'-r','LineWidth',1)
title('Roll rate vs time')
xlabel('t (sec)'), ylabel('d(\phi)/dt (deg/s)')
grid('on');hold('off');
