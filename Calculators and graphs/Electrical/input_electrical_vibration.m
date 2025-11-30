dq = daq("ni"); % For National Instruments DAQ devices
addinput(dq,"Dev1","ai0","Voltage"); % Add channel ai0
data = read(dq, seconds(10)); % Read for 10 seconds
plot(data.Time, data.Variables);
