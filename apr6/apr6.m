A = 2; T1 = 10; T2 = 4; T3 =1;
W =tf(A,conv(conv([T1 1], [T2 1]), [T3 1]));
Ap = 3.1907; Tc = 0.9803; Ti = 13.0197; Td = 2.092;
Wpid = tf(Ap*([Tc*(Tc+Td) Ti+Tc 1]), Ti*([Tc 1 0]));
W0 = W*Wpid; %margin(W0);
[Gm, Pm, Wcg, Wcp] = margin(W0); % csak aminek neve van, annak ad értéket
Ts = 2*2*pi/180/Wcp;
Dpid = c2d(Wpid, Ts, 'zoh');
%pzmap(Dpid);
margin(Wpid);
hold;
margin(Dpid);
%simulink kellett, jegyzetben a folytatás
%Ts = 1; Dpid = c2d(Wpid, Ts, 'zoh');
%Ts = 2; Dpid = c2d(Wpid, Ts, 'zoh');
