% Sound of telephone line
fs = 44100;
T = 1/fs;
f1 = 2000;
f2 = 1800;
A = 1.0;
Tmax = 4;

t =[ (0:fs*Tmax)/fs ];
%t = linspace ( 0 , Tmax , fs *Tmax+1);

t = t(:);
y1 = A*sin(2*pi*f1*t);
y2 = A*sin(2*pi*f2*t);

ymult = y1 .* y2;

% Play sound
% sound ( y1 , fs );
% pause (Tmax );
% sound ( y2 , fs );
% pause (Tmax );
% sound ( ymult , fs );
% pause (Tmax );

% plot the carrier
subplot ( 3 , 1 , 1 ) ;
plot ( y1 , fs ) ;
% Plot the modulation
subplot ( 3 , 1 , 2 ) ;
plot ( y2 , fs ) ;
% plot the modulated AM waveform
subplot( 3 , 1 , 3 ) ;
plot (ymult , fs) ;