#BIOE215 Data Science 
# 10/23/2023
#Lesson 4 - Functions


#Q1 What are the 4 parts of this function?
  # Name: first_last_chr
  # Parameter: S
  # Key word: function!!!!
  # Body: everything in between {}

first_last_chr <- function (s) {
  first_chr<-substr(s,1,1)
  last_chr <- substr(s, nchar(s), nchar(s))
  result <- paste(first_chr, last_chr, sep = "")
  return (result)
}

text <- "Amazing"
first_last_chr(text) #result should be "Ag" - argument

#Output to be My
text2<-"Money"
first_last_chr(text2)

#Mean function
mean <- function (x) { 
  result <- sum (x) / length (x)
  return(result)}

mean(c(1,2)) # equals 1.5


# Mean function but with NA? How to solve for this?
  #one option
mean <- function (x, na.rm) {
  if (na.rm) {
  x<- na.omit(x)
  } 

  result <- sum (x) / length (x)
  return(result)
  }

mean(c(1,2,NA), TRUE)

  #another option
mean <- function (x, na.rm) {
  if (na.rm) {
    x<- x[!is.na(x)] #! = is it NOT
  } 
  
  result <- sum (x) / length (x)
  return(result)
}

mean(c(1,2,NA), TRUE) # making the vector

  #what if we put FALSE instead of TRUE?
mean <- function (x, na.rm) {
  if (na.rm) {
    x<- x[!is.na(x)] #! = is it NOT
  } 
  
  result <- sum (x) / length (x)
  return(result)
}

mean(c(1,2,NA), FALSE) # IT RETURNS NA...can not calculate

#what would happen if na.rm is not defined?
mean(c(1,2,NA)) #angry because na.rm is missing with no default

#so we give it a default value na.rm=FALSE
mean <- function (x, na.rm= FALSE) {
    if (na.rm) {
      x<- x[!is.na(x)] #! = is it NOT
    } 
    
    result <- sum (x) / length (x)
    return(result)
  }

mean(c(1,2,NA))

# mooore parameters
  repeat_chr <- function (s, n, separator = "-") {
    n<- n+1
    repeated <-rep (s,n)
    result <- paste (repeated, collapse= separator)
    return (result)
  }
  
  
  repeat_chr("A", 3) 
  repeat_chr("A", 3, ":")
  repeat_chr("A",3,separator = ":") 


  

