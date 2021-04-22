################ Q1

#Read the dataset into a data frame called london_crime. 

london_crime <- read.csv("london-crime-data.csv", na="")

# Then show the structure of the dataset.

str(london_crime)

# Date field using Paste
# Create a new variable called Date that contains the month 
# and year data
london_crime$Date <- paste(london_crime$month, london_crime$year, sep='/')
str(london_crime)

# Add day element into the variable
new_date <- paste("01", london_crime$month, london_crime$year, sep = "/")
new_date
# convert into date variable
london_crime$Date <- as.Date(new_date, "%d/%m/%Y")
str(london_crime)

################ Q2

# We want to retain only the variables shown in this table, and we wish to convert the 
# variable names to that shown in the table.

include_list <- names(london_crime) %in% c("borough", "major_category","minor_category", "value", "Date") 

# will search header and TRUE means columns exists
include_list

# this data frame only contains "borough", "major_category","minor_category", "value", "Date"
new_london_crime <- london_crime[(include_list)]
new_london_crime
str(new_london_crime)

column_names <- c("Borough", 
                  "MajorCategory", 
                  "SubCategory", 
                  "Value", 
                  "CrimeDate")

# Add column names to the new_london_crime dataframe
colnames(new_london_crime) <- column_names
names(new_london_crime)


################### Q3

# Convert the CrimeDate variable so that it is a variable of type Date. Confirm that the 
# variable has been changed to the required variable type by 
# showing the structure and content of the date variable

new_london_crime$CrimeDate <- as.Date(new_london_crime$CrimeDate, "%m/%d/%y")
# structure
str(new_london_crime$CrimeDate)
# content
summary(new_london_crime$CrimeDate)

################### Q4

# Plot a chart to show the summary of the borough information so that we can view 
# where most crimes occur.

plot(new_london_crime$Borough)
new_london_crime$Borough <- factor(new_london_crime$Borough)

str(new_london_crime)
plot(new_london_crime$Borough)
summary(new_london_crime$Borough)

# Add titles to the chart 
attach(new_london_crime)
display_settings <- par(no.readonly = TRUE)
plot(Borough, main = "London Crime Details", xlab = "Location", ylab = "Crime Counts")

graph_range <- range(0, Borough)
graph_range

# Complete example of creating a line chart including axes and labels
plot(Borough, 
     col = "red", 
     main = "London Crime Details",
     sub = "This is London Crime data",
     xlab = "Location", ylab = "Crime Counts",
     ylim = graph_range)

# Add a comment in your code to show which borough has the highest level of 
# crime.
plot.new()
most_crime <- table(new_london_crime$Borough)
most_crime
barplot(most_crime, main = "London Crime Details", xlab
        = "Location", ylab = "Crime Counts")
# Croydon has highest crime

# And add a comment in your code to indicate which area has the lowest level of 
# crime.

# City of London has lowest crime

detach(new_london_crime)


################# Q5

majorcategory <- summary(new_london_crime$MajorCategory)

# Plot Pie
pie(majorcategory, clockwise = TRUE, Main="Crime By Major Category")

# Add a comment in your code to indicate which major category had the highest level of crimes. 

# Theft and Handling had highest level of crime

#Add a comment in your code to indicate which category had the lowest level of crimes

# Sexual Offences had the lowest level of crime


#################### 6

new_london_crime$Region[Borough == "Kingston upon Thames" | Borough == "Newham" | Borough == "Barking and Dagenham" | Borough == "Bexley" | Borough == "Greenwich" | Borough == "Havering"| Borough == "Redbridge" | Borough == "Wandsworth" ] <- "East"
new_london_crime$Region[Borough == "Barnet" | Borough == "Enfield" | Borough == "Hackney" | Borough == "Haringey" ] <- "North"
new_london_crime$Region[Borough == "Brent" | Borough == "Ealing" | Borough == "Hammersmith and Fulham" | Borough == "Harrow" | Borough == "Hillingdon" | Borough == "Hounslow" | Borough == "Richmond upon Thames"] <- "West"
new_london_crime$Region[Borough == "Bromley" | Borough == "Croydon" | Borough == "Merton" | Borough == "Sutton" ] <- "South"
new_london_crime$Region[Borough == "Islington" | Borough == "Kensington and Chelsea" | Borough == "Lambeth" | Borough == "Lewisham" | Borough == "Southwark" | Borough == "Waltham Forest" | Borough == "Tower Hamlets" | Borough == "Westminster" ] <- "Central"

which(new_london_crime$MajorCategory == NA)
new_london_crime$Region[Borough == "City of London"] <- "Central"

new_london_crime$Region

# Q10
# Using the write.csv() command, save the modified new_london_crime data frame as 
# london-crime-modified.csv.


write.csv(new_london_crime, file = "london-crime-modified.csv")
