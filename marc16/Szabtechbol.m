num1 = [1];
den1 = [100 1];
W1 = tf(num1, den1);
%%bode(W1);
step(W1);

