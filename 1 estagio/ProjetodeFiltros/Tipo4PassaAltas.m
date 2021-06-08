clear all
% Tipo 4  k = 1 e M impar  

M = 53; N = M+1;

Omega_p = 240*pi; Omega_r = 120*pi; Omega_s = 1200*pi;

kp = floor(N*Omega_p/Omega_s);
kr = floor(N*Omega_r/Omega_s);

A = [ zeros(1,kr+1) , ones(1,((M-1)/2-kp+1+4)) ];

k = 1:(M-1)/2;

for n=0:M,
    h(n+1) =  (-1).^(N/2+n).*A(N/2) + 2*sum((-1).^(k).*A(k+1).*sin(pi.*k*(1+2*n)/N));
end;
h = h./N;

stem(h);

a = 1;
fvtool(h,a)