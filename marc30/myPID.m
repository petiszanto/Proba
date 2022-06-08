function y = myPID(x)
Ap = x(1); wc = x(2); Tc = x(3);
Ti = 14 - Tc; Td = 40/Ti - Tc; T3 = 1;
y(1) = Ap*(1+Td/Tc) - 10; % u_max
y(2) = 2*Ap/Ti/wc/sqrt(1+wc^2*Tc^2)/sqrt(1+wc^2) - 1; %|W0(wc)| = 1
y(3) = pi-pi/2-atan(wc*Tc)-atan(wc*T3)-pi/4;
end

