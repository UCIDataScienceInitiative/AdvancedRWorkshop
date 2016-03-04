---
title       : tidyr, dplyr, and magrittr
subtitle    : UCI Data Science Initiative
author      : Sepehr Akhavan
job         : Dept. of Statistics
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : mathjax            # {mathjax, quiz, bootstrap}
logo     : logo.png
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
github:
  user: UCIDataScienceInitiative
  repo: AdvancedRWorkshop
---

## Motivation:

There are usually 4 main steps in turning raw data into knowledge: 

1. Data manipulation (80% of any data analysis project (Dasu et al 2003)) 

2. Data visualization 

3. Statistical analysis/modeling 

4. Deployment of results

---

## How make data manipulation easy in R?

1. tidyr (pre-processing data)
2. dplyr (easy to transform data)
3. magrittr: makes working with tidyr and dplyr easier!


---

## tidyr:

1. a package to tidy your data (data that is easy to work with)

2. tidy data is a data that is easy to work with:

2.1) easy to transform (dplyr)

2.2) easy to visualize (ggplot2 and ggvis)

2.3) and easy to model



---

## Property of tidy data:

1. Each column is a variable

2. Each row is an observation


---

## How to tidy messy data?

1. First: Identify variables in your data

2. Then: use tidyr tools to move variables into columns


---

## tidyr's main functions:

1. gather()

2. separate()

3. spread()

4. unite()

Note: 

1. tidyr is only for tidying data. 

2. Therefore, includes to-the-point and easy-to-learn functions

3. Need more fancy methods? checkout reshape and reshape2


---

## Let's learn tidyr functions by examples!

* I borrowed some cool examples from Garret Grolemund


```r
devtools::install_github("garrettgman/DSR")
library(DSR)
```


```
## Warning: package 'ggplot2' was built under R version 3.2.4
```

---

## Tuberculosis data 

* We consider data on Tuberculosis documented by he World Health Organization in Afghanistan, Brazil, and China between 1999 and 2000. 

* You can access the data from DSR package


```r
table1
table2 # also try other tables till 6 
```

* all of the tables above inclde the same info

* Which one is easier to work with? 

* example: calculate the rate of TB cases per country per year? 

---

## spread():

* spread(...): turns a pair of key:value columns into a set of tidy columns.

* spread(DF, Key, Val)

* try:


```r
spread(table2, key, value)
```

* Can you explain what spread does?


---

## spread():


```r
str(spread)
```

```
## function (data, key, value, fill = NA, convert = FALSE, drop = TRUE)
```

* fill: what to place for combinations of variables that do not exist?

* convert: If a value column contains multiple types of data, should they be converted in the new data.frame?

* drop: If key column is factor, drop = FALSE, spread will keep factor levels that do not appear in the key column.



---

## gather():

* gather(): is the opposite of spread()

* gather() put column names into a key column and values into val column.

* gather(DF, name_of_Key_Col, name_of_Val_Col, list_of_columns_to_collapse)

* example:


```r
table4
gather(table4, "year", "cases", 2:3)
```


---

## separate():

* separate(): splits values of a column into two columns

* separate(DF, column, into = c("col1", "col2"))


* example1:


```r
table3
separate(table3, rate, into = c("cases", "population"))
```

* example2:


```r
separate(table3, year, into = c("century", "year"), sep = 2)
```


---

## unite():

* unite(): is the opposite of separate()

* combines multiple columns into one column

* by default, sep argument is "_"

* example:


```r
table6
unite(table6, "new", century, year, sep = "") # note: columns no double quotation
```


---

## dplyr:

* dplyr package helps with common data manipulation tasks.

* dplyr provides simple "verbs" (functions) for data manipulation tasks.

* Uses efficient data storage backends

* Also works nicely with data bases (dplyr on SQL databases is as easy as data.frame)



---

## dplyr:

In this tutorial we will learn about the most common dplyr functions:

1. filter(): provides basic filtering capabilities

2. arrange(): ordering data

3. select(): selecting variables

4. mutate(): create new variables

5. summarise(): summarise data by functions of choice

6. group_by()


---

## dplyr verbs:

* First argment: data.frame

* subsequent arguments: what to do with the DF

* They always return a data.frame

---

## NYC Flight Data:

