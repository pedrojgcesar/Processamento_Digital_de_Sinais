clear all
% Tipo 1 k = 0, M Par
M = 52; N = M+1;

Omega_r1 = 120*pi;Omega_p1 = 100*pi;Omega_p2 = 1220*pi; Omega_r2 = 1200*pi; Omega_s = 4000*pi;

% Kp1 e Kr1 serão usados para calcular os coefiscientes do filtro passa
% baixa
kp1 = floor(N*Omega_p1/Omega_s);
kr1 = floor(N*Omega_r1/Omega_s);
% Kp2 e Kr2 serão usados para calcular os coefiscientes do filtro passa
% alta
kp2 = floor(N*Omega_p2/Omega_s);
kr2 = floor(N*Omega_r2/Omega_s);

A = [ones(1,kp1+1) zeros(1,M/2-kr1+1)];

A2 = [zeros(1,kp2+1) ones(1,M/2-kr2+1)];
k = 1:M/2;

for n=0:M,
    h(n+1) = A(1) + 2*sum((-1).^k.*A(k+1).*cos(pi.*k*(1+2*n)/N));
end;

h = h./N;

for n=0:M,
    h2(n+1) = A2(1) + 2*sum((-1).^k.*A2(k+1).*cos(pi.*k*(1+2*n)/N));
end;


h2 = h2./N;

hs = h + h2;

stem(hs);


% Ao somar as componentes da resposta em frequência passa-baixa e
% passa-alta podemos somar as componentes na frequencia de cada uma das respostas obtendo assim uma
% resposta rejeita-faixa devido as propriedades do sistema LIT


a = 1;
fvtool(hs,a)