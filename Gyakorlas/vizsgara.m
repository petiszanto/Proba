A = 2;
T1 = 10;
T2 = 4;
fi = pi/4;
Wp = tf(A, conv([T1 1], [T2 1]));
Ti = max(T1, T2);
wc = tan(pi/4)/4;
Ap = 10*sqrt(T2^2*wc^2+1)*wc/2;
%%
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

a1= % u(k-1) egyutthatoja a szabalyozo differenciaegyenleteben, DPI-bol 
a2= % u(k-2) egyutthatoja a szabalyozo differenciaegyenleteben, DPI-bol 
b0= % e(k) egyutthatoja a szabalyozo differenciaegyenleteben, DPI-bol 
b1= % e(k-1) egyutthatoja a szabalyozo differenciaegyenleteben, DPI-bol 
b2= % e(k-2) egyutthatoja a szabalyozo differenciaegyenleteben, DPI-bol
%%
Ts=     % mintaveteli periodusido 
D=      % szakasz atvitel diszkret idoben 

Bplus=  % szakasz szamlalojanak faktorizaciojabol (monik)
Bminus= % szakasz szamlalojanak faktorizaciojabol

grAm=   % Am (modell nevezo) fokszama
grAo=   % Ao (megfigyelo polinom) fokszama
grS=    % szabalyozo szamlalo polinom fokszama a visszacsatolo agban
grR1v=  % szabalyozo nevezo polinom (integrator és Bplus nelkul) fokszama

z1=     % zart kor modell egyik dominans polusa
z2=     % zart kor modell másik dominans polusa
zcinf=  % zart kor modell gyors polusa
zoinf=  % megfigyelo polnom gyoke
Am=     % modell nevezojenek egyutthatoi
Ao=     % megfigyelo polinom egyutthatoi

M=      % diophantoszi egyenlet egyutthato matrixa
V=      % diophantoszi egyenlet egyutthato vektora
R1v=    % az R1v polinom egyutthatoi
S=      % az S polinom egyutthatoi

Bmv=    % Bmv erosites erteke
T=      % szabalyozo T polinomjanak egyutthatoi
R=      % szabalyozo R polinomjanak egyutthatoi