%Codigo Primeira Unidade
clear all
%Leitura dos audios
y1 = audioread('Botafogo.mp4');

f = 44100;
Tt = 1/f;
reducao1 = 20;
Ts1 = reducao1/f;

amplitude1 = 0.9;

ys1 = zeros(1,floor(length(y1)/reducao1));
ts1 = zeros(1,floor(length(y1)/reducao1));

for i=1:length(y1)/reducao1;
    ys1(i) = y1(reducao1*i);
    ts1(i) = i;
end

t1 = 1:length(y1)/reducao1;

% Quantização com 10 bits ou 1024 níveis
% Foi escolhida a quantização linear, após um maior desenvolvimento pode ser melhorado o projeto
% res = resolução do sinal quantizado
res1 = 1/1024;
escala1 = -amplitude1+res1:res1:amplitude1;
reindexador1 = [-amplitude1,escala1];
[indexador1,yq1] = quantiz(ys1,escala1,reindexador1);

%plotagem do sinal quantizado  yq1



%Codigo tirado da primeira unidade
 
 N = length(yq1);

X = zeros(1,N);

for k=1:N
    w(k) = 2*pi*(k-1)/N;
end



subplot(2,1,1)
plot(t1,yq1,'B');
xlabel('Sinal Original');
subplot(2,1,2)
% Foi usado o algoritmo da fft built in devido ao imenso esforço
% computacional necessário para calcular a fft
 Xfft = fft(yq1);
 m = floor(N/2);
plot(w(1:m)/(2*pi*Tt),abs(Xfft(1:m)));
xlabel('Frequência em Hz');