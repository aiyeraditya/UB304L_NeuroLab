global voltageData
global samplingRate
global action_threshold

[voltageData, samplingRate]= audioread('LabData.wav');
time_diff = 1/samplingRate;
time_points = time_diff:time_diff:length(voltageData)/samplingRate;


% Visualsing Waveform of the audio file at a much finer scale 
% Assumption: Highest Voltage will be during stimulation, hence, during
% An Action Potential
maximum = max(voltageData);
index = find(voltageData == maximum);
figure
plot(voltageData(index-200:index+200))
title('Waveform of Action Potential')
ylabel('Voltage(V)')
xlabel('Time (Undefined)')
saveas(gcf,strcat('ActionPotential'),'epsc')

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
saveas(gcf,strcat('Threshold'),'epsc')

% Defining Threshold for Action Potentials And Show Threshold on Figure
action_threshold = 0.3;
% Plotting Raw Voltage Data as a function of Time
figure
plot(time_points, voltageData)
title('Raw Plot of Voltage vs Time')
xlabel('Time (s)')
ylabel('Voltage (V)')
hline = refline([0 0.3]);
hline.Color = 'red';
saveas(gcf,strcat('RawPlot'),'epsc')

% The next few lines are for getting the digitized data from timepoints
baselineL_start = 4;
baselineL_stop = 12;
low_start = 25.5;
low_stop = 39.5;
[spikes_low_baseline, spikes_low, mean_baselineL, mean_low] = plot_data(...
    baselineL_start, baselineL_stop, low_start, low_stop, 'Low');

    
baselineM_start = 79;
baselineM_stop = 90;
medium_start = 102;
medium_stop = 108;
[spikes_medium_baseline, spikes_medium, mean_baselineM, mean_medium] = ...
    plot_data(baselineM_start, baselineM_stop, medium_start, medium_stop, 'Medium');


baselineH_start = 308;
baselineH_stop = 315;
high_start = 325.5;
high_stop = 344;
[spikes_high_baseline, spikes_high, mean_baselineH, mean_high] = ...
    plot_data(baselineH_start, baselineH_stop, high_start, high_stop, 'High');


% Bar Plot for Firing Rates
figure
num_spikes = [spikes_low_baseline, spikes_low, spikes_medium_baseline, ...
    spikes_medium,  spikes_high_baseline, spikes_high];
bar(num_spikes)
ylabel('Number of Spikes')
title('Firing Rates and Stimulation - "Rate Coding"')
set(gca,'XTickLabel',{'Baseline','Low', 'Baseline', 'Medium', 'Baseline', 'High'});
saveas(gcf,strcat('SpikesBarPlot'),'epsc')

figure
peak_means = [mean_baselineL, mean_low, mean_baselineM, mean_medium, ...
    mean_baselineH, mean_high];
bar(peak_means)
title('Mean of Action Potential Peaks')
ylabel('Voltage (V)')
set(gca,'XTickLabel',{'Baseline','Low', 'Baseline', 'Medium', 'Baseline', 'High'});
saveas(gcf,strcat('ActionPotentialPeaks'),'epsc')

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
bar(spikes)
ylabel('Number of Spikes')
xlabel('Time Bins')
title('Firing Rate with Continual Stimulus - Adaptation')
saveas(gcf,strcat('Adaptation'),'epsc')
