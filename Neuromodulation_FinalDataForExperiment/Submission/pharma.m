load('Pharama_Intervention/baseline.mat')
load('Pharama_Intervention/nicotine.mat')
load('Pharama_Intervention/nicotine_alcohol.mat')

threshold = 0.0038;
[voltage_bl, time_bl] = get_voltage(data_baseline, fs_baseline, 20, 40);
[data_baseline, peakIndex_base] = findpeaks(voltage_bl,'MinPeakHeight'...
    ,threshold);
baseline_firing = length(data_baseline)/20;
figure
plot(time_bl, voltage_bl)
title('Raw Plot - Baseline')
hline = refline([0 threshold]);
hline.Color = 'red';
set(hline,'LineWidth',1)
ylabel('Time (s)')
xlabel('Voltage')
ylim([-0.05, 0.03])
hold on;
        for i = 1:length(peakIndex_base)
            plot(peakIndex_base/fs_baseline + 20, data_baseline, '*')
        end
hold off;

[voltage_nicotine, time_nicotine] = get_voltage(data_nicotine, fs_nicotine, 20, 40);
figure
[data_nicotine, peakIndex_nicotine] = findpeaks(voltage_nicotine,'MinPeakHeight',threshold);
nicotine_firing = length(data_nicotine)/20;
plot(time_nicotine, voltage_nicotine)
title('Raw Plot - Nicotine')
hline = refline([0 threshold]);
hline.Color = 'red';
set(hline,'LineWidth',1)
ylabel('Time (s)')
xlabel('Voltage')
ylim([-0.05, 0.03])
hold on;
        for i = 1:length(peakIndex_nicotine)
            plot(peakIndex_nicotine/fs_nicotine + 20, data_nicotine, '*')
        end
hold off;

[voltage_nic_alc, time_nic_alc] = get_voltage(data_nic_alc, fs_nic_alc, 20, 40);
figure
plot(time_nic_alc, voltage_nic_alc)
title('Raw Plot - Nicotine + Alcohol')
hline = refline([0 threshold]);
hline.Color = 'red';
set(hline,'LineWidth',1)
ylabel('Time (s)')
xlabel('Voltage')
ylim([-0.05, 0.03])


[data_nic_alc, peakIndex_alc] = findpeaks(voltage_nic_alc,'MinPeakHeight',threshold);
nic_alc_firing = length(data_nic_alc)/20;

Y = [baseline_firing, nicotine_firing, nic_alc_firing];
figure
bar(Y)
ylim([0, 350])
text(1:length(Y),Y,num2str(Y'),'vert','bottom','horiz','center'); 
title('Firing Rate on Pharmacological Treatments')
set(gca,'XTickLabel',{'Baseline','Nicotine', 'Nicotine + Alcohol'});
ylabel('Frequency of spikes (/s)')
xlabel('Treatment')

Y_mean = [mean(data_baseline), mean(data_nicotine), mean(data_nic_alc)];
figure
bar(Y_mean)
ylim([0, 0.007])
text(1:length(Y_mean),Y_mean,num2str(Y_mean'),'vert','bottom','horiz','center'); 
title('Mean Amplitude')
set(gca,'XTickLabel',{'Baseline','Nicotine', 'Nicotine + Alcohol'});
ylabel('Mean Amplitude of spikes (a.u.)')
xlabel('Treatment')


