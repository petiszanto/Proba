%Ezek kelleni fognak vizsgán/ZH-n
A = 5;
T1 = 10;
T2 = 4;
T3 = 1;
Wp = tf(A, conv([T1 1], conv([T2 1], [T3 1])));
%% Pi
Ti = max([T1 T2 T3]);
Ap = 1;
Wc_pi = Ap* (1 + tf(1, [Ti 0]));
pzmap(Wp, Wc_pi);
Wo_pi = Wp*Wc_pi;
Wo_pi = minreal(Wo_pi);
margin(Wo_pi);
%%
Ap_dB = -12.3;
Ap = 10^(Ap_dB/20);
Wc_pi = Ap* (1 + tf(1, [Ti 0]));
Wo_pi = Wp*Wc_pi;
margin(Wo_pi);
Wcl_pi = feedback(Wo_pi,1);
step(Wcl_pi);
%sisotool
%% PD
N = 5;
Tc = T2 / (N+1);
Td = N*Tc;
Ap = 1;
Wc_pd = Ap*tf([(N+1)*Tc 1], [Tc 1]);
Wo_pd = Wp * Wc_pd;
margin(Wo_pd);
Ap_dB = 0.685;
Ap = 10^(Ap_dB/20);
Wc_pd = Ap*tf([(N+1)*Tc 1], [Tc 1]);
Wo_pd = Wp * Wc_pd;
margin(Wo_pd);
Wcl_pd = feedback(Wo_pd,1);
step(Wcl_pi, Wcl_pd);
