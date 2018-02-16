#Comments
install.packages("tidyverse")
library(tidyverse)

#Copy file via terminal
cp ~/Documents/MICB425_materials/filename ~/Documents/MICB425_portfolio/filenewname

#Only for materials repo (will delete your portfolio work otherwise)
git reset --hard origin/master

#Load data
read.table(file="Saanich.metadata.txt")
metadata = read.table(file="Saanich.metadata.txt", header=TRUE, row.names=1, sep="\t", na.strings=c("NAN","NA","."))
View(metadata)

OTU = read.table(file="Saanich.OTU.txt", header=TRUE, row.names=1, sep="\t", na.strings=c("NAN","NA","."))
# View(OTU)  <-- Don't; will lag/freeze

#These two are equivalent (shows O2 uM column)
select(metadata, O2_uM)

metadata %>%
  select(O2_uM)


#Selects everything that has O2|oxygen if you didn't know column name
metadata %>% 
  select(matches("O2|oxygen"))

#can also generalize using logical phrases such as starts_with, ends_with, or contains.


#Select rows:
metadata %>% 
  filter(O2_uM == 0)


#Combining the two
metadata %>% 
  filter(O2_uM == 0) %>% 
  select(Depth_m)

#In base R:
# metadata[metadata$O2_uM == 0, "Depth_m"]

# Find at what depth(s) methane (CH4) is above 100 nM while temperature is below 10 °C
# Generate a table showing these values
View (metadata %>% 
      filter(CH4_nM > 100 & Temperature_C < 10) %>% 
      select(Depth_m, CH4_nM, Temperature_C))

#Generate new variable for values of N2O in uM
metadata %>% 
  mutate(N2O_uM = N2O_nM/1000)

#mutate keeps all of the data in addition to the new variable.
#If we only want to keep our newly calculated variable, we use  transmute instead.

metadata %>% 
  transmute(N2O_uM = N2O_nM/1000)

#Would overwrite the old data if named the same name (though your data table
# is unchanged)
metadata %>% 
  transmute(N2O_nM = N2O_nM/1000)


#Plotting
metadata %>% 
  mutate(N2O_uM = N2O_nM/1000) %>% 
  ggplot() + geom_point(aes(x=Depth_m, y=N2O_uM))

#Convert all variables that are in nM to μμM.
#Output a table showing only the original nM and converted μμM variables

View(metadata %>% 
      mutate(N2O_uM = N2O_nM/1000, Std_N2O_uM = Std_N2O_nM/1000, CH4_uM = CH4_nM/1000,
         Std_CH4_uM = CH4_nM/1000) %>% 
      select(N2O_nM, Std_N2O_uM, Std_N2O_nM, CH4_uM, CH4_nM,
         Std_CH4_uM, CH4_nM))

#DAY 2
library(tidyverse)
data %>% function
function(data)

metadata %>% 
  select(O2_uM)

#Select variables with O2 or oxygen in the name 
metadata %>% 
  select(matches("O2|oxygen"))

#Filter rows (samples) where oxygen = 0
metadata %>% 
  filter(O2_uM == 0)

#Select depths where oxygen = 0
metadata %>% 
  filter(O2_uM == 0)
  select(Depth_m)
  
#Same code without knowing name of columns
metadata %>% 
  select(matches("CH4|methane"))
metadata %>% 
  select(matches("temp"))

#Exclude units from cells or they will be treated as words -> Will not be able
# to take the average/do mathematical operations on them

#Having each function on separate line makes it more readable
#Note: "_" and "&" have the same function
metadata %>% 
  filter(CH4_nM > 100) %>% 
  filter(Temperature_C < 10) %>% 
  select(Depth_m, CH4_nM, Temperature_C)
