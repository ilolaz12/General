recObj = audiorecorder(44100, 16, 1); % 44.1 kHz, 16-bit, 1 channel (mono)
disp('Start speaking.');
recordblocking(recObj, 5); % Record for 5 seconds
disp('Recording finished.');
audioData = getaudiodata(recObj); % Get the captured data
plot(audioData); % Plot waveform

f s = 8000;
n b i t s = 1 6 ;
nchan = 1 ;
tmax = 4 ;
Re c o r d e r = a u d i o r e c o r d e r ( f s , n b i t s , nchan ) ;
r e c o r d ( Re c o r d e r ) ;
f p r i n t f ( 1 , ' Re cording . . . \ n ' ) ;
paus e ( tmax ) ;
s t o p ( Re c o r d e r ) ;
% c o n v e r t t o f l o a t i n g − p o i n t v e c t o r and p l a y back
% n o t e f o rma t i s i n t 1 6 wi th no s p a c e wi t h i n t h e q u o t e s ' '
y i = g e t a u d i o d a t a ( Re corde r , ' i n t 1 6 ' ) ;
y = d o u bl e ( y i ) ;
y = y /max ( abs ( y ) ) ;
p l o t ( y ) ;
sound ( y , f s ) ;