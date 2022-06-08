A = [0 0 1 0; 0 0 0 1; -0.8 0.3 0 0; 0.3 -0.3 0 0];
B = [0;0;0;1];
C = [ 1 0 0 0 ];
D = 0;
% cw eig(A);
Ts = 0.1;
sys = ss(A, B, C, D);
d_sys = c2d(sys, Ts, 'zoh');
Phi = d_sys.a;
Gamma = d_sys.b;
% cw eig(Phi)
%  cw abs(eig(Phi)
Mc = ctrb (Phi, Gamma); %rank(Mc)
Mb = obsv(Phi, C); %rank(Mo)
xi = 0.75; w0 = 0.6; s1 = -xi*w0 + j*w0*sqrt(1-xi^2);
s2 = conj(s1);
scinf = -3*w0;
soinf = -5*w0;
z1 = exp(s1*Ts); z2 = exp(s2*Ts);
zcinf = exp(scinf*Ts); zoinf = exp(soinf*Ts);
K = acker(Phi, Gamma, [z1 z2 zcinf zcinf]);
Nxu = inv([Phi-eye(4) Gamma; C 0])*[0;0;0;0;1];
Nx = Nxu(1:4); Nu = Nxu(end);
Gt = acker(Phi', Phi'*C', zoinf*ones(1,4));
G = Gt'; F = Phi - G*C*Phi; H = Gamma - G*C*Gamma;