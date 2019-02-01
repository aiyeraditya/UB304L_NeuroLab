% Function for Plotting The Plots

function [spikes_baseline, spikes, mean_baseline, mean1] = plot_data(baseline_start, baseline_stop, start, stop)
    global voltageData
    global samplingRate
    global action_threshold
    [voltage_baselineL, time_baselineL] = get_voltage(baseline_start, baseline_stop);
    [voltage_low, time_low] = get_voltage(start, stop);
    subplot(1,2,1);
        plot(voltage_baselineL)
    subplot(1,2,2);
        plot(voltage_low)
    [data_baselineL, peakIndexL] = findpeaks(voltage_baselineL,'MinPeakHeight',action_threshold);
    spikes_baseline = length(data_baselineL);
    [data_peaklow, peakIndexlow] = findpeaks(voltage_low,'MinPeakHeight',action_threshold);
    spikes = length(data_peaklow);
    mean_baseline = mean(data_baselineL);
    mean1 = mean(data_peaklow);
end