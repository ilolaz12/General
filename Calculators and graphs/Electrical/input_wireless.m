% radio = comm.SDRuReceiver('Platform','B200','CenterFrequency',2.4e9);
% [data,validData] = radio();
% if validData
%     plot(abs(data)); % Plot received signal magnitude
% end

u = udpport("LocalPort",5000); % Listen on port 5000

disp('Listening for UDP packets...');

while true
    if u.NumBytesAvailable > 0
        data = readline(u); % Read one line of incoming data
        disp("Received: " + data);
    end
    pause(0.1); % Avoid overwhelming CPU
end
