num1 = [1];
den1 = [100 1];
W1 = tf(num1, den1);
%sys_ss = ss(W);
%sys_zpk = zpk(W);
%ltiview(W);
nyquist(W1);
%% 3.eloadasbol:
Wp = tf(1, conv([2 1], [4 1]));
Wc = tf(3, [1 0]);
W0 = Wc * Wp;
Wc1 = feedback(W0, 1, -1);
pzmap(Wp);
hold on;
pzmap(Wc);
pzmap(Wc1);
%%
W2 = tf(10, 1);
W3 = tf(1, conv([100 1], [1 1]));
W4 = W2 * W3;
margin(W4);
%% 2.gyakorlat 11-es feladata
Wp = tf(10, conv([100 1],conv([10 1], [1 1])));

Wc1 = 1;
Wc2 = tf([100 1], [10 1]);

W01 = Wp * Wc1;
W02 = Wp * Wc2;

Wc1 = feedback(W01, 1, -1);
Wc2 = feedback(W02, 1, -1);
margin(Wc1);
hold on;
margin(Wc2);
