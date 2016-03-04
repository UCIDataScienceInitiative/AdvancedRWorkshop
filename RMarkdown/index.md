---
title       : R-Markdown
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

## What is RMarkdown?


![alt text](images/WhatIsRMarkdown.png)

---

## What is Markdown?

* A very simple way to write HTML!

* As simple as writing english text!

* You simply type in text, your text is rendered to a more complex formats

* Very helpful to focus on content and not that much on formatting


---

## How does Markdown look like?

* Demo - R Markdown

* RStudio Help - Markdown Quick Reference



---

## Qucik Markdown Guide - Header:

* Pictures borrowed from Garrett Grolemund (RStudio)

![alt text](images/Header.png)


---

## Texts:

* Pictures borrowed from Garrett Grolemund (RStudio)

![alt text](images/Text.png)



---

## Lists:

* Pictures borrowed from Garrett Grolemund (RStudio)

![alt text](images/Lists.png)



---

## Hyperlinks:

* Pictures borrowed from Garrett Grolemund (RStudio)

![alt text](images/Hyperlinks.png)



---

## Equations:

* Pictures borrowed from Garrett Grolemund (RStudio)

![alt text](images/Equations.png)


---

## Where to Learn more on Markdown:

* RStudio/Help/Markdown Quick Reference

* R Markdown Reference Guide: https://www.rstudio.com/resources/cheatsheets/

* Comprehensive RMarkdown Reference (RMarkdown Developing Center): http://rmarkdown.rstudio.com/

---

## How to Embed R Code inside of a Markdown document:

* This is where *Markdown* changes to **R**Markdown

* R codes can be embeded in two ways:
  1. As an R chunk
  2. As an inline code

---


## Some Useful Chunk Options:

1. echo
2. eval
3. message, warning, error
4. fig.height, fig.width, fig.keep
5. result
6. engine

---


## Key Points to remember:

**When we run our R Markdown document, it's considered as a fresh R session!**

1. Variables not explicitely defined in the RMarkdown document, are not known!
2. Required Packages need to be explicitely loaded in the RMarkdown docuemnt!

---


## Demos:
1. Different Markdown outputs (HTML, PDF, MS Word)
2. Different Presentation Outputs (HTML, PDF)
3. Interactive visualization inside of RMarkdown (HTML Only)
4. Shiny interactive applications inside RMarkdown
5. Template (rticles package)
6. YAML an output template
7. rmarkdown::render


