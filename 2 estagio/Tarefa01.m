clear all
% A valor de janelamento indica o tipo de janela aplicada 1-retangular
% 2-Hanning 3-Hamming
f = 100;
f2 = 780;
f3 = 1500;
w1  = 2*pi*f;
w2  = 2*pi*f2;
w3  = 2*pi*f3;
janelamento =3;
ciclos = 1;

%Calculamos a frequência fundamental do sinal da soma
f0 = gcd(gcd(f,f2),f3);
T0 = 1/f0;
%É criado um N para fazer ser o periodo do meu sinal discretizado
N = 2.^8;
Tt = T0/(N);
fs = 1/Tt;
% onde Tt é o periodo de amostragem
%Criação do sinal Original
% Tt = Período de amostragem "continuo" 
t = 0:Tt:ciclos*T0-Tt;

y1 = cos(w1*t);
y2 = cos( w2*t);
y3 = cos( w3*t);

xx = y1+y2+y3;

janela = zeros(1,length(xx));

for n=1:length(xx)
    
if janelamento == 1
    janela(n) = 1; 
    elseif janelamento == 2
        janela(n) = (1-cos(2*pi*n/N))/2;     
        elseif janelamento == 3
            janela(n) =(0.54-0.46*cos(2*pi*n/N));
end
end

x = xx.*janela;
X = zeros(1,N);

for k=1:N
    for n=1:length(x)
    X(k) = X(k) + x(n)*exp(-1i*2*pi*(k-1)*n/N);
    end
end
k = [ 1:N ];

for k =  1:N 
w(k) = 2*pi*(k-1)/N;
end

XXfft = fft(xx);
Xfft = fft(x);


hold on
subplot(2,2,1);
plot (t,x);
xlabel('Sinal Original');
subplot(2,2,2);
plot(w,abs(Xfft));
xlabel('Módulo da FFT do Sinal Original');
subplot(2,2,3);
plot(w,abs(fft(janela(1:N))));
xlabel('Módulo da FFT da Janela Escolhida');
subplot(2,2,4);
plot(w,abs(XXfft));
xlabel('FFT após Janelamento');




%}