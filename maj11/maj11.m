A1 = 2; T1 = 10; T2 = 4; T3 = 1;
A = [-1/T1 0 0; 1/T2 -1/T2 0; 0 A1/T3 -1/T3];
B = [1/T1; 0; 0];
C = [0 0 1]; D = 0;
sys = ss(A, B, C, D);
%eig(A) CW-be
Mc = ctrb(A, B);
%rank(Mc) CW-be
Mo = obsv(A, C);
xi = 0.7;
w0 = 1;
scinf= -3*w0*xi;
s1 = -xi*w0 +j*w0*sqrt(1-xi^2);
s2 = conj(s1);
K = acker(A, B, [s1 s2 scinf]);
Nxu = inv([A B; C 0]) * [0;0;0;1];
Nx = Nxu(1:3);
Nu =Nxu( end);
soinf = -5*w0*xi;
Gt = acker(A', C', [soinf soinf soinf]);
G = Gt';
F = A - G*C, H = B;
Ah = [A B; 0 0 0 0];
Bh = [B; 0]; Ch = [C 0];
Ght = acker(Ah', Ch', [soinf soinf soinf soinf]);
Gh = Ght';
Fh = Ah - Gh *Ch;
Hh = Bh;