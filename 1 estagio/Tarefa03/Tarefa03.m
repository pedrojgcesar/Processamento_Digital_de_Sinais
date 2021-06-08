clear all

%Cria��o do sinal Original
% Tt = Per�odo de amostragem "cont�nuo" 
% T = Per�odo do sinal
f = 7e3;
w  = 2*pi*f;
T = 1/f;
ft = 500e3;
Tt = 1/ft;
ciclos =14;
t = 0:Tt:ciclos*T;
amplitude = 1;
y = amplitude*cos(w*t);

%Cria��o do sinal amostrado 2kHz
fs1 = 2e3;
Ts1 = 1/fs1;
ts1 = 0:Ts1:ciclos*T;
ys1 = amplitude*cos(w*ts1);
%Cria��o do sinal amostrado 8kHz
fs2 = 8e3;
Ts2 = 1/fs2;
ts2 = 0:Ts2:ciclos*T;
ys2 = amplitude*cos(w*ts2);


% Quantiza��o com 10 bits ou 1024 n�veis
% Foi escolhida a quantiza��o linear, ap�s um maior desenvolvimento pode ser melhorado o projeto
% res = resolu��o do sinal quantizado
res1 = 1/1024;
escala1 = -amplitude+res1:res1:amplitude;
reindexador1 = [-amplitude,escala1];
[indexador1,yq1] = quantiz(ys1,escala1,reindexador1);

%Quantiza��o do sinal 2
res2 = 1/1024;
escala2 = -amplitude+res2:res2:amplitude-res2;
reindexador2 = [-amplitude,escala2];
[indexador2,yq2] = quantiz(ys2,escala2,reindexador2);



%Interpola��o do sinal quantizado1
%A interpolacao adicionar� m valores entre as amostras
m=1;
yint1 = zeros(0,(length(ts1)-1)*(m+1)+1);

for j=1:length(ts1)-1
for i= 1:m
    yint1( (m+1)*(j-1) + (i+1) ) = yq1(j) + (yq1(j+1)-yq1(j))*(i)/(m+1);
    
end
end

for j=1:length(ts1)
yint1(1+(m+1)*(j-1)) = yq1(j);
end

% tint1= 1:(length(ts1)-1)*(m+1)+1;
%Periodo do sinal interpolado
Tint1 = Ts1/(m+1);
tint1 =0:Tint1:ciclos*T;
%Interpola��o do sinal quantizado2
%A interpolacao adicionar� n valores entre as amostras
n=10;
yint2 = zeros(0,(length(ts2)-1)*(n+1)+1);

for j=1:length(ts2)-1
for i= 1:n
    yint2( (n+1)*(j-1) + (i+1) ) = yq2(j) + (yq2(j+1)-yq2(j))*(i)/(n+1);
    
end
end

for j=1:length(ts2)
yint2(1+(n+1)*(j-1)) = yq2(j);
end

%tint2= 1:(length(ts2)-1)*(n+1)+1;
Tint2 = Ts2/(n+1);
tint2 =0:Tint2:ciclos*T;

% Recupera��o do sinal interpolado yi1
yr1 = zeros(1,length(t));
for j =1:length(t)
for i=1:length(tint1)
w1(i) =  yint1(i)* sinc(((j-1)*Tt -(i-1)*Tint1)/ Tint1);
end
yr1(j) =sum(w1);
end

% Recupera��o do sinal interpolado yi2
yr2 = zeros(1,length(t));
for j =1:length(t)
for i=1:length(tint2)
w2(i) =  yint2(i)* sinc(((j-1)*Tt -(i-1)*Tint2)/ Tint2);
end
yr2(j) =sum(w2);
end

% Plotagem do sinal interpolado e recuperado yr1
subplot(2,1,1)
hold on
plot(t,yr1,'R');
plot(tint1,yint1,'x');
xlabel('Fs = 2kHz');
ylabel('Interpolado e Recuperado');
hold off


% Plotagem do sinal interpolado e recuperado yr2
subplot(2,1,2)
hold on
plot(t,yr2,'R');
plot(tint2,yint2,'G');
xlabel('Fs = 8kHz');
ylabel('Interpolado e Recuperado');
hold off



%Calculo do erro
%{ 
error1 = zeros(0,length(t));
error2 = zeros(0,length(t));

for i=1:length(t) 
    error1(i) = ((yr1(i)-yint1(i))/yr1(i));
    error2(i) = ((yr2(i)-yint2(i))/yr2(i));
end
    subplot(2,2,3);
    plot(t,error1);
    xlabel('Erro 2kHz');
    subplot(2,2,4);
    plot(t,error2);
    xlabel('Erro 8kHz');

%}

