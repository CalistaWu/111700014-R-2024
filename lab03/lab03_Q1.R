#Q1
#install.packages("gmp")
library(gmp)

multiply_all <- function(x) {
  result <- prod(as.bigz(x)) %% 65537  
  return(result)
}


multiply_all(c(20, 22, 10, 13))  
multiply_all(c(2022, 1013))
multiply_all(1:30)
