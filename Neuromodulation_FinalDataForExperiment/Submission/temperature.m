load('Temperature/cold.mat')
load('Temperature/cold_baseline.mat')

threshold = 0.006;

[voltage_bl, time_bl] = get_voltage(data_cold_bl, fs_cold_bl, 10, 30);
figure
plot(time_bl, voltage_bl)
title('Raw Plot for baseline')
xlabel('Time (s)')
ylabel('Potential (a.u.)')
hline = refline([0 threshold]);
hline.Color = 'red';
set(hline,'LineWidth',1)
ylim([-0.05, 0.04])

[voltage, time] = get_voltage(data_cold, fs_cold, 10, 30);
figure
plot(time, voltage)
title('Raw Plot for Cold Treatment')
xlabel('Time (s)')
ylabel('Potential (a.u.)')
hline = refline([0 threshold]);
hline.Color = 'red';
set(hline,'LineWidth',1)
ylim([-0.05, 0.04])


[data_baseline, peakIndex_base] = findpeaks(voltage_bl,'MinPeakHeight'...
    ,threshold);
baseline_firing = length(data_baseline)/10;

[data, peakIndex] = findpeaks(voltage,'MinPeakHeight',threshold);
treatment_firing = length(data)/10;

Y = [baseline_firing, treatment_firing];
figure
bar(Y)
ylim([0, 250])
text(1:length(Y),Y,num2str(Y'),'vert','bottom','horiz','center'); 
title('Firing Rate Reduces as temperature decreases')
set(gca,'XTickLabel',{'Room Temperature','Cold Treatment'});
ylabel('Average frequency of spikes (/s)')
xlabel('Treatment')

Y_mean = [mean(data_baseline), mean(data)];
figure
bar(Y_mean)
ylim([0, 0.015])
text(1:length(Y_mean),Y_mean,num2str(Y_mean'),'vert','bottom','horiz','center'); 
title('Mean Amplitude of Spikes')
set(gca,'XTickLabel',{'Room Temperature','Cold Treatment'});
ylabel('Mean Amplitude of spikes (a.u.)')
xlabel('Treatment')

% Action Potentials
ap = datasample(peakIndex_base, 1);
figure
plot(voltage_bl(ap - 80: ap + 80))
title('Shape of an Action Potential')
xlabel('Time (a.u.)')
ylabel('Potential (a.u.)')
figure
plot(-1*voltage_bl(ap - 80: ap + 80))
title('Shape of an Action Potential in Raw Data')
xlabel('Time (a.u.)')
ylabel('Potential (a.u.)')

ap = datasample(peakIndex, 1);
figure
plot(voltage(ap - 80: ap + 80))