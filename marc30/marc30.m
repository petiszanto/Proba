W = tf(3, [5 1], 'OutputDelay', 2);
%step(W, tf(3, [5 1]));
%bode(W, tf(3, [5 1]));
AP = 5*pi/3/12; Ti = 5;
Wpi = tf(AP/Ti*[Ti 1], [1 0]);
W0 = Wpi*W;
margin(W0);
pzmap(W0);
Wcl = feedback(W0,1,-1);
step(Wcl);

%%
Tc12 = roots([11 -11*14 40]);
Tc = min(Tc12);
Ti = 14-Tc; Td = 10*Tc;
Ap = 1;
Wpid = tf(Ap/Ti*conv([10 1],[4 1]),[Tc 1 0]);
A = 2; T1 = 10; T2 = 4; T3 = 1;
W = tf(A, conv(conv([T1 1], [T2 1]),[T3 1]));
W0 = Wpid*W;
%bode(W0);
A1 = -15;
Ap = 10^(-A1/20);
Wpid = tf(Ap/Ti*conv([10 1],[4 1]),[Tc 1 0]);
W0 = Wpid*W;
%margin(W0); %innen már ki lehet játszani
Wcl = feedback(W0, 1 ,-1);
step(Wcl);
Wur = feedback(Wpid, W, -1);
step(Wur);
%%
vec = [1,1,1]; %(10/(40/13))
sol = fsolve(@myPID, vec); 
Ap = sol(1);
wc = sol(2);
Tc = sol(3);
Ti = 14-Tc; Td = 40/Ti -Tc;
Wpid = tf(Ap/Ti*conv([10 1],[4 1]),[Tc 1 0]);
W0 = Wpid *W0; margin(W0);
Wcl = feedback(W0, 1 -1);
step(Wcl);
Wur = feedback(Wpid, 1 -1);
step(Wur);
Ts = 2*pi/180*2/wc;
Dpid = c2d(Wpid, Ts, 'zoh');
D = c2d(W, Ts, 'zoh');
D0 = D*Dpid; margin(D0);
Dcl = feedbanck(D0, 1 -1);
step(Dcl);
Dur = feedback(Dpid, D, -1);
step(Dur);