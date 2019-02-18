new.function <- function(data12, Type) 
{
  library(ggplot2)
  #plot(data12$Size, data12$Time)
  mean0 <- mean(data12[data12$Size == 0, ]$Time)
  mean1 <- mean(data12[data12$Size == 1, ]$Time)
  mean2 <- mean(data12[data12$Size == 2, ]$Time)
  
  variance0 <- var(data12[data12$Size == 0, ]$Time)
  variance1 <- var(data12[data12$Size == 1, ]$Time)
  variance2 <- var(data12[data12$Size == 2, ]$Time)
  
  d=data.frame(Density=c("Small", "Medium", "Large"), Response_Time=c(mean0, mean1, mean2), lower=c(mean0 - variance0, mean1 - variance1, mean2 - variance2), upper=c(mean0 + variance0, mean1 + variance1, mean2 + variance2))
  plt = ggplot() + 
    geom_errorbar(data=d, mapping=aes(x=Density, ymin=upper, ymax=lower), width=0.2, size=1, color="blue") + 
    geom_point(data=d, mapping=aes(x=Density, y=Response_Time), size=4, shape=21, fill="white")
  print(plt)
  d0 <- data12[data12$Size == 0, ]$Correct.
  d1 <- data12[data12$Size == 1, ]$Correct.
  d2 <- data12[data12$Size == 2, ]$Correct.
  correct0 <- (length(d0) - sum(d0))/length(d0)
  correct1 <- (length(d1) - sum(d1))/length(d1)
  correct2 <- (length(d2) - sum(d2))/length(d2)
  plot(c(correct0, correct1, correct2), ylim = c(0.75, 1), main = c("Accuracy -",Type), xlabel = "Type", ylabel = "Reaction Time")
  lines(c(correct0, correct1, correct2))
}


setwd("~/Documents/GitHub/UB304L_NeuroLab/")
options(digits=2)
data1 <- read.csv("cherry_picking.csv")
new.function(data1, "All Together")

data2 <- data1[data1$Density == -1,]
new.function(data2, "Negative Angle")

data3 <- data1[data1$Density == 0,]
new.function(data3, "No Angle")

data4 <- data1[data1$Density == 1,]
new.function(data4, "Positive Angle")
