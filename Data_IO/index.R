## ---- echo = FALSE-------------------------------------------------------
library(knitr)
library(readr)
opts_chunk$set(comment = "")

## ----workingDirectory,eval=FALSE-----------------------------------------
## ## get the working directory
## getwd()
## setwd("~/Lectures")

## ----directoryNav--------------------------------------------------------
dir("./") # shows directory contents
dir("..")

## ---- eval = FALSE-------------------------------------------------------
## setwd("~/Lectures/Data_IO/lecture")

## ---- eval = FALSE-------------------------------------------------------
## ?dir
## help("dir")

## ----read_url, message = FALSE-------------------------------------------
mydat = read_csv("http://johnmuschelli.com/intro_to_r/data/Youth_Tobacco_Survey_YTS_Data.csv")
head(mydat)

## ----readCSV-------------------------------------------------------------
read_csv

## ----readCSV2------------------------------------------------------------
dat = read_csv("../data/Youth_Tobacco_Survey_YTS_Data.csv")

## ----readCSV_readr, message=FALSE----------------------------------------
library(readr)
head(dat)
class(dat)

## ---- viewTibble---------------------------------------------------------
dat

## ---- dims---------------------------------------------------------------
dim(dat)
nrow(dat)
ncol(dat)
colnames(dat)

## ----names1, message = FALSE---------------------------------------------
library(dplyr)
dat = rename(dat, year = YEAR)
names(dat)

## ----writecsv,eval=FALSE-------------------------------------------------
## dat = rename(dat, Year = year)
## write_csv(dat, path = "YouthTobacco_newNames.csv")

## ---- message = FALSE----------------------------------------------------
x = 5; # can have semicolons a the end!
# calling read_csv function and pasting a long string together
yts = readr::read_csv(
  paste0("http://johnmuschelli.com/intro_to_r/",
         "data/Youth_Tobacco_Survey_YTS_Data.csv")) 
save(yts, x, file = "yts_data.rda")

## ------------------------------------------------------------------------
ls() # list things in the workspace
rm(list = c("x", "yts"))
ls()
z = load("yts_data.rda")
ls()

## ------------------------------------------------------------------------
print(z)

## ------------------------------------------------------------------------
saveRDS(yts, file = "yts_dataset.rds")

## ------------------------------------------------------------------------
yts2 = readRDS(file = "yts_dataset.rds")
identical(yts, yts2) # test if they are the same 

## ---- readingCSV---------------------------------------------------------
dat2 = read.csv("../data/Youth_Tobacco_Survey_YTS_Data.csv", as.is = TRUE)
head(dat2)

## ---- echo = FALSE, message = FALSE, results='hide'----------------------
file.remove("yts_data.rda") # removing temporary file

