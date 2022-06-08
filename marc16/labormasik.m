Kc5 = 1; Wc5 = tf(Kc5*[4 0.5 1], [1 1 0]) ;
W05 = Wp*Wc5;
%pzmap(W05);
%mineral(W05);
%Wc15 = feedback(W05, 1, -1); step(Wc15);
%Wur = feedback(Wc5, Wp, -1); step(Wur);
%rlocus(W05);
figure(2); pzmap(Wc15); %itt fogalmam nem volt, hol tartunk


