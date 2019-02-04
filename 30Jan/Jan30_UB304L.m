global voltageData
global samplingRate
global action_threshold

[voltageData, samplingRate]= audioread('homeWorkData.wav');
time_diff = 1/samplingRate;
time_points = time_diff:time_diff:length(voltageData)/samplingRate;
plot(voltageData)

% Visualsing Waveform of the audio file at a much finer scale 
% Assumption: Highest Voltage will be during stimulation, hence, during
% An Action Potential
maximum = max(voltageData(350*samplingRate:360*samplingRate));
index = find(voltageData == maximum);
figure
plot(voltageData(index-50:index+50))
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
action_threshold = 0.5;
% Plotting Raw Voltage Data as a function of Time
figure
plot(time_points, voltageData)
title('Raw Plot of Voltage vs Time')
xlabel('Time (s)')
ylabel('Voltage (V)')
hline = refline([0 action_threshold]);
hline.Color = 'red';
saveas(gcf,strcat('RawPlot'),'epsc')

% The next few lines are for getting the digitized data from timepoints
baselineL_start = 196;
baselineL_stop = 206;
low_start = 240;
low_stop = 250;
[spikes_low_baseline, spikes_low, mean_baselineL, mean_low] = plot_data(...
    baselineL_start, baselineL_stop, low_start, low_stop, 'Low');

    
baselineM_start = 262;
baselineM_stop = 272;
medium_start = 308;
medium_stop = 318;
[spikes_medium_baseline, spikes_medium, mean_baselineM, mean_medium] = ...
    plot_data(baselineM_start, baselineM_stop, medium_start, medium_stop, 'Medium');


baselineH_start = 326;
baselineH_stop = 336;
high_start = 350;
high_stop = 360;
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
baseline_start = 410;
baseline_stop = 420;
[voltage_baseline, time_baseline] = get_voltage(baseline_start, baseline_stop);
start = 421;
stop = 451;
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
