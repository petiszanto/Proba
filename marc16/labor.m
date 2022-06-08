m = 2; k = 0.5; b = 0.25;
Wp = tf(1, [m b k]);
%dcgain(Wp); %nyílthurkú erősítés
step(Wp);
hold on;
impulse(Wp);
%pzmap(Wp);

%% 

Wc1 = 0.1; Wc2 = 1; Wc3 = 3; Wc4 = 10;
W01 = Wc1*Wp; W02 = Wc2*Wp; W03 = Wc3*Wp; W04 = Wc4*Wp;
Wcl1 = feedback(W01, 1, -1);
Wcl2 = feedback(W02, 1, -1);
Wcl3 = feedback(W03, 1, -1);
Wcl4 = feedback(W04, 1, -1);
%pzmap(Wcl1, Wcl2, Wcl3, Wcl4);
%figure(1);
%rlocus(W02); 
%figure(2);
step(Wcl1, Wcl2, Wcl3, Wcl4);
%bode(W01, W02, W03, W04);
%hold on;
%bode(Wcl4);
%nyquist(W01, W02, W03, W04);
