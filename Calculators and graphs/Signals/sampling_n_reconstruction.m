% t o t a l samples , sample i n d e x v e c t o r
N = 100;
n = 0:N-1;
% j u s t a waveform made up f o r i l l u s t r a t i o n
x = sin(2*pi*1*n/N).*sin(2*pi*2.4*n/N);

figure(1);
plot(x);
% s tem p l o t shows s ampl e s
stem(x);
figure(2);
% s t a i r s p l o t shows waveform r e c o n s t r u c t e d
stairs (x);