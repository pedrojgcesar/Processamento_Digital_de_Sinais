clear all
% Tipo 4  k = 1 e M impar  
% Tipo 2  k = 0 e M ímpar  
% Vamos projetar um filtro passa altas tipo 4 e um filtro passa baixas
% tipo 2 em seguida as respostas ao impulso serão somadas para obter a
% característica de um filtro rejeita faixa
% Foi definido que será feito um filtro rejeita faixas com frequência de
% corte 1 de 60 Hz frequencia de passagem1 50 frequencia de passagem2  610 e frequencia de corte 2 de 600 Hz onde a taxa de
% amostragem do sinal é de 2kHz

M = 53; N = M+1;

Omega_r1 = 120*pi;Omega_p1 = 100*pi;Omega_p2 = 1220*pi; Omega_r2 = 1200*pi; Omega_s = 4000*pi;


% Kp1 e Kr1 serão usados para calcular os coefiscientes do filtro passa
% baixa
kp1 = floor(N*Omega_p1/Omega_s);
kr1 = floor(N*Omega_r1/Omega_s);
% Kp2 e Kr2 serão usados para calcular os coefiscientes do filtro passa
% alta
kp2 = floor(N*Omega_p2/Omega_s);
kr2 = floor(N*Omega_r2/Omega_s);


A = [ones(1,kp1+1), 0 , zeros(1,(M-1)/2-kr1+1)];

k = 1:(M-1)/2;

for n=0:M,
    h(n+1) = A(1) + 2*sum((-1).^k.*A(k+1).*cos(pi.*k*(1+2*n)/N));
end;

h = h./N;


A = [ zeros(1,kr2+1) , ones(1,((M-1)/2-kp2+1+4)) ];



for n=0:M,
    h2(n+1) =  (-1).^(N/2+n).*A(N/2) + 2*sum((-1).^(k).*A(k+1).*sin(pi.*k*(1+2*n)/N));
end;

h2 = h2./N;

hs = h + h2;

% Ao somar as componentes da resposta em frequência passa-baixa e
% passa-alta podemos somar as componentes na frequencia de cada uma das respostas obtendo assim uma
% resposta rejeita-faixa devido as propriedades do sistema LIT
stem(hs);
a = 1;
fvtool(hs,a)