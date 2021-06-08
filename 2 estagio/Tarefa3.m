clear all
%Resolvi usar o  degrau para ficar mais parecido com a teoria de Analise
% x é um cosseno somado a um ruído  h é uma porta tamanho 3 começando
% em 1 foi escolhido assim por o matlab não aceitar vetor com indexação 0
 sympref('HeavisideAtOrigin',0);
% sympref faz o degrau ser 0 na origem
for i = 1:20
    x(i) = awgn(cos(2*pi*i/20),20)*(heaviside(i) - heaviside(i-5));
    h(i) = heaviside(i) - heaviside(i-3);
end
w = conv(h,x);
h(i+1:2*i-1) = zeros(1,i-1);
x(i+1:2*i-1) = zeros(1,i-1);
%convolução linear

N = 1:2*i-1;
y = zeros(1,length(N));
for n = 1:length(N)
    for i =1:length(N)
        if( (-i+n+1) > 0 && (-i+n) < length(h) )
            y(n) = y(n) + h(-i+n+1)*x(i);
        end
    end
end

subplot(2,2,1);
plot(N,y);
ylabel('Convolucão linear')
xlabel('Criada por mim');
%Comparação com a convolução do matlab
subplot(2,2,3);
plot(N,w);
ylabel('Convolucão linear')
xlabel('Matlab');


% Convolução circular
%Para que seja possível comparar com o resultado do matlab, vamos
%considerar x[1] = x(0) ou seja o primeiro valor do vetor x será
% equivalente ao x(0) no tempo discreto

% inversão circular do sinal h(n)
temp = h;
N = max(length(x),length(h));
y = zeros(1,N);
for n = 2:N
    h(n) = temp(N+2-n);
end
clear temp

for n = 1:N  
    
        for i =1:N
            y(n) = y(n) + h(i)*x(i);
        end
         %deslocamento circular
            temp(1) = h(2);
            h(2) = h(1);
            for k = 2:N-1
                %deslocamentos
                temp(rem(k+1,2)+1) = h(k+1);
                h(k+1) = temp(rem(k,2)+1);   
            end
        %Ultimo deslocamento y(0) = y(N)
        
        if ( rem(k,2))
            h(1) = temp(1);
        else
            h(1) = temp(2);
        end
end

%Inverti de volta para comparar com o cconv do matlab
temp = h;
N = max(length(x),length(h));
for n = 2:N
    h(n) = temp(N+2-n);
end
clear temp

n = 0:N-1;
subplot(2,2,2);
plot(n,y);
ylabel('Convolucão circular')
xlabel('Criada por mim');
axis([ 0 40 0 3 ]);
subplot(2,2,4);
plot(n,cconv(x,h,N));
ylabel('Convolucão circular')
xlabel('Matlab');
axis([ 0 40 0 3 ]); 


%}