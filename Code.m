R1 = 1;
C = 0.25;
R2=2;
L = 0.2;
R3 = 10;
alpha = 100;
R4 = 0.1;
R0 = 1000;
Cmat =[ 0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0;
        0 0 0 -L 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0 0;
        0 0 0 0 0 -C 0 0 C;
        0 0 0 0 0 0 0 0 0;];

G =[-1    R0   0    0     0   0   0   0   0;
    -1/R4 -1 1/R4   0     0   0   0   0   0;
    0      0  -1   alpha  0   0   0   0   0;
    0      0   0   -1   1/R3  0   0   0   0;
    0      0   0    0    -1   1   0   0   0;
    0      0   0    0     0  -1   R2  0   0;
    0      0   0   -1     0   0  -1   1   0;
    0      0   0    0     0 -1/R1 0  -1 1/R1 ;
    0      0   0    0     0   0   0   0   1];
  
% V = [V0;I5;V4;I3;V3;V2;I2;I1;V1];
Vin = -10:1:10;
V0 = zeros(1,21);
V3 = zeros(1,21);
for a = 1:21
    F = [0 0 0 0 0 0 0 0 Vin(a)];
    V = G\F'; 
    V0(a) = V(1);
    V3(a) = V(5);
end
figure(1)
plot(Vin,V0);
hold on;
plot(Vin,V3);
hold off;
grid on;

omega = 1:100;
Vout = zeros(1,100);
gain = zeros(1,100);
for w = 1:100
    F = [0 0 0 0 0 0 0 0 10];
    Vmat = (G+1i.*w.*Cmat)\F'; 
    Vout(w) = Vmat(1);
    gain(w) = Vmat(1)/(10);
end

figure(2)
plot(omega, Vout);
hold on;
plot(omega,10*log(gain));
hold off;
Cvector = 0.05*randn(1,1000);
gain1 = zeros(1,1000);

for d = 1:1000
    Cmat(8,6) = -abs(Cvector(d));
    Cmat(8,9) = abs(Cvector(d));    
    Vmatrix = (G+1i.*pi.*Cmat)\F'; 
    gain1(d) = abs(Vmatrix(1))/(10);
end


figure(3)
% histogram(Cvector);
% hold on;
histogram(gain1);
% hold off;