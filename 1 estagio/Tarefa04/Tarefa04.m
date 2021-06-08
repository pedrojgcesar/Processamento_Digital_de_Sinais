clear all
%Leitura dos audios
y1 = audioread('Botafogo.mp4');
y2 = audioread('PDS.mp4');

f = 44100;
Tt = 1/f;
reducao1 = 20;
reducao2 = 20;
Ts1 = reducao1/f;


amplitude1 = 0.9;
amplitude2 = 0.8;


for i=1:length(y1)/reducao1;
    ys1(i) = y1(reducao1*i);
    ts1(i) = i;
end

for i=1:length(y2)/reducao2;
    ys2(i) = y2(reducao2*i);
    ts2(i) = i;
end


t1 = 1:length(y1)/20;
t2 = 1:length(y2)/20;


% Quantização com 10 bits ou 1024 níveis
% Foi escolhida a quantização linear, após um maior desenvolvimento pode ser melhorado o projeto
% res = resolução do sinal quantizado
res1 = 1/1024;
escala1 = -amplitude1+res1:res1:amplitude1;
reindexador1 = [-amplitude1,escala1];
[indexador1,yq1] = quantiz(ys1,escala1,reindexador1);

%plotagem do sinal quantizado  yq1


subplot(2,1,1)
hold on
plot(t1,yq1,'B');

ylabel('Quantizado');
hold off

res2 = 1/1024;
escala2 = -amplitude2+res2:res2:amplitude2-res2;
reindexador2 = [-amplitude2,escala2];
[indexador2,yq2] = quantiz(ys2,escala2,reindexador2);

%plotagem do sinal quantizado yq2
subplot(2,1,2)
hold on
plot(t2,yq2,'B');
ylabel('Quantizado');


hold off
%}



 % sound(yq2,f/reducao2);
% Audio original comentado abaixo
 sound(y2,f) 

