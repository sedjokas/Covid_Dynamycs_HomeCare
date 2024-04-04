# Author: Prof Dr Selain Kasereka
# Purpose: research paper with the title : Dynamics of a Covid-19 Outbreak Model with Hospitalized and Home-care Patients Groups
# Published by: Axioms MDPI 


library(dplyr)
library(readr)
# ALL
datasir<- SituationGenerale <- read.csv("~/Documents/Article Covid Ngoie/SituationGenerale.csv")
g_range <- range(0, datasir[,1])
k<- range(0 ,80)
plot(datasir[,c(1,3)], type="l", col=" orange ", axes=T, ann=T, xlab="Time (Days) ", ylab="E(t), I(t) , H(t) , M(t) , D(t)  and R(t)", ylim=k, , xlim= g_range, lwd=4.0)
#lines(datasir[,c(1,3)], type="l", col=" yellow ", lwd=4.0)
lines(datasir[,c(1,4)], type="l", col="red", lwd=4.0)
lines(datasir[,c(1,5)], type="l", col="brown", lwd=4.0)
lines(datasir[,c(1,6)], type="l", col="magenta", lwd=4.0)
lines(datasir[,c(1,7)], type="l", col=" black ", lwd=4.0)
lines(datasir[,c(1,8)], type="l", col="blue", lwd=4.0)

box()
legend(130,80, c("E(t)", "I(t)" , "H(t)" , "M(t)" , "D(t)" , "R(t)"), cex=.7, 
   col=c("orange", "red", " brown ", "magenta", " black ", "blue"), lty=1, lwd=4.0);

#-----------------

library(dplyr)
library(readr)


# ALL
datasir<- read_excel("Documents/Article Covid Ngoie/R_0_values.xlsx")
g_range <- range(0, datasir[,1])
k<- range(0,5)
plot(datasir[,c(1,2)], type="l", col=" blue ", axes=T, ann=T, xlab="Time (Days) ", ylab="Basic Reproduction Number", ylim=k, , xlim= g_range)
lines(datasir[,c(1,2)], type="l", col=" blue ", lwd=4.0)
#lines(datasir[,c(1,7)], type="l", col="red")
#lines(datasir[,c(1,9)], type="l", col="blue")
#lines(datasir[,c(1,11)], type="l", col="magenta")
#lines(datasir[,c(1,13)], type="l", col="chocolate")
#lines(datasir[,c(1,15)], type="l", col="#77B5FE")

box()
box()
legend(80, 250, c("S(t)", "E(t)", "I(t)" , "H(t)" , "M(t)" , "R(t)" , "D(t)"), cex=0.8, 
   col=c("green", "orange", "red", "blue", "magenta", "chocolate", "#77B5FE"), lty=1);
 
library(dplyr)
library(readr)
# ALL data
datasir01<- read.csv("~/Documents/Article Covid Ngoie/Mort01.csv")
datasir02<- read.csv("~/Documents/Article Covid Ngoie/Mort02.csv")
datasir03<- read.csv("~/Documents/Article Covid Ngoie/Mort02.csv")
datasir04<- read.csv("~/Documents/Article Covid Ngoie/Mort03.csv")
datasir05<- read.csv("~/Documents/Article Covid Ngoie/Mort04.csv")
datasir06<- read.csv("~/Documents/Article Covid Ngoie/Mort04.csv")
datasir07<- read.csv("~/Documents/Article Covid Ngoie/Mort04.csv")
datasir08<- read.csv("~/Documents/Article Covid Ngoie/Mort04.csv")
datasir09<- read.csv("~/Documents/Article Covid Ngoie/Mort04.csv")

g_range <- range(0, datasir01[,1])
k<- range(0 ,150)
plot(datasir01[,c(1,2)], type="b", col=" blue ", pch = 18, axes=T, ann=T, xlab="Time (Days) ", ylab="E(t), I(t) , H(t) , M(t) , D(t)  and R(t)", ylim=k, , xlim= g_range, lwd=4.0)
lines(datasir02[,c(1,2)], type="l", col=" yellow ", lwd=4.0)
lines(datasir03[,c(1,2)], type="l", col="red", lwd=4.0)
lines(datasir04[,c(1,2)], type="l", col="brown", lwd=4.0)
lines(datasir05[,c(1,2)], type="l", col="magenta", lwd=4.0)
lines(datasir06[,c(1,2)], type="l", col=" orange ", lwd=4.0)
lines(datasir07[,c(1,2)], type="l", col="chocolate", lwd=4.0)
lines(datasir08[,c(1,2)], type="l", col="gray", lwd=4.0)
lines(datasir09[,c(1,2)], type="b", col="green", pch = 18,  lwd=4.0)

box()
legend(1,130, c("E(t)", "I(t)" , "H(t)" , "M(t)" , "D(t)" , "R(t)"), cex=.7, 
   col=c("blue", "yellow", " red ", "brown", " magenta ", " orange ", " chocolate ", " gray ", " green "), lty=1, lwd=4.0);

#-----------------

