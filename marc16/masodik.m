W1 = tf(100*[1 10], conv([1 1 0], [1 100]));
bode(W1);
margin(W1); %ez kelleni fog
%%
W0 = tf(100*[1 1], conv([1 0 0], [0.01 1]));
%margin(W0);