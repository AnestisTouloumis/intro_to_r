## ---- echo = FALSE, message = FALSE--------------------------------------
library(knitr)
opts_chunk$set(comment = "")
library(readr)
suppressPackageStartupMessages(library(dplyr))
library(tidyverse)

## ------------------------------------------------------------------------
x = c(0, NA, 2, 3, 4, -0.5, 0.2)
x > 2

## ------------------------------------------------------------------------
x != NA
x > 2 & !is.na(x)

## ------------------------------------------------------------------------
(x == 0 | x == 2) # has NA
(x == 0 | x == 2) & !is.na(x) # No NA

## ------------------------------------------------------------------------
df = data_frame(x = x)
df %>% filter(x > 2)
filter(df, between(x, -1, 3) | is.na(x))

## ------------------------------------------------------------------------
x %in% c(0, 2, NA) # NEVER has NA and returns logical
x %in% c(0, 2) | is.na(x)

## ------------------------------------------------------------------------
x + 2
x * 2

## ----table---------------------------------------------------------------
unique(x)
table(x)
table(x, useNA = "ifany") # will not 

## ----onetab_ifany--------------------------------------------------------
table(c(0, 1, 2, 3, 2, 3, 3, 2,2, 3), 
        useNA = "ifany")

## ----onetab--------------------------------------------------------------
table(c(0, 1, 2, 3, 2, 3, 3, 2,2, 3), 
        useNA = "always")

## ----onetab_fact---------------------------------------------------------
fac = factor(c(0, 1, 2, 3, 2, 3, 3, 2,2, 3),
             levels = 1:4)
tab = table(fac)
tab
tab[ tab > 0 ]

## ------------------------------------------------------------------------
tab <- table(c(0, 1, 2, 3, 2, 3, 3, 2,2, 3), 
             c(0, 1, 2, 3, 2, 3, 3, 4, 4, 3), 
              useNA = "always")
tab

## ----margin--------------------------------------------------------------
margin.table(tab, 2)

## ----table2--------------------------------------------------------------
prop.table(tab)
prop.table(tab,1) * 100

## ----readSal, echo = TRUE, eval = FALSE----------------------------------
## Sal = read_csv("http://data.baltimorecity.gov/api/views/nsfe-bg53/rows.csv")
## Sal = rename(Sal, Name = name)

## ----readSal_csv, echo= FALSE, eval = TRUE-------------------------------
Sal = read.csv("http://data.baltimorecity.gov/api/views/nsfe-bg53/rows.csv")
Sal = rename(Sal, Name = name)

## ----isna----------------------------------------------------------------
head(Sal,2)
any(is.na(Sal$Name)) # are there any NAs?

## ---- eval = FALSE-------------------------------------------------------
## data = data %>%
##   mutate(gender = recode(gender, M = "Male", m = "Male", M = "Male"))

## ---- eval = FALSE-------------------------------------------------------
## data %>%
##   mutate(gender = ifelse(gender %in% c("Male", "M", "m"),
##                          "Male", gender))

## ----gender, echo=FALSE--------------------------------------------------
set.seed(4) # random sample below - make sure same every time
gender <- sample(c("Male", "mAle", "MaLe", "M", "MALE", "Ma", "FeMAle", "F", "Woman", "Man", "Fm", "FEMALE"), 1000, replace = TRUE)

## ----gentab--------------------------------------------------------------
table(gender)

## ----gender2, echo=FALSE-------------------------------------------------
gender = gender %>% 
  tolower %>% 
  recode(m = "Male", f = "Female", ma = "Male",
         woman = "Female", man = "Male")

## ----gentab2-------------------------------------------------------------
table(gender)

## ----str_split_orig------------------------------------------------------
library(stringr)
x <- c("I really", "like writing", "R code programs")
y <- str_split(x, " ") # returns a list
y

## ------------------------------------------------------------------------
str_split("I.like.strings", ".")
str_split("I.like.strings", fixed("."))

## ----stsplit2------------------------------------------------------------
y[[2]]
sapply(y, dplyr::first) # on the fly
sapply(y, nth, 2) # on the fly
sapply(y, last) # on the fly

## ----separate_df---------------------------------------------------------
df = data_frame(x = c("I really", "like writing", "R code programs"))

## ------------------------------------------------------------------------
df %>% separate(x, into = c("first", "second", "third"))

## ------------------------------------------------------------------------
df %>% separate(x, into = c("first", "second"))

## ----RawlMatch_log-------------------------------------------------------
head(str_detect(Sal$Name, "Rawlings"))

## ----RawlMatch-----------------------------------------------------------
which(str_detect(Sal$Name, "Rawlings"))

## ----ggrep2--------------------------------------------------------------
ss = str_extract(Sal$Name, "Rawling")
head(ss)
ss[ !is.na(ss)]

## ----ggrep---------------------------------------------------------------
str_subset(Sal$Name, "Rawlings")
Sal %>% filter(str_detect(Name, "Rawlings"))

