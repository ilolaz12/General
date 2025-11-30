% example3.m
% MATLAB example 3 - plotting values of a function
%---------------------------------------------------------------

%---------------------------------------------------------------
clear all

% close all open figure windows (plots/graphs)
close all
%---------------------------------------------------------------

%---------------------------------------------------------------
disp('An array of values, starting at -4, ending at 4, steps of 0.5');
x = [-4:0.5:4];

y = 2*x.^2 + 3*x - 2;
%---------------------------------------------------------------

%---------------------------------------------------------------
stem(y);
disp('Note how the x-axis is just the index number');
disp('Press a key to continue');
pause

stem(x,y);
disp('Plots y versus x');
disp('Press a key to continue');
pause
%---------------------------------------------------------------

%---------------------------------------------------------------
disp('Fixing up the presentation');
disp('axis, title, axis range...');

xlabel('x');
ylabel('y = f(x)');
axis([-5 5 -10 50]);
title('y = 2 x^2 + 3x - 2')
grid('on');
pause
%---------------------------------------------------------------

%---------------------------------------------------------------
disp('For a lot of points, use plot() not stem()');

x = [-4:0.01:4];
y = 2*x.^2 + 3*x - 2;

plot(x,y);
xlabel('x');
ylabel('y = f(x)');
axis([-5 5 -10 50]);
title('y = 2 x^2 + 3x - 2')
grid('on');
%---------------------------------------------------------------
