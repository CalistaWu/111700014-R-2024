#install.packages('titanic')
library(ggplot2)
library(titanic)


data(package='titanic')

dim(titanic_train)
names(titanic_train)
head(titanic_train)

head(titanic_train)
ggplot(data = titanic_train, aes(x=Sex, fill=factor(Survived))) + geom_bar(position = "fill")
