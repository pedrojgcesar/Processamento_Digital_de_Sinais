clear all

% Projeto de um filtro IIR 
%frequência de amostragem
fp = 700;
fcc = 1e3;
fd = 4e3;
%Periodo de amostragem
Td = 1/fd;
% frequência de corte
omega_cc = 2*pi*fcc;
%frequência de passagem
omega_p = 1.4*pi*1e3;
%ordem do filtro
N = 7;
M = 53;
%frequência de corte de 3db
omega_c = 10.^( -log10(10.^(1/10) -1 )/14 + log10( 1400*pi) ); 

for k = 1:N
    sk(k) = omega_c* exp((j*pi/(2*N))*( 2*k+N-1));
end
%Expandimos a função de transferência, foi colocado 1 como o valor de zeros
%pois o programa não aceita um valor vazio,em sequida num e apagado e feito
%igual a 1 para corrigir
[num,den] = zp2tf( [] , sk,1 );

num = omega_c.^N ;
 [A,polos,k]  = residue(num,den);
 
% foi usada a transformada inversa
 numz = Td*A;
 denz = exp(polos*Td);


for  i=1:3
Dh1(i) = -2*real(denz(2*i-1));
Dh2(i) = abs(denz(2*i-1)).^2;
Nh1(i) =  numz(2*i) + numz(2*i-1);
Nh2(i) = -conj(denz(2*i))*numz(2*i) -denz(2*i-1)*numz(2*i-1);
Nh1 = real(Nh1);
Nh2 = real(Nh2);
end

a0 = Nh1;
a1 = Nh2;
b0 = 1;
b1 = Dh1;
b2 = Dh2;

%clear Nh1;
%clear Nh2;
clear Dh1;
clear Dh2;


%Criação do sinal Original
% Tt = Período de amostragem "continuo" 
% T = Período do sinal
f = 5000;
T = 1/f;
w  = 2*pi*f; 
ft = 160e3;
Tt = 1/ft;
ciclos = 5;
t = 0:Tt:ciclos*T;

x = cos(w*t);

%Criação do sinal amostrado
fs = 32e3;
Ts = 1/fs;
ts = 0:Ts:ciclos*T;
%foi aplicado um impulso como entrada para obter a ca



xs = [ 0 0 cos(w*ts) ] ;
x2(1) = 0;
x2(2) = 0;
y7 = zeros(1,2);

for j = 1:3
    for i=3:length(ts)+2
        x2(i,j) = xs(i) + (-b1(j)/b0)*x2(i-1) + (-b2(j)/b0)*x2(i-2);
        y(i,j) = x2(i)*(a0(j)/b0) + x2(i-1)*(a1(j)/b0);
         y7(i) = numz(7)*xs(i) + denz(7)*y7(i-1);
    end
end
% y7 é o filtro cuja função de transferência correspondente não tem
% conjugado complexo

y = y';

saida = sum(y) + y7;

hold on
plot(ts,xs(3:length(ts)+2),'g');
plot(ts,saida(3:length(ts)+2),'r');
hold off
