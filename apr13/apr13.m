%Ezt kéne tudni, mert vizsgafeladat lesz (2 szabadságfokú)
A=2; T1 = 10; T2 =4; T3 = 1;
W=tf(A, conv(conv([T1 1], [T2 1]), [T3 1]));
w0 = 5/(T1+T2+T3);
xi = 0.7;
s1 = -xi*w0 + j*w0*sqrt(1-xi^2);  %nem szereti a j-t de ez van
s2 = conj(s1);
scinf = -3*w0; soinf = -5*w0;
Ts = 0.2;
z1 = exp(s1*Ts); z2 = exp(s2*Ts);
zoinf = exp(soinf*Ts); zcinf = exp(scinf*Ts);
D = c2d(W, Ts, 'zoh');
B = D.num{1};
B = B(2:end);
A = D.den{1};
Q = roots(B);
Bplus = 1; Bminus = B;
poly([0.5]);
l = 1;
grBminus = length(Bminus) - 1;
grAm = 1 + grBminus;
grA = length(A) - 1;
grS = grA + l - 1;
grR1v = grBminus;
grAo = grA + l - 1;
Am = poly([z1 z2 ones(1, grAm-2)*zcinf]);
Ao = poly(ones(1,grAo)*zoinf);
Bmv = polyval(Am,1) / polyval(Bminus,1);
T = Bmv*Ao;
AA = conv(A, [1 -1]);
BB = Bminus;
CC = conv(Am, Ao);
DM = [[AA'; 0] [0; AA'] ...
[BB';0;0;0] [0; BB';0;0] [0;0;BB';0] [0;0;0;BB']];
DV = CC(2:end)'-[AA(2:end) 0 0]';
sol = inv(DM)*DV;
R1v = [1 sol(1:2)'];
S = sol(3:end)';
R = conv(R1v, [1 -1]);

