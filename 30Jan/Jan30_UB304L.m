global voltageData
global samplingRate
global action_threshold

[voltageData, samplingRate]= audioread('LabData.wav');
time_diff = 1/samplingRate;
time_points = time_diff:time_diff:length(voltageData)/samplingRate;
% Plotting Raw Data
figure
plot(time_points, voltageData)
title('Volatge vs Time')
xlabel('Time (s)')
ylabel('Voltage (V)')

% Plotting Data at Specific Time Points
start = 10;
stop = 12;
V_Data = voltageData(start*samplingRate:stop*samplingRate);
l = length(voltageData);
time_points = start:time_diff:stop;
% Plotting Voltage Data as A Function of Time
figure
plot(time_points, V_Data)
title('Volatge vs Time')
xlabel('Time (s)')
ylabel('Voltage (V)')


% Visualsing Waveform of the audio file at a much finer scale 
maximum = max(voltageData);
index = find(voltageData == maximum);
figure
plot(voltageData(index-400:index+400))
title('Waveform of Action Potential')
ylabel('Voltage(V)')
xlabel('Time (Undefined)')

% The next few lines are for getting the digitized data from timepoints
action_threshold = 0.3;
baselineL_start = 4;
baselineL_stop = 12;
low_start = 25.5;
low_stop = 39.5;
[spikes_low_baseline, spikes_low, mean_baselineL, mean_low] = plot_data(baselineL_start, baselineL_stop, low_start, low_stop);

    
baselineM_start = 79;
baselineM_stop = 90;
medium_start = 102;
medium_stop = 108;
[spikes_medium_baseline, spikes_medium, mean_baselineM, mean_medium] = plot_data(baselineM_start, baselineM_stop, medium_start, medium_stop);


baselineH_start = 308;
baselineH_stop = 315;
high_start = 325.5;
high_stop = 344;
[spikes_high_baseline, spikes_high, mean_baselineH, mean_high] = plot_data(baselineH_start, baselineH_stop, high_start, high_stop);


% Bar Plot for Firing Rates
figure
num_spikes = [spikes_low_baseline, spikes_low, spikes_medium_baseline, spikes_medium,  spikes_high_baseline, spikes_high];
bar(num_spikes)

figure
peak_means = [mean_baselineL, mean_low, mean_baselineM, mean_medium, mean_baselineH, mean_high];
bar(peak_means)
% Indentifying Thresholds
count = 1;
spikes = (0);
step = maximum/10;
initial = maximum/50;
for threshold = initial:step:maximum
    [datapoints, peakIndex] = findpeaks(voltageData,'MinPeakHeight',threshold);
    spikes(count) = length(datapoints);
    count = count + 1;
end
figure
plot(initial:step:maximum,spikes);
title('Number of Spikes vs Threshold Values')
ylabel('Number of Spikes')
xlabel('Threshold (V)')




% For Adaptation
baseline_start = 394;
baseline_stop = 404;
[voltage_baseline, time_baseline] = get_voltage(baseline_start, baseline_stop);
start = 436;
stop = 456;
count = 1;
spikes = (0);
for s1 = start:1:stop
    [voltage, time] = get_voltage(s1, s1 + 5);
    [data_peak, peakIndex] = findpeaks(voltage,'MinPeakHeight',action_threshold);
    spikes(count) = length(data_peak);
    count = count + 1;
end




