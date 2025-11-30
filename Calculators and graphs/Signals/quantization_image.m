[img] = imread (' Gr a y s c a l e Ima g e . j p g ');
imgd = double (img);
% knowing that image is digital and range is of 255 - find the median and
% then 4 is the number of levels - so its been moved out
level=4;
imgq = floor ((imgd/255)*3 + 0.5)/level*255;
imgq = imgq + 256/level/2;
figure (1);
image (imgq);
colormap (gray(256));
axis( 'off');
box ( 'on');
figure (2);
[c pix] = hist (imgq(:));
bar (pix , c , 'w ');
set (gca , 'xlim ', [0 255]);
axis ([0 255 0 1e6]);
set (gca, 'xtick', [0 128 255 ]);