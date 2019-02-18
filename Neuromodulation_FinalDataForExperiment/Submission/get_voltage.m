function [voltage, time] = get_voltage(voltageData, samplingRate, start, stop)
    time_diff = 1/samplingRate;
    voltage = voltageData(start*samplingRate:stop*samplingRate);
    voltage = voltage*-1;       % Flip Voltage for Extracellular Recording
    time = start:time_diff:stop;
end