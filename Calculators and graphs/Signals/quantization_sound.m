[y, fs] = audioread ( 'mal.wav');
plot(y);
%  scales it to floating point integer within +_ 4 range
yq=round(y*4)/4;
figure(1);
plot(yq);
sound(yq);