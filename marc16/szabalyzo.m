W = tf(5, conv([10 1], [4 1]));
%%Wp = 1;
%%W0 = W * Wp; bode(W0);
%%Wp = 10^(-(-4.33)/20);
%%W0 = W * Wp; margin(W0);
Wp = 3.8;
W0 = W * Wp; Wc1 = feedback(W0, 1, -1);
step(Wc1);
