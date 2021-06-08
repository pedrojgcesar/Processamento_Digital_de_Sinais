clear all
%Leitura dos audios
y1 = audioread('Gravaçãoss.m4a');
y1 = y1(:,1);
fs = 44100;
%taxa de reducao de amostragem
reducao1 = 7;

for i=1:length(y1)/reducao1;
    ys1(i) = y1(reducao1*i);
    ts1(i) = i;
end

N = length(y1)/reducao1;

for k =  1:length(y1)/reducao1 
w(k) = 2*pi*k/N;
end

% Tipo 3  k = 1 e M par  
M = 110; N = M+1;
Omega_r1 = 1.28;Omega_p1 = 1.34;Omega_p2 = 1.42;Omega_r2 = 1.48; Omega_s = 2*pi;
kr1 = floor(N*Omega_r1/Omega_s);
kp = ceil(N*(Omega_p2-Omega_p1)/Omega_s);
kr2 = floor(N*(pi - Omega_r2)/Omega_s);

A = [ zeros(1,kr1+1), ones(1,kp+1), zeros(1,(kr2+1))];
k = 1:M/2;

for n=0:M,
    h(n+1) = 2*sum((-1).^(k+1).*A(k+1).*sin(pi.*k*(1+2*n)/N));
end;
hfiltro1 = h./N;
a = 1;
saidafiltro1 = conv(hfiltro1,ys1);
clear h
clear A
%Tipo 4  k = 1 e M impar  
M = 301; N = M+1;
Omega_p = 2; Omega_r = 1.9; Omega_s = 2*pi;

kp = floor(N*Omega_p/Omega_s);
kr = floor(N*Omega_r/Omega_s);

A = [ zeros(1,kr+1) , ones(1,((M-1)/2-kp+1+4)) ];

k = 1:(M-1)/2;

for n=0:M,
    h(n+1) =  (-1).^(N/2+n).*A(N/2) + 2*sum((-1).^(k).*A(k+1).*sin(pi.*k*(1+2*n)/N));
end;
hfiltro2 = h./N;
saidafiltro2 = conv(hfiltro2,ys1);
clear h
clear A
% Tipo 2  k = 0 e M ímpar  
M = 51; N = M+1;
Omega_p = 1.1; Omega_r = 1.15; Omega_s = 2*pi;

kp = ceil(N*Omega_p/Omega_s);
kr = ceil(N*Omega_r/Omega_s);

A = [ones(1,kp), 0 , zeros(1,(M-1)/2-kr)];
k = 1:(M-1)/2;

for n=0:M,
    h(n+1) = A(1) + 2*sum((-1).^k.*A(k+1).*cos(pi.*k*(1+2*n)/N));
end;
hfiltro3 = h./N;
saidafiltro3 = conv(hfiltro3,ys1);
 
%{
%sound(y1,fs)
%stem(hfiltro1);
%fvtool(hfiltro1,a)
%sound(y1,fs)
%sound(ys1,fs/reducao1)
%fvtool(hfiltro3,a)
%}
%{
subplot(4,1,1);
plot(w,abs(fft(ys1)));
subplot(4,1,2);
plot(w,abs(fft(saidafiltro1(1:length(w)))));
subplot(4,1,3);
plot(w,abs(fft(saidafiltro2(1:length(w)))));
subplot(4,1,4);
plot(w,abs(fft(saidafiltro3(1:length(w)))));
%}

%sound(y1,fs)
%sound(saidafiltro1,fs/reducao1);
%sound(saidafiltro2,fs/reducao1);
sound(saidafiltro3,fs/reducao1);
%{
filename = 'assovio01.wav';
audiowrite(filename,saidafiltro1,fs/reducao1);
filename = 'assovio02.wav';
audiowrite(filename,saidafiltro2,fs/reducao1);
filename = 'assovio03.wav';
audiowrite(filename,saidafiltro3,fs/reducao1);
%}