#Step 1: cleaning data
names(tdata)
str(tdata)

for

dupes <- tdata %>%  
  get_dupes()  #checking for dupes in data

tdata <- unique(tdata)  >#only unique data

tdata %>% 
  remove_constant()  #checking for constant data, if so remove

tdata[sapply(tdata, is.character)] <- lapply(tdata[sapply(tdata, is.character)], 
                                       as.factor)   #convert all character vars to factors

#checking for worngly imputed values for each variable
unique(tdata$state)
unique(tdata$line)
unique(tdata$workhours1)       
unique(tdata$workhours2)  
unique(tdata$class)  
unique(tdata$age)  
unique(tdata$marriage)  
unique(tdata$race)  #issue, level 5 and 4 do not correspond to any race
unique(tdata$sex)  
unique(tdata$veteran)
unique(tdata$region2)  
unique(tdata$city)  #?? what is balanceofmsa??
unique(tdata$ethnicity)  #don't know ethnicity should be considered as all other then as best proxy so as 
unique(tdata$status_last_week)
unique(tdata$class2)
unique(tdata$paidbyhour)
unique(tdata$income_a)
unique(tdata$income_b)
unique(tdata$income_c)
unique(tdata$income_d)
unique(tdata$union)
unique(tdata$industry)  #issue, it contains random numbers (450, 451, 452, 623, 633, 810), cause if not a secret code for some industry they shouldn't be :)

