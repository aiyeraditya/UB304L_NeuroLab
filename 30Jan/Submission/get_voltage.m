function [voltage, time] = get_voltage(start, stop)
    global samplingRate
    global voltageData
    time_diff = 1/samplingRate;
    voltage = voltageData(start*samplingRate:stop*samplingRate);
    time = start:time_diff:stop;
end