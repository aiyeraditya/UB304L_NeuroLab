% Function for Plotting The Plots

function [spikes_baseline, spikes, mean_baseline, mean1] = plot_data(baseline_start, baseline_stop, start, stop, type)
    global action_threshold
    global voltageData
    global samplingRate
    [voltage_baseline, time_baseline] = get_voltage(baseline_start, baseline_stop);
    length(voltage_baseline);
    [voltage, time] = get_voltage(start, stop);
    figure
    subplot(1,2,1);
        plot(time_baseline, voltage_baseline)
        ylim([-1,1]);
        ylabel('Voltage (V)')
        xlabel('Time (s)')
        title('Baseline Firing')
    subplot(1,2,2);
        plot(time, voltage)
        ylim([-1,1]);
        ylabel('Voltage (V)')
        xlabel('Time (s)')
        title(strcat('Active Stimulation - ',type))
    saveas(gcf,strcat('Figure', type),'jpeg');
    [data_baseline, peakIndex] = findpeaks(voltage_baseline,'MinPeakHeight',action_threshold);
    spikes_baseline = length(data_baseline) / (baseline_stop - baseline_start);
    %spikes_baseline = spikes_baseline;
    [data_peak, peakIndex] = findpeaks(voltage,'MinPeakHeight',action_threshold);
    spikes = length(data_peak) / (stop - start);
    %spikes = spikes;
    mean_baseline = mean(data_baseline);
    mean1 = mean(data_peak);
end