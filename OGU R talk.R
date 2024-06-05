# Clear the global environment
rm(list = ls())

# Set working directory
setwd("~/For Thesis/Chapter 3/Data/Chromatograms/")

# List files in folder
list.files(path = ".", pattern = ".csv")

# Upload data
dframe1 <- read.csv("001106bp_142+141+115.csv", skip = 3)  

# Remove excess data
dframe1 <- subset(dframe1, Time > 5 & Time < 60)

# Check data 
head(dframe1)
summary(dframe1)

# Find max values
max1 <- max(dframe1$Intensity)

# Format data
dframe1$RA <- dframe1$Intensity/max1*100

# Provide axis labels
xlab <- c(5, rep(" ",4), 10, rep(" ",4), 15, rep(" ",4), 20, rep(" ",4), 25, rep(" ",4), 30, rep(" ",4), 35, rep(" ",4), 40, rep(" ",4), 45, rep(" ",4), 50, rep(" ",4), 55, rep(" ",4), 60)
ylab <- c(0, rep(" ",4), 20, rep(" ",4), 40, rep(" ",4), 60, rep(" ",4), 80, rep(" ",4), 100)

# Set up ggplot
library(ggplot2)
theme_set(theme_classic())

# Plot chromatogram
# Data
ggplot(data = dframe1, aes(x = Time, y = RA)) +
  # Line style
  geom_line(color = "#4B03A1", linewidth = 0.5) +
  # Format x axis
  scale_x_continuous("Time / min", breaks = seq(5, 60, 1), labels = xlab,
                     limits = c(5, 60), expand = c(0,0)) +
  # Format y axis
  scale_y_continuous("Relative abundance", breaks = seq(0, 100, 4),
                     labels = ylab, limits = c(0, 100), expand = c(0,0)) +
  # Increase space around axis titles
  theme(axis.title.y = element_text(margin = margin(0,10,0,0)),
        axis.title.x = element_text(margin = margin(10,0,0,0)),
        # Increase space around plot
        plot.margin=unit(c(1,1,0.7,0.7),"cm"),
        # Format axis label text
        axis.text.y = element_text(size = 10, margin = margin(0,5,0,0),
                                   color = "black"),
        axis.text.x = element_text(size = 10, margin = margin(5,0,0,0),
                                   color = "black"),
        # Remove plot labels
        strip.background = element_blank(), strip.text.y = element_blank())

# Save plot
ggsave("001106bp_142+141+115.png", plot = last_plot(), width = 10, height = 4, dpi = 300)
