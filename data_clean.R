#Step 1: cleaning data
names(tdata)
str(tdata)
summary(tdata)

dupes <- tdata %>% get_dupes()  #checking for dupes in data
tdata <- unique(tdata) #only unique data
tdata %>% remove_constant()  #checking for constant data, if so remove
tdata[sapply(tdata, is.character)] <- lapply(tdata[sapply(tdata, is.character)], as.factor)   #convert all character vars to factors

#checking for worngly imputed values for each variable
unique(tdata$state)
unique(tdata$line)
unique(tdata$workhours1)       
unique(tdata$workhours2)  
unique(tdata$class)  
unique(tdata$age)  
unique(tdata$marriage)  
unique(tdata$race)  #issue 1, level 5 and 4 do not correspond to any race so considered as other
unique(tdata$sex)  
unique(tdata$veteran)
unique(tdata$region2)  
unique(tdata$city)  
unique(tdata$ethnicity)  #issue 2, don't know ethnicity should be considered as all other then as best proxy so as 
unique(tdata$status_last_week)
unique(tdata$class2)
unique(tdata$paidbyhour)
unique(tdata$income_a)  #issue3
unique(tdata$income_b)  #issue3
unique(tdata$income_c)  #issue3
unique(tdata$income_d)  #issue3
unique(tdata$union)
unique(tdata$industry)  #issue 4, it contains random numbers (450, 451, 452, 623, 633, 810), cause if not a secret code for some industry they shouldn't be :)
unique(tdata$children)
unique(tdata$child_info)  #issue 5
unique(tdata$family_reference)  #issue 6, entries like 7, 8
unique(tdata$family_relation)
unique(tdata$occupation)
unique(tdata$education)

#...Solving Issues...#
#....................#
#for those variables which have wrong entries and no proxy can be found, we eliminated those rows from the dataset
#1
tdata$race[tdata$race %in% c("4", "5")] <- "Other" #reclassifying incorrect values 

#2
plot(tdata$ethnicity, las=2, ylim = c(0,25000), cex.names=.4)
text(x = 1:9, y = table(tdata$ethnicity), labels = table(tdata$ethnicity), pos = 3, cex = 0.8) 
#as we can see most are all other ethnicities.. is this even relevant var then? maybe we can deselect it from dataset. but for now we assume don't know = all other
tdata$ethnicity[tdata$ethnicity %in% "DontKnow"] <- "AllOther"

#3
#each column of income_X includes one or more numbers which seem quite random, in other words seem incorrect. Instead of cleaning this we simply remove the four cols 
#corresponding to income_a, income_b, income_c, income_d as they have no value variance!
tdata <-  tdata %>% 
  dplyr::select(-c("income_a", "income_b", "income_c", "income_d"))

#4
boxplot(tdata$industry, cex.names=0.5, las=2, col = "Pink", ylim=c(0, 150)) # around 50 the median obs of a certain industry - nearly symmetric data, no outliers
#randomly classify them as another industry
class_ind <- unique(tdata$industry[!tdata$industry %in% c("450", "451", "452", "623", "633", "810")])  #Get all unique values of the column excluding the incorrect values
tdata$industry[tdata$industry %in% c("450", "451", "452", "623", "633", "810")] <- sample(class_ind, sum(tdata$industry %in% c("450", "451", "452", "623", "633", "810")), replace = TRUE)

#5
#this variable it's a mess in terms of input variables, inputs as children1417
plot(tdata$child_info, las=2, cex.names=0.6)
#delete this col
tdata <- tdata %>% 
  dplyr::select(-"child_info")


#6
plot(tdata$family_reference, cex.names = 0.6, las=2)
#randomly classify as another family reference
class_famref <- unique(tdata$family_reference[!tdata$family_reference %in% c("7", "8")])
tdata$family_reference[tdata$family_reference %in% c("7", "8")] <- sample(class_famref, sum(tdata$family_reference %in% c("7", "8")), replace = TRUE)


#7
#there exists two variables with essentially the same name workinghours1 and 2. check if they are the same -- redundancy!
id <- identical(tdata$workhours1, tdata$workhours2)
summary(tdata$workhours1)
summary(tdata$workhours2)
#they seem different but so similar
not_equal_indices <- ((which(tdata$workhours1 != tdata$workhours2))) # many values differ so we keep both columns


