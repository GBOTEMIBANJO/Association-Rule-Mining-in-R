setwd("C:/Users/oreoluwa/Downloads")
getwd()

#read the csv
retail <- read.csv("Online Retail.csv", header=T)


#view the csv
View(retail)

#select needed columns
retail2 <- subset(retail, select=c("CustomerID", "Description"))
head(retail)
summary(retail)
#install tidyr 
install.packages("tidyr")
library(tidyr)

#using function from tidyr to remove empty rows
retail <- retail %>% drop_na

#save as csv file
write.csv(retail, "retail2.csv")

#install arules package
install.packages("arules")
library(arules)
library(plyr)
#install arulesviz package
install.packages("arulesViz")
library(arulesViz)

retail_trans <- ddply(retail2, c("CustomerID"),
                      function(df1)paste(df1$Description,
                      collapse = ","))
retail_trans$CustomerID <- NULL
write.csv(retail_trans,"/Users/oreoluwa/retailTrans.csv", quote = FALSE, row.names = FALSE)
#reading the table in a transaction format
retail3 <- read.transactions("/Users/oreoluwa/retailTrans.csv", format = "basket", 
                             header = TRUE, sep = ",")
?read.transactions

retail3
summary(retail3)
#top 5 transactions
inspect(head(retail3, 5))

#usage of apriori() function
rules<-apriori(retail3, parameter = list(supp=0.02, conf = 0.98))

?apriori

summary(rules)

inspect(rules)

summary(retail)

unique(retail$Description)

itemFrequencyPlot(retail3,topN=20, type="absolute")




install.packages("dplyr")
library(dplyr)
retail2 %>% count(retail2$Description, sort = TRUE)


