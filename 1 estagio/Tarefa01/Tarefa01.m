clear all
%Criação do sinal Original
% Tt = Período de amostragem "continuo" 
% T = Período do sinal
f = 7*10.^3;
T = 1/f;
w  = 2*pi*f; 
ft = 160e3;
Tt = 1/ft;
ciclos = 5.5;
t = 0:Tt:ciclos*T;

y = cos(w*t);

%Criação do sinal amostrado
fs = 14e3;
Ts = 1/fs;
ts = 0:Ts:ciclos*T;
ys = cos(w*ts);
%Plotagem do sinal continuo e amostrado

hold on
plot(t,y,'r');
stem(ts,ys,'b');
% Recuperação do sinal amostrado
yr = 0;

for j =1:length(t)
for i=1:length(ts)
w(i) =  ys(i)* sinc(((j-1)*Tt -(i-1)*Ts)/ Ts);
end
yr(j) =sum(w);
end


plot(t,yr,'g');

hold off

