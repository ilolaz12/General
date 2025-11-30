%% Example 1: 
t = 0:1/8000:1;
x = sin(2*pi*t*300);
plot(t,x);
plot(t(1:100), x(1:100));
stem(t(1:100), x(1:100));
stairs(t(1:100), x(1:100));
sound(x, 8000);
x = sin(2*pi*t*400);
sound(x, 8000);
x = sin (2*pi*t*7700);
sound(x, 8000);
x = sin(2*pi*t*7600);
sound(x, 8000);

%% Example 2: 