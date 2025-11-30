vid = videoinput('winvideo', 1); % For regular webcams
frame = getsnapshot(vid); % Capture a single frame
imshow(frame);