clear all
beep off
%Criação do sinal Original
% Tt = Período de amostragem "continuo" 
% T = Período do sinal
f = 7e3;
w  = 2*pi*f;
T = 1/f;
ft = 160e3;
Tt = 1/ft;
ciclos =14;
t = 0:Tt:ciclos*T;

y = cos(w*t);

%Criação do sinal amostrado 2kHz
fs1 = 2e3;
Ts1 = 1/fs1;
ts1 = 0:Ts1:ciclos*T;
ys1 = cos(w*ts1);
%Criação do sinal amostrado 8kHz
fs2 = 8e3;
Ts2 = 1/fs2;
ts2 = 0:Ts2:ciclos*T;
ys2 = cos(w*ts2);
%Plotagem do sinal  continuo e amostrado em 2kHz
subplot(2,2,1);
hold on
plot(t,y,'r');
stem(ts1,ys1);
xlabel('Fs = 2kHz');
hold off
%Plotagem do sinal  continuo e amostrado em 8kHz
subplot(2,2,2);
hold on
plot(t,y,'B');
stem(ts2,ys2);
xlabel('Fs = 8kHz');
hold off

% Recuperação do sinal amostrado ys1
yr1 = zeros(1,length(t));
for j =1:length(t)
for i=1:length(ts1)
w(i) =  ys1(i)* sinc(((j-1)*Tt -(i-1)*Ts1)/ Ts1);
end
yr1(j) =sum(w);
end

subplot(2,2,3)
hold on
plot(t,y,'B')
plot(t,yr1,'g');
xlabel('Fs = 2kHz');
hold off

% Recuperação do sinal amostrado ys2
yr2 = zeros(1,length(t));
for j =1:length(t)
for i=1:length(ts2)
w(i) =  ys2(i)* sinc(((j-1)*Tt -(i-1)*Ts2)/ Ts2);
end
yr2(j) =sum(w);
end

subplot(2,2,4)
hold on
plot(t,y,'B')
plot(t,yr2,'g');
xlabel('Fs = 8kHz');
hold off