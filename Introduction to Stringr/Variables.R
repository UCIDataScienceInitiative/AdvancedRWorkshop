## Introduction to Stringr

strings <- c(" 219 733 8965", "329-293-8753 ", "banana",
             "595 794 7569", "387 287 6718", "apple", "233.398.9187  ",
             "482 952 3315", "239 923 8115 and 842 566 4692",
             "Work: 579-499-7527", "$1000", "Home: 543.355.3679")

fruit <- c("apple", "banana", "pear", "pinapple")

movie_titles <- c("gold diggers of broadway", "gone baby gone",
                  "gone in 60 seconds","gone with the wind",
                  "good girl, the", "good burger", "goodbye girl, the",
                  "good bye lenin!", "goodfellas", "good luck chuck",
                  "good morning, vietnam", "good night, and good luck.",
                  "good son, the", "good will hunting")


## Regular Expressions ##

# "a"  = IS/HAS the letter "a"
# "^a" = STARTS with the letter "a"
# "a$" = ENDS with the letter "a"
# "[ ]" = contains ANY letter (or number) within the brackets
# "[ - ]" = contains any letter (or number) within this RANGE
# "[^ae]" = everything EXCEPT these letters (or numbers)
# "{3}" = run the last regex 3 times.
