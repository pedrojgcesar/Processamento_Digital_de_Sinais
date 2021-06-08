clear all


T = 1/200;
fs = 6e3;
Ts = 1/fs;
ciclos = 1;
ts = 0:Ts:ciclos*T;
ft = 160e3;
Tt = 1/ft;
tt = 0:Tt:ciclos*T;

xs = cos(2*4000*ts) + cos(2*600*ts);

xd1 = zeros(1,length(ts*2));
xd2 = zeros(1,length(ts*5));
xd3 = zeros(1,length(ts*10));

for i =1:length(ts)-1;
    xd1(2*i+1) = xs(i+1);
    xd2(5*i+1) = xs(i+1);
    xd3(10*i+1)= xs(i+1);
end

% Recuperação do sinal amostrado 
xr1 = zeros(1,length(tt));
w = zeros(1,length(ts));
for j =1:length(tt)
for i=1:length(ts)
w(i) =  xs(i)* sinc(((j-1)*Tt - (i-1)*Ts)/ Ts);
end
xr1(j) =sum(w);
end
clear w;

% Recuperação do sinal decimado  L = 2
xdr1 = zeros(1,length(tt));
w = zeros(1,length(xd1));
for j =1:length(tt)
for i=1:length(xd1)
w(i) =  xd1(i)* sinc(((j-1)*Tt - (i-1)*(2*Ts))/ (2*Ts));
end
xdr1(j) =sum(w);
end
clear w;

% Recuperação do sinal decimado L = 5
xdr2 = zeros(1,length(tt));
w = zeros(1,length(xd2));
for j =1:length(tt)
for i=1:length(xd2)
w(i) =  xd2(i)* sinc(((j-1)*Tt - (i-1)*(5*Ts))/ (5*Ts));
end
xdr2(j) =sum(w);
end
clear w;

% Recuperação do sinal decimado L = 10 
xdr3 = zeros(1,length(tt));
w = zeros(1,length(xd3));
for j =1:length(tt)
for i=1:length(xd3)
w(i) =  xd3(i)* sinc(((j-1)*Tt - (i-1)*(10*Ts))/ (10*Ts));
end
xdr3(j) =sum(w);
end


% Plotagem dos sinais
subplot(2,2,1);
plot(tt,xr1);
xlabel('Sinal Original');
subplot(2,2,2);
plot(tt,xdr1);
xlabel('Decimado L = 2');
subplot(2,2,3);
plot(tt,xdr2);
xlabel('Decimado L = 5');
subplot(2,2,4);
plot(tt,xdr3);
xlabel('Decimado L = 10');



