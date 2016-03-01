##' UCI Data Science Initiative
##'
##' Debugging in R:
##' A Worst-Case Scenario Guide
##' Homer Strong, Statistics Department

##' > Debugging is twice as hard as
##' > writing the code in the first place.
##' > Therefore, if you write the
##' > code as cleverly as possible,
##' > you are, by definition, not smart
##' > enough to debug it.
##'  -- Brian Kernighan


##' Sometimes things go wrong,
##' and you don't know what happened...
##' :(

##' I can't tell you how to fix it,
##' or even what the problem is.
##' 
##' I'll give you some tips for
##' figuring out where the problem happened,
##' and what caused it.
##'
##' Really the best you can hope for
##' is to jump to where the problem is and
##' _interact_ with the meddlesome code
##' to understand what's gone so terribly wrong.


##' Step 0:   Write code. Let it break.
##'
##' This is the most important step! 
##' Step .5:  Look at your code. Think hard.
##'           Do you see a problem?
##'           Suppose that you don't immediately find the cause of the issue.


##' Chapter 1
##' Verbosity
##'
##' Even if you don't have an error yet,
##' it's often helpful to print out some
##' information about what's going on.
##'
##' Example:

aVeryImportantFunction <- function(x){
  print(x) # lets you see when x is not the right type
  sum(x, 1:10)
}

aVeryImportantFunction(2:3)
aVeryImportantFunction(c("a", "b"))

##' The cat() function is very similar to print().
##' Note that cat() does NOT insert spaces or newlines,
##' and also that not as many objects have special cat
##' methods.

##' There is a special family of messages
##' which are ranked by urgency:
##' + message()
##' + warning()
##' + stop()

##' Message prints its arguments to stderr()
##' but continues along.
aVeryImportantFunction <- function(x){
  if (!is.numeric(x))
    message(x, "=x is not numeric!") 
  sum(x, 1:10)
}

aVeryImportantFunction(2:3)
aVeryImportantFunction(c("a", "b"))

##' Warnings are more serious...
##' but not enough to discontinue
aVeryImportantFunction <- function(x){
  if (!is.numeric(x))
    warning("x is not numeric!") 
  sum(x, 1:10)
}

aVeryImportantFunction(2:3)
aVeryImportantFunction(c("a", "b"))


##' stop() does as its name promises;
##' nothing gets past it.
aVeryImportantFunction <- function(x){
  if (!is.numeric(x))
    stop("x is not numeric!") 
  sum(x, 1:10)
}

aVeryImportantFunction(2:3)
aVeryImportantFunction(c("a", "b"))


##' stopifnot() behaves just like stop
##' but is sometimes easier to use.
aVeryImportantFunction <- function(x){
  stopifnot(is.numeric(x))
  sum(x, 1:10)
}

aVeryImportantFunction(2:3)
aVeryImportantFunction(c("a", "b"))

##' Tangentially, you can upgrade all
##' warnings to errors in a session by
##' setting options(warn = 2)
##'
##' More on options later.

##' Actually, this isn't really useful
##' for debugging any more: if you put a stop
##' in your code, that means that you know
##' what problems to expect!
##'
##' Once you figure out a problem,
##' consider adding a stop() to catch it
##' so that you never need to deal with it again.
##'
##' For more about error handling, read
##' the documentation for try and tryCatch.


##' Chapter 2
##' Just Browsing
##'
##' This is greatest thing ever.
##' You can put a browser() statement ANYWHERE(!)
##' and it will stop for you to interact with
##' the locals when it runs.
##'
##' Example:

GLOBAL_VAL <- 42

anotherFunction <- function(len){
  df <- data.frame(names  = LETTERS[1:len],
                   values = 1:len)
  
  browser()
  fallacy <- c(1, letters[3:(len + 4)])
  err <- c(letters[1:15])
  
  cbind(df, fallacy)
}

anotherFunction(4)


##' Most awesome methods of debugging
##' are extensions and utilities that
##' leverage browser()
##' 
##' The first that I'll mention is
##' debug().
##'
##' debug() attaches a flag to the
##' function of your choice. R will
##' effectively give you brower()
##' on _each_ line of that function.

anotherFunction <- function(len){
  df <- data.frame(names  = LETTERS[1:len],
                   values = 1:len)
  
  browser()
  fallacy <- c(1, letters[3:(len + 4)])
  err <- c(letters[1:15])
  
  cbind(df, fallacy)
}

debug(anotherFunction) # flag this function
isdebugged(anotherFunction) # is it indeed flagged?

anotherFunction(4) # woah!

undebug(anotherFunction) # double negative??

##' A similar function is recover()
##'
##' recover is almost always used
##' in conjunction with options(error)
##' options() is a function which
##' manipulates global options.
##'
##' The error option is a function to call
##' whenever an error occurs; by default it
##' is NULL, which does nothing. 
##'
##' When you recover, you have the option
##' to browser() in any of the intermediate
##' environment between the global one and
##' the one in which the error occurred.

options(error = recover)


helperFunction <- function(num){
  num + 1
}

anotherFunction <- function(len){
  df <- data.frame(names  = LETTERS[1:len],
                   values = 1:len)
  
  helperFunction("a")
  fallacy <- c(1, letters[3:(len + 4)])
  err <- c(letters[1:15])
  
  cbind(df, fallacy)
}

##' The traceback() function can
##' be called after the fact, and provides
##' the sequence of calls that lead to
##' the error.
##' Kind of like recover() - browser()

traceback()

##' When you've had
##' enough debugging,
##' turn off recover

options(error = NULL)

##' Note that you're free
##' to write any function at
##' all to pass to error. This
##' is very useful for customizing
##' behaviour for errors.

##' Chapter 3
##' A Faint Trace
##'
##' I don't know too much about tracing,
##' but I'll give a simple example.

helperFunction <- function(num){
  num + 1
}

anotherFunction <- function(len){
  df <- data.frame(names  = LETTERS[1:len],
                   values = 1:len)
  
  helperFunction(len)
  fallacy <- c(letters[1:len])
  
  cbind(df, fallacy)
}

trace(helperFunction) # alert me if you're called
anotherFunction(5) # helperFunction(len) was called!

untrace(helperFunction) # good enough

##' But wait, there's more!
##' trace() is capable of executing
##' arbitrary code (e.g. browser)
##' conditionally, inside of your functions.
##'
##' Here's a slightly more complicated
##' use of trace, on the same functions
##' as above.

trace(helperFunction, # specifies function to watch
      browser, # function to call on entry
      exit = quote( # function to call on exit.
        print("finished!"))) 
anotherFunction(5) # helperFunction(len) was called!

untrace(helperFunction) # good enough
