clear all
% Tipo 3  k = 1 e M par  
% Para esse filtro especificamos os Omega em rad 
M = 52; N = M+1;

Omega_r1 = 0.3;Omega_p1 = 0.4;Omega_p2 = 0.6;Omega_r2 = 0.7; Omega_s = 2*pi;

kr1 = floor(N*Omega_r1/Omega_s);
kp = floor(N*(Omega_p2-Omega_p1)/Omega_s);
kr2 = floor(N*(pi - Omega_r2)/Omega_s);

%Há um problema no arredondamento pois a função floor reduziu o tamanho dos
% k fazendo com que A não tenha tamanho sufisciente isso foi corrigido com
% zeros(1,(kr2+2)) adicionando um termo 1 no final
A = [ zeros(1,kr1+1), ones(1,kp+1), zeros(1,(kr2+2))];

k = 1:M/2;


for n=0:M,
    h(n+1) = 2*sum((-1).^(k+1).*A(k+1).*sin(pi.*k*(1+2*n)/N));
end;
h = h./N;

stem(h);

a = 1;
fvtool(h,a)