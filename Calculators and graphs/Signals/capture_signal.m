%% Audio Signals (from Microphone)
% 44.1 kHz, 16-bit, 1 channel (mono)
recObj = audiorecorder(44100, 16, 1); 
disp('Start speaking.');
% Record for 5 seconds
recordblocking(recObj, 5); 
disp('Recording finished.');
% Get the captured data
audioData = getaudiodata(recObj); 
% Plot waveform
plot(audioData); 

%% Vibration/Electrical Signals (using DAQ)
% For National Instruments DAQ devices
dq = daq("ni"); 
% Add channel ai0
addinput(dq,"Dev1","ai0","Voltage"); 
% Read for 10 seconds
data = read(dq, seconds(10)); 
plot(data.Time, data.Variables);

%% Images/Video Signals (from Camera)
% For regular webcams
vid = videoinput('winvideo', 1); 
% Capture a single frame
frame = getsnapshot(vid); 
imshow(frame);

%% Wireless RF Signals (with SDR)
radio = comm.SDRuReceiver('Platform','B200','CenterFrequency',2.4e9);
[data,validData] = radio();
if validData
    plot(abs(data)); % Plot received signal magnitude
end
