clear all

% sinal x(t) = cos(2*pi*4000*t) + cos(2*pi*600*t)
f = 200;
T =1/f; 
Ts = 1/(6e3);
ciclosexibicao = 1;

Tt = 1/160e3;
tt = 0:Tt:ciclosexibicao*T;
xt = cos(2*pi*4000*tt)+cos(2*pi*600*tt);

% vetor indexador do tempo de amostragem
t = 0:Ts:ciclosexibicao*T;
x1 = cos(2*pi*4000*t);
x2 = cos(2*pi*600*t);
xs = x1+x2;

%Interpolação do sinal amostrado com 
%A interpolacao adicionará m valores entre as amostras

k=1;
for m = [ 2 5 10 ]
    
for j=1:length(t)-1
for i= 1:m
    yint(k, (m+1)*(j-1) + (i+1) ) = xs(j) + (xs(j+1)-xs(j))*(i)/(m+1);
    
end
end

for j=1:length(t)
yint(k,(1+(m+1)*(j-1))) = xs(j);
end

%Periodo do sinal interpolado
Tint(k) = Ts/(m+1);


k = k+1;
end
m = 2;
tint1= 1:(length(t)-1)*(m+1)+1;
m = 5;
tint2= 1:(length(t)-1)*(m+1)+1;
m = 10;
tint3= 1:(length(t)-1)*(m+1)+1;



% Recuperação do sinal interpolado yi1 m = 2
w1 = zeros(0,length(tint1));
yr1 = zeros(1,length(tt));
for j =1:length(tt)
for i=1:length(tint1)
w1(i) =  yint(1,i)* sinc(((j-1)*Tt -(i-1)*Tint(1))/ Tint(1));
end
yr1(j) =sum(w1);
end

clear w1

w1 = zeros(0,length(tint2));
% Recuperação do sinal interpolado yi1 m = 5
yr2 = zeros(1,length(tt));
for j =1:length(tt)
for i=1:length(tint2)
w1(i) =  yint(2,i)* sinc(((j-1)*Tt -(i-1)*Tint(2))/ Tint(2));
end
yr2(j) =sum(w1);
end
clear w1

% Recuperação do sinal interpolado yi1 m = 10
w1 = zeros(0,length(tint2));
yr3 = zeros(1,length(tt));
for j =1:length(tt)
for i=1:length(tint3)
w1(i) =  yint(3,i)* sinc(((j-1)*Tt -(i-1)*Tint(3))/ Tint(3));
end
yr3(j) =sum(w1);

end

% Plotagem do sinal interpolado e recuperado yr1
subplot(2,2,1)
hold on
plot(tt,xt,'R');
xlabel('sinal original');
hold off
subplot(2,2,2)
hold on
plot(tt,yr1,'R');
xlabel('M = 2');
hold off
subplot(2,2,3)
hold on
plot(tt,yr2,'R');
xlabel('M = 5');
hold off
subplot(2,2,4)
hold on
plot(tt,yr3,'R');
xlabel('M = 10');
hold off

%}