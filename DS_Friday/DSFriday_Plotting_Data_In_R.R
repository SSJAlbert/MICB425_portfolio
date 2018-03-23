library("tidyverse")
source("https://bioconductor.org/biocLite.R")
biocLite("phyloseq")
library(phyloseq)
load("phyloseq_object.RData")

read.table(file="Saanich.metadata2.txt")
metadata = read.table(file="Saanich.metadata2.txt", header=TRUE, row.names=1, sep="\t", na.strings=c("NAN","NA","."))


#The base function of any plot from ggplot is unsurprisingly the ggplot function.
#This function takes in the data and basic aesthetics of the plot,
#like the x- and y-axis variables, but does not specify the way
#in which you want to plot the data (like dots, bars, etc.).
#So, if we try to plot depth by oxygen (O2) with just ggplot,
#we get a plot with the correct axes but no actual data.

View(metadata)
ggplot(metadata, aes(x=O2_uM, y=Depth_m))


#Adding data points
ggplot(metadata, aes(x=O2_uM, y=Depth_m)) +
  geom_point()

#Equivalent to above
ggplot(metadata) +
  geom_point(aes(x=O2_uM, y=Depth_m))

#Changing colour, shape, size
ggplot(metadata, aes(x=O2_uM, y=Depth_m, color="blue")) +
  geom_point()

#What happened is geoms cannot get all of their data from the ggplot function.
#Within ggplot, you can specify attributes that are part of the overall plot
#(everything that shows up if you only use ggplot, no geom) but not attributes
#associated with a specific geom. In this case, the dots are there because of
#geom_point so we must change their color within the geom function.
ggplot(metadata, aes(x=O2_uM, y=Depth_m)) +
  geom_point(color="blue")

#Same for size and shape
ggplot(metadata, aes(x=O2_uM, y=Depth_m)) +
  geom_point(shape="square")

ggplot(metadata, aes(x=O2_uM, y=Depth_m)) +
  geom_point(size=10)


#We can also add a third variable to our plot by including it as color,
#shape, or size of dots. This works for both continuous and categorical
#variables.
ggplot(metadata, aes(x=O2_uM, y=Depth_m, size=OxygenSBE_V)) +
  geom_point()

#phyloseq plot functions mirror ggplot like plot_bar = geom_bar. For example,
#we can plot the phylum level communities by depth by simply specifying the fill.

plot_bar(physeq, fill="Phylum")

physeq_percent = transform_sample_counts(physeq, function(x) 100 * x/sum(x))

plot_bar(physeq_percent, fill="Phylum")

plot_bar(physeq_percent, fill="Phylum") + 
  geom_bar(aes(fill=Phylum), stat="identity")

plot_bar(physeq_percent, fill="Phylum") +
  geom_bar(aes(fill=Phylum), stat="identity") +
  facet_wrap(~Phylum)

plot_bar(physeq_percent, fill="Phylum") +
  geom_bar(aes(fill=Phylum), stat="identity") +
  facet_wrap(~Phylum, scales="free_y") +
  theme(legend.position="none")

#Exercise 1
ggplot(metadata, aes(y=Depth_m, x=PO4_uM)) +
  geom_point(shape=17,color="purple",size=2)

#Exercise 2
Temp_f = metadata %>% 
  select(Temperature_C, Depth_m) %>% 
  mutate(Temperature_F = (Temperature_C*(9/5)+32))

ggplot(Temp_f, aes(x=Temperature_F, y=Depth_m)) +
  geom_point(color="blue")

#Exercise 3
load("phyloseq_object.RData")
physeq_percent = transform_sample_counts(physeq, function(x) 100 * x/sum(x))
plot_bar(physeq_percent, fill="Phylum") +
  geom_bar(aes(fill=Phylum), stat="identity") +
  ggtitle("Phyla from 10 to 200 m in Saanich Inlet") +
  xlab("Sample abundance") +
  ylab("Percent relative abundance")

#Exercise 4

uM_nutrients = metadata %>% 
  select(O2_uM, PO4_uM, SiO2_uM, NO3_uM, NH4_uM, NO2_uM, Depth_m)

faceted = gather(uM_nutrients, key = "Nutrient", value = "uM", ends_with("uM"))

ggplot(faceted, aes(x=Depth_m, y=uM))+
  geom_line()+
  geom_point()+
  facet_wrap(~Nutrient, scales="free_y") +
  theme(legend.position="none")

  

