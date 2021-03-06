## ---- echo = FALSE-------------------------------------------------------
library(knitr)
opts_chunk$set(comment = "")
suppressPackageStartupMessages(library(dplyr))
library(dplyr)

## ------------------------------------------------------------------------
x = c(1, 4, 2, 8, 10)
x[2]

## ------------------------------------------------------------------------
x = c(1, 2, 4, 8, 10)
x[5]
x[c(2,5)]

## ----negativeIndex-------------------------------------------------------
x[-2] # all but the second

## ----negativeIndex2------------------------------------------------------
x[-c(1,2,3)] # drop first 3
# x[-1:3] # shorthand. R sees as -1 to 3
x[-(1:3)] # needs parentheses

## ------------------------------------------------------------------------
x
x > 2
x[ x > 2 ]

## ------------------------------------------------------------------------
x[ x > 2 & x < 5 ]
x[ x > 5 | x == 2 ]

## ------------------------------------------------------------------------
which(x > 5 | x == 2) # returns index
x[ which(x > 5 | x == 2) ]
x[ x > 5 | x == 2 ]

## ------------------------------------------------------------------------
data(mtcars)
df = mtcars
tbl = as.tbl(df)

## ------------------------------------------------------------------------
colnames(df)[1:3] = c("MPG", "CYL", "DISP")
head(df)
colnames(df)[1:3] = c("mpg", "cyl", "disp") #reset

## ------------------------------------------------------------------------
cn = colnames(df)
cn[ cn == "drat"] = "DRAT"
colnames(df) = cn
head(df)
colnames(df)[ colnames(df) == "DRAT"] = "drat" #reset

## ------------------------------------------------------------------------
library(tidyverse)

## ------------------------------------------------------------------------
filter

## ------------------------------------------------------------------------
head(stats::filter,2)

## ------------------------------------------------------------------------
df = dplyr::rename(df, MPG = mpg)
head(df)
df = rename(df, mpg = MPG) # reset - don't need :: b/c not masked

## ------------------------------------------------------------------------
df$carb

## ------------------------------------------------------------------------
df[, 11]
df[, "carb"]

## ------------------------------------------------------------------------
df[, 1]
tbl[, 1]
tbl[, "mpg"]
df[, 1, drop = FALSE]

## ------------------------------------------------------------------------
df[, c("mpg", "cyl")]

## ------------------------------------------------------------------------
select(df, mpg)

## ------------------------------------------------------------------------
select(df, mpg, cyl)
select(df, starts_with("c"))

## ------------------------------------------------------------------------
df[ c(1, 3), ]

## ------------------------------------------------------------------------
filter(df, mpg > 20 | mpg < 14)

## ------------------------------------------------------------------------
filter(df, mpg > 20 & cyl == 4)
filter(df, mpg > 20, cyl == 4)

## ------------------------------------------------------------------------
select(filter(df, mpg > 20 & cyl == 4), cyl, hp)

## ------------------------------------------------------------------------
df2 = filter(df, mpg > 20 & cyl == 4)
df2 = select(df2, cyl, hp)

## ------------------------------------------------------------------------
df %>% filter(mpg > 20 & cyl == 4) %>% select(cyl, hp)

## ------------------------------------------------------------------------
df$newcol = df$wt/2.2
head(df,3)

## ------------------------------------------------------------------------
df = mutate(df, newcol = wt/2.2)

## ---- echo = FALSE-------------------------------------------------------
print({df = mutate(df, newcol = wt/2.2)})

## ---- eval = FALSE-------------------------------------------------------
## df$newcol = NULL

## ------------------------------------------------------------------------
select(df, -newcol)

## ------------------------------------------------------------------------
select(df, -one_of("newcol", "drat"))

## ------------------------------------------------------------------------
select(df, newcol, everything())

## ------------------------------------------------------------------------
arrange(df, mpg)

## ------------------------------------------------------------------------
arrange(df, desc(mpg))

## ------------------------------------------------------------------------
arrange(df, mpg, desc(hp))

## ------------------------------------------------------------------------
transmute(df, newcol2 = wt/2.2, mpg, hp)

