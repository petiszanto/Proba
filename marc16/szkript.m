A = [-1/640 1/160; -1/100 -1/25];
B = [0; 1/100];
Ct = [1/4 0];
%A = [3 5; 4 2];
[V, D, W] = eig(A);
%disp(V); %jobboldali sajátvektorok
disp('a:');
disp(D); % sajátértékek mátrixban
%disp(W); %baloldali sajátvektorok

V(:,1) = V(:,1) * 1/V(1,1);
%V(1,1) = V(1,1) * 1/V(1,1);
V(:,2) = V(:,2) * 1/V(1,2);
%V(1,2) = V(1,2) * 1/V(1,2);
disp('V');
disp(V);

W(:,1) = W(:,1) * 1/W(1,1);
%W(1,1) = W(1,1) * 1/W(1,1);
W(:,2) = W(:,2) * 1/W(1,2);
%W(1,2) = W(1,2) * 1/W(1,2);
disp('m1,2(W):');
disp(W);
G = -1 .* inv(A) * B;
disp('Xg(G):');
disp(G);
%X = W * [K1; K2] == G;
X = linsolve(W, G);
%fprintf('K: %d, m12: %d, a: %d', [X].', W, D);
disp('K1,2(X):');
disp(X);
%%fprintf('Y = %d*
m1 = [W(1,1); W(2,1)];
m2 = [W(1,2) ;W(2,2)];
disp(m1);
disp(m2);
egyik = Ct * ( X(1,1)*m1);
masik = Ct * ( X(1,1)*m2);
disp(egyik);
disp(masik);