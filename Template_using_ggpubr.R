##########################################################
# Creating the infographics template using ggpubr
# Original author(s): Tina Fu
# Original date: 03/09/2019
# Type of script: creating graphics
# Written/run on: RStudio desktop
# Version of R that the script was most recently run on: R 3.5.2
# Description of content: this script is to show an alternative way to create
# the infographics template using ggpubr package. 
# The advantage of doing it is no HTML code are needed. 
# Also no need to set parameters for spaces and paddings.
# Approximate run time: 10 seconds.
##########################################################

### 1 - Housekeeping ----
library(ggplot2)
library(ggpubr)

### 2 - Creating some sample pie charts ----

# Create a sample data
df <- data.frame(
  group = c("Yes", "No"),
  value = c(25, 75)
)

# Create a sample barplot and transform it into a donut pie chart
bp <- ggplot(df, aes(x="", y=value, fill=group)) +
  geom_bar(width = .35, stat = "identity", fill = c('red','orange'))

# Remove the 'x' and 'value' labels for the x and y axes respectively.
bp <- bp + labs(x = "", y = "")  

# Change the barplot into a donut plot.
pie <- bp +
  coord_polar("y", start=0*pi/(180)) +  
  annotate("text", x = 0, y = 0, label = "25%", size = 10, col = 'orange')

# Get rid of the x-axis labels and the single x-axis tick.
pie <- pie + theme(panel.background = ggplot2::element_blank(),
                   axis.text.x = ggplot2::element_blank(),  
                   axis.ticks=element_blank()
)

# Add the annotation next to the plot.
pie1 <- annotate_figure(pie, 
                        right = text_grob("The cost per \n treated patient for drugs used \n in diabetes (BNF 6.1) \n in 2017/18 was £xx", 
                                          color = "black", size = 12), 
                        top = text_grob("GP Cluster List Size \n Total Lise Size: XX, XXX", 
                                        color = "black", size = 13))

# Create another 3 sample charts with different annotations.

# pie2
pie2 <- pie + theme(panel.background = ggplot2::element_blank(),
                    axis.text.x = ggplot2::element_blank(),  
                    axis.ticks=element_blank()
)

pie2 <- annotate_figure(pie2, 
                        right = text_grob("x% of the list \n size live in the \n 2 most \n deprived SIMD quintiles", 
                                          color = "black", size = 12), 
                        top = text_grob("Disease Registers", 
                                        color = "black", size = 13))

# pie3
pie3 <- pie + theme(panel.background = ggplot2::element_blank(),
                    axis.text.x = ggplot2::element_blank(),  
                    axis.ticks=element_blank()
)

pie3 <- annotate_figure(pie3, right = text_grob("x% of the list \n size live in the \n 2 most \n deprived SIMD quintiles", 
                                                color = "black", size = 12))

# pie4
pie4 <- pie + theme(panel.background = ggplot2::element_blank(),
                    axis.text.x = ggplot2::element_blank(),  
                    axis.ticks=element_blank()
)

pie4 <- annotate_figure(pie4, right = text_grob("The A&E attendance rate \n in 2017/18 was \n xx per 1,000 population \n (xx rate for cluster)", 
                                                color = "black", size = 12))

### 3 - Create grid template ----
figure <- ggarrange(pie1, pie2, pie3, pie4, ncol = 2, nrow = 2, 
                    heights = c(0.5, 0.5), align = "v")

# Add the annotation on the top
figure <- annotate_figure(figure, 
                          top = text_grob("XXXXX GP Cluster \n At a Glance \n", 
                                          face = "bold", color = "black", 
                                          size = 15))
# View the final output
figure

# Please note: 
# The alignment of charts can be affected due to the length of text on the right.
# No solution has been found yet for fixing the potential alignment problem.
# You can save the final output by clicking on Export -> Save as PDF.
# Choose "Landscape" for orientation and give it a file name.

### END OF SCRIPT ###