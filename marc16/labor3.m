A = 5; T1 = 10; T2 = 4; T3 = 1;
Wp = tf(A, conv(conv([T1 1], [T2 1]), [T3 1]));
Wc = 0.035; W0 = Wc*Wp; step(feedback(W0,1, -1)); rlocus(W0);
nyquist(W0);
W0 = tf([0.5 1], [1 -1 1]);
roots(W0.den{1});
nyquist(W0);
pzmap(feedback(W0, 1 -1));
W0 = tf(3*[0.5 1], [1 -1 1]);
nyquist(W0);
pzmap(feedback(W0, 1 -1));
rlocus(W0);

