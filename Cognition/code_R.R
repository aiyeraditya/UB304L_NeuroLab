setwd("~/Documents/GitHub/UB304L_NeuroLab/")
options(digits=2)
data <- read.csv("cherry_picking.csv")
plot(data$Size, data$Time, col = data$Density + 2)


density_low <- data[(data$Size == 0),]
density_medium <- data[(data$Size == 1),]
density_high <- data[(data$Size == 2),]
boxplot(density_low$Time, density_medium$Time, density_high$Time, names = c("Small", "Medium", "Large"), main = "All")
time_all = c(density_low$Time, density_medium$Time, density_high$Time)

incorrect_all_low = sum(density_low$Correct.)
total_all_low = length(density_low$Correct.)
correct_all_low = total_all_low - incorrect_all_low
per_low = correct_all_low/total_all_low

incorrect_all_medium = sum(density_medium$Correct.)
total_all_medium = length(density_medium$Correct.)
correct_all_medium = total_all_medium - incorrect_all_medium
per_medium = correct_all_medium/total_all_medium

incorrect_all_high = sum(density_high$Correct.)
total_all_high = length(density_high$Correct.)
correct_all_high = total_all_high - incorrect_all_high
per_high = correct_all_high/total_all_high


plot(data$Size, data$Correct.)
lines(c(0, 1, 2), c(per_low, per_medium, per_high))
barplot(c(per_low, per_medium, per_high))
all = c(per_low, per_medium, per_high)
time_all = c(density_low$Time, density_medium$Time, density_high$Time)

data_present_angle1 <- data[(data$Density == -1),]
density_low <- data_present_angle1[(data_present_angle1$Size == 0),]
density_medium <- data_present_angle1[(data_present_angle1$Size == 1),]
density_high <- data_present_angle1[(data_present_angle1$Size == 2),]

boxplot(density_low$Time, density_medium$Time, density_high$Time, names = c("Small", "Medium", "Large"), main = "-10*")
incorrect_all_low = sum(density_low$Correct.)
total_all_low = length(density_low$Correct.)
correct_all_low = total_all_low - incorrect_all_low
per_low = correct_all_low/total_all_low

incorrect_all_medium = sum(density_medium$Correct.)
total_all_medium = length(density_medium$Correct.)
correct_all_medium = total_all_medium - incorrect_all_medium
per_medium = correct_all_medium/total_all_medium

incorrect_all_high = sum(density_high$Correct.)
total_all_high = length(density_high$Correct.)
correct_all_high = total_all_high - incorrect_all_high
per_high = correct_all_high/total_all_high


plot(data$Size, data$Correct.)
lines(c(0, 1, 2), c(per_low, per_medium, per_high))
barplot(c(per_low, per_medium, per_high))
negative = c(per_low, per_medium, per_high)
time_negative = c(density_low$Time, density_medium$Time, density_high$Time)

data_present_angle2 <- data[(data$Density == 1),]
density_low <- data_present_angle2[(data_present_angle2$Size == 0),]
density_medium <- data_present_angle2[(data_present_angle2$Size == 1),]
density_high <- data_present_angle2[(data_present_angle2$Size == 2),]

boxplot(density_low$Time, density_medium$Time, density_high$Time, names = c("Small", "Medium", "Large"), main = "+10*")
incorrect_all_low = sum(density_low$Correct.)
total_all_low = length(density_low$Correct.)
correct_all_low = total_all_low - incorrect_all_low
per_low = correct_all_low/total_all_low

incorrect_all_medium = sum(density_medium$Correct.)
total_all_medium = length(density_medium$Correct.)
correct_all_medium = total_all_medium - incorrect_all_medium
per_medium = correct_all_medium/total_all_medium

incorrect_all_high = sum(density_high$Correct.)
total_all_high = length(density_high$Correct.)
correct_all_high = total_all_high - incorrect_all_high
per_high = correct_all_high/total_all_high


plot(data$Size, data$Correct.)
lines(c(0, 1, 2), c(per_low, per_medium, per_high))
barplot(c(per_low, per_medium, per_high))
positive = c(per_low, per_medium, per_high)
time_positive= c(density_low$Time, density_medium$Time, density_high$Time)


data_absent <- data[(data$Density == 0),]
density_low <- data_absent[(data_absent$Size == 0),]
density_medium <- data_absent[(data_absent$Size == 1),]
density_high <- data_absent[(data_absent$Size == 2),]
boxplot(density_low$Time, density_medium$Time, density_high$Time, names = c("Small", "Medium", "Large"), main = "+0*")
incorrect_all_low = sum(density_low$Correct.)
total_all_low = length(density_low$Correct.)
correct_all_low = total_all_low - incorrect_all_low
per_low = correct_all_low/total_all_low

incorrect_all_medium = sum(density_medium$Correct.)
total_all_medium = length(density_medium$Correct.)
correct_all_medium = total_all_medium - incorrect_all_medium
per_medium = correct_all_medium/total_all_medium

incorrect_all_high = sum(density_high$Correct.)
total_all_high = length(density_high$Correct.)
correct_all_high = total_all_high - incorrect_all_high
per_high = correct_all_high/total_all_high


plot(data$Size, data$Correct.)
lines(c(0, 1, 2), c(per_low, per_medium, per_high))
barplot(c(per_low, per_medium, per_high))
zero = c(per_low, per_medium, per_high)
time_zero = c(density_low$Time, density_medium$Time, density_high$Time)
# Count The Number of Correct in each of these
# Plot histogram of time
barpdata <- c(positive, zero, negative)
barpdata <- c(all[1], positive[1], zero[1], negative[1], 0, all[2], positive[2], zero[2], negative[2], 0, all[3], positive[3], zero[3], negative[3])
xx<- barplot(barpdata, col=c(1,1,1,1,1,2,2,2,2,2,3,3,3,3), names = c("All", "Positive", "Zero", "Negative", "None", "All", "Positive", "Zero", "Negative", "None", "All", "Positive", "Zero", "Negative"), las=2, ylim = c(0,1))
text(x = xx, y = barpdata, label = sprintf("%0.2f", round(barpdata, digits = 2)) , pos = 3, cex = 0.8, col = "black")

bartdata <- c(time_all[1:42], time_positive[1:42], time_zero[1:42], time_negative[1:42], 0, time_all[43:84], time_positive[43:84], time_zero[43:84], time_negative[43:84], 0, time_all[85:126], time_positive[85:126], time_zero[85:126], time_negative[85:126])
#xx<- barplot(bartdata, col=c(1,1,1,1,1,2,2,2,2,2,3,3,3,3), names = c("All", "Positive", "Zero", "Negative", "None", "All", "Positive", "Zero", "Negative", "None", "All", "Positive", "Zero", "Negative"), las=2, ylim = c(0,2.5))
#text(x = xx, y = barpdata, label = sprintf("%0.2f", round(barpdata, digits = 2)) , pos = 3, cex = 0.8, col = "black")


# Time1 : Time Taken For Correct
correct <- data[(data$Correct == 0),]
incorrect <- data[(data$Correct == 1),]
boxplot(data[data$Correct. == 0, ]$Time, data[data$Correct. == 1, ]$Time, names = c("Correct", "Incorrect"))



# Read Number Correct For Each Type
