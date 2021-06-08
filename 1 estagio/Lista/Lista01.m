clear all

% sinal x(t) = cos(2*pi*4000*t) + cos(2*pi*600*t)


% Problema 01
%%{

f = 200;
T =1/f; 
% Como a maior componente em frequência do sinal e 4000Hz então a mínima
% frequência de amostragem deve ser de 8kHz
Ts = 1/(8e3);
ciclosexibicao = 1;

Tt = 1/160e3;
tt = 0:Tt:ciclosexibicao*T;
xt = cos(2*pi*4000*tt)+cos(2*pi*600*tt);

% vetor indexador do tempo de amostragem
t = 0:Ts:ciclosexibicao*T;
x1 = cos(2*pi*4000*t);
x2 = cos(2*pi*600*t);
xs = x1+x2;

%Configurações de plotagem Problema 1
%{
subplot(2,2,1);
plot(t,x1);
xlabel('cos 4000Hz');
subplot(2,2,2);
plot(t,x2);
xlabel('cos 600Hz');
subplot(2,2,3);
plot(t,xs);
xlabel('sinal amostrado');
subplot(2,2,4);
plot(tt,xt);
xlabel('sinal original');
%}

% Problema 2

% Recuperação do sinal original 
xr1 = zeros(1,length(tt));
w = zeros(1,length(t));
for j =1:length(tt)
for i=1:length(t)
w(i) =  xs(i)* sinc(((j-1)*Tt - (i-1)*Ts)/ Ts);
end
xr1(j) =sum(w);
end
clear w;

%Configurações de plotagem Problema 2
%{
subplot(2,1,1);
plot(tt,xt);
axis([0 5e-3 -2 2]);
xlabel('sinal original');
subplot(2,1,2);
plot(tt,xr1);
axis([0 5e-3 -2 2]);
xlabel('sinal recuperado');
%}


% Problema 3
ciclosconta = 20;

fs1 = 2e3;
fs2 = 4e3;
Ts1 = 1/fs1;
Ts2 = 1/fs2;
ts1 = 0:Ts1:ciclosexibicao*T;
ts2 = 0:Ts2:ciclosexibicao*T;
xs1 = cos(2*pi*4000*ts1) + cos(2*pi*600*ts1);
xs2 = cos(2*pi*4000*ts2) + cos(2*pi*600*ts2);


% Recuperação do sinal amostrado 1 
w = zeros(1,length(tt));
xrs1 = zeros(1,length(tt));
for j =1:length(tt)
for i=1:length(ts1)
w(i) =  xs1(i)* sinc(((j-1)*Tt - (i-1)*Ts1)/ Ts1);
end
xrs1(j) =sum(w);
end
clear w;


% Recuperação do sinal amostrado 2 
w = zeros(1,length(tt));
xrs2 = zeros(1,length(tt));
for j =1:length(tt);
for i=1:length(ts2)
w(i) =  xs2(i)* sinc(((j-1)*Tt - (i-1)*Ts2)/ Ts2);
end
xrs2(j) =sum(w);
end
clear w;

%Configurações de plotagem Problema 3
%{
subplot(2,2,1);
plot(tt,xt);
xlabel('sinal original');
subplot(2,2,2);
plot(tt,xrs1);
xlabel('sinal recuperado 2kHz');
subplot(2,2,3);
plot(tt,xrs2);
xlabel('sinal recuperado 4kHz');
%}