## ----grepstar_stringr----------------------------------------------------
head(str_subset( Sal$Name, "^Payne.*"), 3)

## ----grepstar2_stringr---------------------------------------------------
head(str_subset( Sal$Name, "Leonard.?S"))
head(str_subset( Sal$Name, "Spence.*C.*"))

## ------------------------------------------------------------------------
head(str_extract(Sal$AgencyID, "\\d"))
head(str_extract_all(Sal$AgencyID, "\\d"), 2)

## ------------------------------------------------------------------------
head(str_replace(Sal$Name, "a", "j"))
head(str_replace_all(Sal$Name, "a", "j"), 2)

## ----classSal------------------------------------------------------------
class(Sal$AnnualSalary)

## ----destringSal---------------------------------------------------------
head(Sal$AnnualSalary, 4)
head(as.numeric(Sal$AnnualSalary), 4)

## ----orderSal------------------------------------------------------------
Sal = Sal %>% mutate(
  AnnualSalary = str_replace(AnnualSalary, fixed("$"), ""),
  AnnualSalary = as.numeric(AnnualSalary)
  ) %>% 
  arrange(desc(AnnualSalary))

## ----Paste---------------------------------------------------------------
paste("Visit", 1:5, sep = "_")
paste("Visit", 1:5, sep = "_", collapse = " ")
paste("To", "is going be the ", "we go to the store!", sep = "day ")
# and paste0 can be even simpler see ?paste0 
paste0("Visit",1:5)

## ----unite_df------------------------------------------------------------
df = data_frame(id = rep(1:5, 3), visit = rep(1:3, each = 5))

## ------------------------------------------------------------------------
df %>% unite(col = "unique_id", id, visit, sep = "_")

## ------------------------------------------------------------------------
df %>% unite(col = "unique_id", id, visit, sep = "_", remove = FALSE)

## ----Paste2--------------------------------------------------------------
paste(1:5)
paste(1:5, collapse = " ")

## ----orderrank-----------------------------------------------------------
sort(c("1", "2", "10")) #  not sort correctly (order simply ranks the data)
order(c("1", "2", "10"))
x = rnorm(10)
x[1] = x[2] # create a tie
rank(x)

## ------------------------------------------------------------------------
x <- c("I really", "like writing", "R code programs")
y <- strsplit(x, split = " ") # returns a list
y

## ------------------------------------------------------------------------
head(str_extract(Sal$AgencyID, "\\d"))
head(str_extract_all(Sal$AgencyID, "\\d"), 2)

## ------------------------------------------------------------------------
grep("Rawlings",Sal$Name)
which(grepl("Rawlings", Sal$Name))
which(str_detect(Sal$Name, "Rawlings"))

## ------------------------------------------------------------------------
head(grepl("Rawlings",Sal$Name))
head(str_detect(Sal$Name, "Rawlings"))

## ------------------------------------------------------------------------
grep("Rawlings",Sal$Name,value=TRUE)
Sal[grep("Rawlings",Sal$Name),]

## ------------------------------------------------------------------------
ss = str_extract(Sal$Name, "Rawling")
head(ss)
ss[ !is.na(ss)]

## ------------------------------------------------------------------------
head(str_extract(Sal$AgencyID, "\\d"))
head(str_extract_all(Sal$AgencyID, "\\d"), 2)

## ------------------------------------------------------------------------
head(grep("^Payne.*", x = Sal$Name, value = TRUE), 3)

## ------------------------------------------------------------------------
head(grep("Leonard.?S", x = Sal$Name, value = TRUE))
head(grep("Spence.*C.*", x = Sal$Name, value = TRUE))

## ------------------------------------------------------------------------
head(str_subset( Sal$Name, "^Payne.*"), 3)

## ------------------------------------------------------------------------
head(str_subset( Sal$Name, "Leonard.?S"))
head(str_subset( Sal$Name, "Spence.*C.*"))

## ------------------------------------------------------------------------
class(Sal$AnnualSalary)

## ------------------------------------------------------------------------
sort(c("1", "2", "10")) #  not sort correctly (order simply ranks the data)
order(c("1", "2", "10"))

## ------------------------------------------------------------------------
head(Sal$AnnualSalary, 4)
head(as.numeric(Sal$AnnualSalary), 4)

## ------------------------------------------------------------------------
Sal$AnnualSalary <- as.numeric(gsub(pattern = "$", replacement="", 
                              Sal$AnnualSalary, fixed=TRUE))
Sal <- Sal[order(Sal$AnnualSalary, decreasing=TRUE), ] 
Sal[1:5, c("Name", "AnnualSalary", "JobTitle")]

## ------------------------------------------------------------------------
dplyr_sal = Sal
dplyr_sal = dplyr_sal %>% mutate( 
  AnnualSalary = AnnualSalary %>%
    str_replace(
      fixed("$"), 
      "") %>%
    as.numeric) %>%
  arrange(desc(AnnualSalary))
check_Sal = Sal
rownames(check_Sal) = NULL
all.equal(check_Sal, dplyr_sal)

