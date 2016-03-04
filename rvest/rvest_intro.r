library(rvest)
library(magrittr)
library(stringr)

## Example case for getting resrvoir information
## want to read table off of a Wikipedia page
wiki.url <- "https://en.wikipedia.org/wiki/List_of_largest_reservoirs_of_Colorado"

co.reservoirs <- read_html(wiki.url)

res.df <- co.reservoirs %>%
  html_nodes("table") %>%
  .[[3]] %>%
  html_table()

## not too painfull!
## but types aren't quite right

res.df$`Elevation[n 2]`

## naive coercion doesn't work because of commas
as.numeric(res.df$`Elevation[n 2]`)

## suggested approach: use stringr
res.df$`Elevation[n 2]` %<>% str_replace_all(",", "") %>% as.numeric


## Example with selectorgadget
ud.url <- "http://www.urbandictionary.com/define.php?term=myspace"

ud.myspace <- read_html(ud.url)

meanings <- ud.myspace %>% html_nodes(css=".meaning") %>% html_text()

## Example submitting form

## get upper CO basin 
water.url <- "http://www.usbr.gov/rsvrWater/faces/rvrOSMP.xhtml"

water.session <- html_session(water.url)

form <- water.session %>% html_form() %>% .[[2]]

raw.csv <- water.session %>% submit_form(form, "form1:j_idt28")

read.csv(textConnection(rawToChar(raw.csv$response$content)), header=FALSE)

## what it if were not so easy?
## and we had select "Data Table" and then scrape the produced table



other.table <- water.session %>%
  submit_form(set_values(form, "form1:j_idt23"="table"), "form1:j_idt26") %>%
  html_table()
