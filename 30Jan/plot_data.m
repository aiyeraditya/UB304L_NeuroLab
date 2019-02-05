% Function for Plotting The Plots

function [spikes_baseline, spikes, mean_baseline, mean1] = plot_data(baseline_start, baseline_stop, start, stop, type)
    global action_threshold
    global samplingRate
    [voltage_baseline, time_baseline] = get_voltage(baseline_start, baseline_stop);
    length(voltage_baseline);
    [voltage, time] = get_voltage(start, stop);
    [data_baseline, peakIndex_base] = findpeaks(voltage_baseline,'MinPeakHeight',action_threshold);
    spikes_baseline = length(data_baseline) / (baseline_stop - baseline_start);
    %spikes_baseline = spikes_baseline;
    [data_peak, peakIndex] = findpeaks(voltage,'MinPeakHeight',action_threshold);
    spikes = length(data_peak) / (stop - start);
    %spikes = spikes;
    mean_baseline = mean(data_baseline);
    mean1 = mean(data_peak);
    figure
    subplot(1,2,1);
        plot(time_baseline, voltage_baseline)
        ylim([-1,1]);
        ylabel('Voltage (V)')
        xlabel('Time (s)')
        title('Baseline Firing')
        hline = refline([0 action_threshold]);
        hline.Color = 'black';
        hold on;
        for i = 1:length(peakIndex_base)
            plot(peakIndex_base/samplingRate + baseline_start, data_baseline, '*')
        end
        hold off;
    subplot(1,2,2);
        plot(time, voltage)
        ylim([-1,1]);
        ylabel('Voltage (V)')
        xlabel('Time (s)')
        title(strcat('Active Stimulation - ',type))
        hline = refline([0 action_threshold]);
        hline.Color = 'black';
        hold on;
        for i = 1:length(peakIndex)
            plot(peakIndex/samplingRate + start, data_peak, '*')
        end
        hold off;
    %saveas(gcf,strcat('Figure', type, 'Threshold),'jpeg'));
    
end