* In this tutorial we work with "nycflights13" data frame (borrowed from dplyr vignettes).

* The dataset contains all 336,776 flights that departed from New York City in 2013.


```r
library(nycflights13)
dim(flights)
```

```
## [1] 336776     16
```

```r
class(flights)
```

```
## [1] "tbl_df"     "tbl"        "data.frame"
```



---

## NYC Flight Data:


```
## Classes 'tbl_df', 'tbl' and 'data.frame':	336776 obs. of  16 variables:
##  $ year     : int  2013 2013 2013 2013 2013 2013 2013 2013 2013 2013 ...
##  $ month    : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ day      : int  1 1 1 1 1 1 1 1 1 1 ...
##  $ dep_time : int  517 533 542 544 554 554 555 557 557 558 ...
##  $ dep_delay: num  2 4 2 -1 -6 -4 -5 -3 -3 -2 ...
##  $ arr_time : int  830 850 923 1004 812 740 913 709 838 753 ...
##  $ arr_delay: num  11 20 33 -18 -25 12 19 -14 -8 8 ...
##  $ carrier  : chr  "UA" "UA" "AA" "B6" ...
##  $ tailnum  : chr  "N14228" "N24211" "N619AA" "N804JB" ...
##  $ flight   : int  1545 1714 1141 725 461 1696 507 5708 79 301 ...
##  $ origin   : chr  "EWR" "LGA" "JFK" "JFK" ...
##  $ dest     : chr  "IAH" "IAH" "MIA" "BQN" ...
##  $ air_time : num  227 227 160 183 116 150 158 53 140 138 ...
##  $ distance : num  1400 1416 1089 1576 762 ...
##  $ hour     : num  5 5 5 5 5 5 5 5 5 5 ...
##  $ minute   : num  17 33 42 44 54 54 55 57 57 58 ...
```



---

## filter():

* filter(): selects a subset of the data

* filter(DF, condition(s))


```r
library(dplyr)
filter(flights, month == 1, day == 1) # jan 1st flights
```

```
## Source: local data frame [842 x 16]
## 
##     year month   day dep_time dep_delay arr_time arr_delay carrier tailnum
##    (int) (int) (int)    (int)     (dbl)    (int)     (dbl)   (chr)   (chr)
## 1   2013     1     1      517         2      830        11      UA  N14228
## 2   2013     1     1      533         4      850        20      UA  N24211
## 3   2013     1     1      542         2      923        33      AA  N619AA
## 4   2013     1     1      544        -1     1004       -18      B6  N804JB
## 5   2013     1     1      554        -6      812       -25      DL  N668DN
## 6   2013     1     1      554        -4      740        12      UA  N39463
## 7   2013     1     1      555        -5      913        19      B6  N516JB
## 8   2013     1     1      557        -3      709       -14      EV  N829AS
## 9   2013     1     1      557        -3      838        -8      B6  N593JB
## 10  2013     1     1      558        -2      753         8      AA  N3ALAA
## ..   ...   ...   ...      ...       ...      ...       ...     ...     ...
## Variables not shown: flight (int), origin (chr), dest (chr), air_time
##   (dbl), distance (dbl), hour (dbl), minute (dbl)
```


---

## arrange():

* arrange(): reorders rows

* arrange(DF, columnNamesToOrder)


```r
arrange(flights, year, month, day)
```


```r
arrange(flights, desc(arr_delay)) # desc ordering!
```

* Exercise: order flight data descendingly by the difference of dep_delay and arr_dely?


---

## select():

* to select column(s) from a data.frame

* example:


```r
select(flights, year, month, day)

select(flights, year:day)

select(flights, -(year:day))
```

* Please read the help and provide three ways to select delay variables



---

## select():


```r
select(flights, arr_delay, dep_delay)
select(flights, ends_with("delay"))
select(flights, contains("delay"))
```


---

## mutate():

* mutate: to add columns that are functions of existing columns


```r
mutate(flights, gain = arr_delay - dep_delay, speed = distance / air_time * 60)
```

