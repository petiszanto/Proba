Ti= 10; % szabalyozo idoallandoja 
W0 = tf(5, conv([2 1], conv([4 1], [10 0])));
[Gm, Pm, ~, Wcp] = margin(W0);
wc1= Wcp;% vagasi frekvencia ha Ap=1 

phit1= Pm; % fazistartalek, ha Ap=1 
margin(W0);

wc1 = 0.129; %leolvasva, és korrigálva a toleranciának megfelelően

Ap= sqrt(4*wc1^2+1)*sqrt(4*wc1^2+1)*Ti*wc1/5; % szabalyozo erositese
WPI= tf(conv(Ap, [Ti 1]), conv(Ti, [1 0]));% folytonos szabalyozo atviteli fuggvenye (tf objektum), Ap, Ti alapjan 
DPI= c2d(WPI, Ti, 'zoh');% diszkret szabalyozo atviteli fuggvenye (tf objektum), WPI alapjan

a1= -1;% u(k-1) egyutthatoja a szabalyozo differenciaegyenleteben, DPI-bol 
a2= 0;% u(k-2) egyutthatoja a szabalyozo differenciaegyenleteben, DPI-bol 
b0= 0.2752;% e(k) egyutthatoja a szabalyozo differenciaegyenleteben, DPI-bol 
b1= 0;% e(k-1) egyutthatoja a szabalyozo differenciaegyenleteben, DPI-bol 
b2= 0;% e(k-2) egyutthatoja a szabalyozo differenciaegyenleteben, DPI-bol