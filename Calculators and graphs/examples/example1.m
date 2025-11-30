% example1.m
% MATLAB example 1 - basic arithmetic and row/column arrangement
%---------------------------------------------------------------

%---------------------------------------------------------------
% clear all variables
clear all
%---------------------------------------------------------------

%---------------------------------------------------------------
disp('Defining values:');

% make a row vector
a = [1 2 3];
a

% make a column vector
x = [1 2 3]';
x

disp('Shows that "a" is a row vector, and "x" is a column vector');
disp('Press a key to continue.');
pause
%---------------------------------------------------------------

%---------------------------------------------------------------
disp('Simple arithmetic:');

% add 4 to all elements of a
b = a + 4;
b

% b minus a
r = b - a;
r

disp('Shows "b = a + 4" then "r = a - b"');
disp('Press a key to continue.');
pause
%---------------------------------------------------------------


%---------------------------------------------------------------
disp('Element-wise arithmetic:');

% vector with all elements of a times 2
d = 2*a

% vector with 7 added to element 2 of a, all others unchanged
e = a;
e(2) = e(2) + 7;
e

% first element of a times 2
c = a(1)*2

disp('All "a" times 2, then 7 added to a(2), then a(1)*2');

disp('Press a key to continue.');
pause
%---------------------------------------------------------------

%---------------------------------------------------------------
disp('The ''shape'' of vector arrays (rows or columns)');

% a column vector
v = [5 ; 6 ; 7];
v

% add a and v
%disp('This won''t work as expected. Comment out with a % sign at the start and re-try');
%r = a + v;    % will not work as expected. Result depends on MATLAB version.

r = a + v';     % row vector result
r

r = a' + v;     % column vector result
r

disp('Press a key to continue.');
pause
%---------------------------------------------------------------


%---------------------------------------------------------------
disp('Operating on individual elements at a time');
% square all elements of a

%disp('This won''t work. Comment out with a % sign at the start and re-try');
%sqa = a*a;  % will not work! 
sqa = a.^2;
sqa

disp('Each element of a squared');
disp('Press a key to continue.');
pause
%---------------------------------------------------------------

%---------------------------------------------------------------
disp('Shows the variables we currently have.');
disp('note "size" is "rows x columns"');

whos
%---------------------------------------------------------------