```
## Source: local data frame [336,776 x 18]
## 
##     year month   day dep_time dep_delay arr_time arr_delay carrier tailnum
##    (int) (int) (int)    (int)     (dbl)    (int)     (dbl)   (chr)   (chr)
## 1   2013     1     1      517         2      830        11      UA  N14228
## 2   2013     1     1      533         4      850        20      UA  N24211
## 3   2013     1     1      542         2      923        33      AA  N619AA
## 4   2013     1     1      544        -1     1004       -18      B6  N804JB
## 5   2013     1     1      554        -6      812       -25      DL  N668DN
## 6   2013     1     1      554        -4      740        12      UA  N39463
## 7   2013     1     1      555        -5      913        19      B6  N516JB
## 8   2013     1     1      557        -3      709       -14      EV  N829AS
## 9   2013     1     1      557        -3      838        -8      B6  N593JB
## 10  2013     1     1      558        -2      753         8      AA  N3ALAA
## ..   ...   ...   ...      ...       ...      ...       ...     ...     ...
## Variables not shown: flight (int), origin (chr), dest (chr), air_time
##   (dbl), distance (dbl), hour (dbl), minute (dbl), gain (dbl), speed (dbl)
```


---

## mutate():

* mutate allows you to refer to columns that you’ve just created:


```r
mutate(flights, gain = arr_delay - dep_delay, gain_per_hour = gain / (air_time / 60))
```


---

## summarise():

* It collapses a data frame to a single row!


```r
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))
```

```
## Source: local data frame [1 x 1]
## 
##      delay
##      (dbl)
## 1 12.63907
```


---

## summarise():

* It makes more sense to apply summarise() to groups of obs in the data

* group_by(): breaks down a dataset into specified groups of rows


```r
by_dest <- group_by(flights, dest)
summarise(by_dest, delay = mean(dep_delay, na.rm = TRUE))
```

```
## Source: local data frame [105 x 2]
## 
##     dest     delay
##    (chr)     (dbl)
## 1    ABQ 13.740157
## 2    ACK  6.456604
## 3    ALB 23.620525
## 4    ANC 12.875000
## 5    ATL 12.509824
## 6    AUS 13.025641
## 7    AVL  8.190114
## 8    BDL 17.720874
## 9    BGR 19.475000
## 10   BHM 29.694853
## ..   ...       ...
```


---

## Useful Summary Functions:

* min(x), median(x), max(x), quantile(x, p)

* n(), n_distinct(), sum(x), mean(x)

* sum(x > 10), mean(x > 10)

* sd(x), var(x), IQR(x), mad(x)

Exercise: Group flights by destination and provide summary data for arr_delay.



---

## Useful Summary Functions:


```r
flights_by_dest <- group_by(flights, dest)
delays <- summarise(flights_by_dest, mean = mean(arr_delay),
                    n = n())
```



---

## Who can read this code?


```r
hourly_delay <- filter(
  summarise(
    group_by(
      filter(
        flights,
        !is.na(dep_delay)
      ),
      date, hour 
    ),
    delay = mean(dep_delay),
    n = n() 
  ),
  n > 10 
)
```

* difficult to read

* difficult to change!

---

## Who can read this code?

* solution: pipe operator from magrittr

* x %>% f(y) --> f(x, y)

* you can pronounce %>% as then

* Let's re-write the code above:


```r
hourly_delay <- flights %>%
  filter(!is.na(dep_delay)) %>%
  group_by(date, hour) %>%
  summarise(delay = mean(dep_delay), n = n()) %>%
  filter(n > 10)
```


---

## Let's try data pipelines :)

Exercise 1: Which destinations have the highest average delays?


---

## Let's try data pipelines :)


```r
flights %>%
  group_by(dest) %>%
  summarise(
    arr_delay = mean(arr_delay, na.rm = TRUE),
    n = n()) %>%
  arrange(desc(arr_delay))
```



---

## Exercise:

1) group data by individual plane (tailnum)

2) then count number of flights, average distance, average arrival delay per plane

3) then filter planes with at least 20 flights and at most a flight distance of 2000

4) use ggplot2 to explore the relation between the average arriaval delay and distance


---

## Exercise:


```r
delayData <- flights %>% group_by(tailnum) %>% 
  summarise(count = n(),
            dist = mean(distance, na.rm = T),
            delay = mean(arr_delay, na.rm = T)) %>% 
  filter(count > 20, dist < 2000)

ggplot(delayData, aes(dist, delay)) + 
  geom_point(aes(size = count), alpha = 1/2) + 
  geom_smooth() + scale_size_area()
```
