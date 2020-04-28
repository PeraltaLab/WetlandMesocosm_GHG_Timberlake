################################################################################
#                                                                              #
# Diversity Functions Source Code: Functions for Microbial Community Analyses  #
#                                                                              #
################################################################################
#                                                                              #
# Written by: Mario Muscarella                                                 #
#                                                                              #
# Created: 2012/08/22                                                          #
#                                                                              #
# Last update: 2014/09/04                                                      #
#                                                                              #
################################################################################
#                                                                              #
# Notes: This code provides numerous functions to be used in the analysis of   #
#        16S rRNA sequence data post mothur anlaysis                           #
#        The ideas in the code are the products of a project between           #
#        Mario Muscarella and Tracy Teal                                       #
#                                                                              #
# Issues: Slow performance reading in OTU tables (common R issue)              #
#                                                                              #
# Recent Changes:                                                              #
#         1. Added Coverage Function                                           #
#         2. Minor Updates                                                     #
#         3. Added Various Evenness Metrics                                    #
#                                                                              #
# Future Changes (To-Do List):                                                 #
#         1. Design functions to work with shared files in memory              #
#         2. Add warnings                                                      #
#                                                                              #
################################################################################

# Needed packages
# require("vegan")||install.packages("vegan");require("vegan")

# Import OTU matrix
read.otu <- function(shared = " ",
                     cutoff = "0.03"){
  matrix <- read.table(shared, header=T, fill=TRUE, comment.char="", sep="\t")
  matrix.cutoff <- subset(matrix, matrix$label == cutoff)
  matrix.out <- as.matrix(matrix.cutoff[1:dim(matrix.cutoff)[1],
    4:(3+mean(matrix.cutoff$numOtus))])
  row.names(matrix.out) <- matrix.cutoff$Group
  return(matrix.out)
  }

# Count All Groups
count.groups <- function(otu.matrix = " "){
  counts <- rowSums(otu.matrix)
  return(counts)
  }

# rarefy function from Vegan (version 2.0-10)
rrarefy.1 <- function (x, sample) {
    if (!identical(all.equal(x, round(x)), TRUE))
        stop("function is meaningful only for integers (counts)")
    x <- as.matrix(x)
    if (ncol(x) == 1)
        x <- t(x)
    if (length(sample) > 1 && length(sample) != nrow(x))
        stop(gettextf("length of 'sample' and number of rows of 'x' do not match"))
    sample <- rep(sample, length = nrow(x))
    colnames(x) <- colnames(x, do.NULL = FALSE)
    nm <- colnames(x)
    for (i in 1:nrow(x)) {
        row <- sample(rep(nm, times = x[i, ]), sample[i])
        row <- table(row)
        ind <- names(row)
        x[i, ] <- 0
        x[i, ind] <- row
        }
    return(x)
    }

# Subsampling wrapper
sub.sample <- function(otu.matrix  = " ",
                       sample.size = "min(count.groups(test))"){
  counts <- count.groups(otu.matrix)
  if (sample.size == " "){
    sample.size = counts}
  statement <- counts > sample.size  # Add warning message
  otu.matrix <- subset(otu.matrix, rowSums(otu.matrix)>sample.size)
  x <- rrarefy.1(otu.matrix, sample.size)
  return(x)
  }

# Calculate Sample Depth or Coverage for Resampled Matrix
coverage <- function(input= " ", cutoff = " ", size = " ", shared = "TRUE"){
  if(shared == TRUE){
    otu.matrix <- read.otu(input, cutoff)
    } else {
      otu.matrix <- input
      }
  counts <- count.groups(otu.matrix)
  statement <- counts > size  # Add warning message
  otu.matrix <- subset(otu.matrix, rowSums(otu.matrix)>size)
  cover <- matrix(NA, dim(otu.matrix)[1], 1)
  rownames(cover) <- rownames(otu.matrix)
  colnames(cover) <- "Coverage"
  temp.matrix <- sub.sample(otu.matrix, size)
  for (i in 1:dim(temp.matrix)[1]){
    cover[i,] <- 1 - ((length(which(temp.matrix[1,] == 1))) /
        (length(which(temp.matrix[i,] > 0))))
    }
  return(cover)
  }

# Diversity/Evenness Measures

# Calculate Shannon Diversity Index
shan <- function(SAD = " "){
  SAD <- subset(SAD, SAD > 0)
  S <- length(SAD)
  N <- sum(SAD)
  X <- rep(NA, S)
  for (i in 1:S){
    X[i] <- (SAD[i]/N * log(SAD[i]/N))
    }
  H <- -sum(X)
  return(H)
  }

# Calculate Simpsons Diversity
simp <- function(SAD = " "){
  SAD <- subset(SAD, SAD > 0)
  S <- length(SAD)
  N <- sum(SAD)
  X <- rep(NA, S)
  for (i in 1:S){
    X[i] <- SAD[i]*(SAD[i] - 1) / (N * (N - 1))
    }
  D <- sum(X)
  return(D)
  }

# Calculate Inverse Simpson
inv_simp <- function(SAD = " "){
  D <- simp(SAD)
  inv <- 1/D
  return(inv)
  }


# Calculates Smith and Wilson's evenness index - E var
#   Smith & Wilson (1996) A consumer's guide to evenness indices. Oikos
e_var <- function(SAD = " "){
  SAD <- subset(SAD, SAD > 0)
  P <- log(SAD)
  S <- length(SAD)
  X <- rep(NA, S)
  for (i in 1:S){
    X[i] <- ((P[i] - mean(P))^2)/S
    }
  evar <- 1 - (2/(pi * atan(sum(X))))
  return(evar)
  }

# Calculates Simpsons Evenness
simp_even <- function(SAD = " "){
  SAD <- subset(SAD, SAD > 0)
  S <- length(SAD)
  N <- sum(SAD)
  X <- rep(NA, S)
  for (i in 1:S){
    X[i] <- (SAD[i]*(SAD[i] - 1)) / (N * (N - 1))
    }
  D <- sum(X)
  e_d <- (1/D)/S
  return(e_d)
  }

# Calculates Pielou's Evenness
#   Pielou 1969, 1975
pielou <- function(SAD = " "){
  SAD <- subset(SAD, SAD > 0)
  S <- length(SAD)
  N <- sum(SAD)
  X <- rep(NA, S)
  for (i in 1:S){
    X[i] <- (SAD[i]/N * log(SAD[i]/N))
    }
  H <- -sum(X)
  j <- H/log(S)
  return(j)
  }

# Heip's Evenness
heip <- function(SAD = " "){
  SAD <- subset(SAD, SAD > 0)
  S <- length(SAD)
  N <- sum(SAD)
  X <- rep(NA, S)
  for (i in 1:S){
    X[i] <- (SAD[i]/N * log(SAD[i]/N))
    }
  H <- -sum(X)
  heip_e <- (exp(H) - 1) / (S - 1)
  return(heip_e)
}


# resampling function for calculating species richness
richness.iter <- function(input  = " ",
                          cutoff = " ",
                          size   = " ",
                          iters  = " ",
                          shared = "TRUE"){
  if(shared == TRUE){
    otu.matrix <- read.otu(input, cutoff)
    }else{
      otu.matrix <- input
      }
  counts <- count.groups(otu.matrix)
  statement <- counts > size  # Add warning message
  if(iters > 1){
    otu.matrix <- subset(otu.matrix, rowSums(otu.matrix)>size)
    rich.matrix <- matrix(NA, dim(otu.matrix)[1], iters)
    rownames(rich.matrix) <- rownames(otu.matrix)
    for (i in 1:iters){
      temp.matrix <- sub.sample(otu.matrix, size)
      rich.matrix[,i] <- rowSums((temp.matrix>0)*1)
      }
  }else{
    rich.matrix <- rowSums((input>0)*1)
    }
  return(rich.matrix)
  }

# resampling function for calculating species evenness
evenness.iter <- function(input  = " ",
                          cutoff = " ",
                          size   = " ",
                          iters  = " ",
                          shared = "TRUE",
                          method = "e_var"){
  if(shared == TRUE){
    otu.matrix <- read.otu(input, cutoff)
    }else{
      otu.matrix <- input
      }
  counts <- count.groups(otu.matrix)
  statement <- counts > size  # Add warning message
  if(iters > 1){
    otu.matrix <- subset(otu.matrix, rowSums(otu.matrix)>size)
    even.matrix <- matrix(NA, dim(otu.matrix)[1], iters)
    rownames(even.matrix) <- rownames(otu.matrix)
    for (i in 1:iters){
      temp.matrix <- sub.sample(otu.matrix, size)
      even.matrix[,i] <- apply(temp.matrix, 1, method)
      }
   }else{
     even.matrix <- apply(input, 1, method)
     }
   return(even.matrix)
   }

# resampling function for calculating diversity
diversity.iter <- function(input  = " ",
                           cutoff = " ",
                           size   = " ",
                           iters  = " ",
                           shared = "TRUE",
                           method = "shan"){
  if(shared == TRUE){
    otu.matrix <- read.otu(input, cutoff)
    }else{
      otu.matrix <- input
      }
  counts <- count.groups(otu.matrix)
  statement <- counts > size  # Add warning message
  if(iters > 1){
    otu.matrix <- subset(otu.matrix, rowSums(otu.matrix)>size)
    div.matrix <- matrix(NA, dim(otu.matrix)[1], iters)
    rownames(div.matrix) <- rownames(otu.matrix)
    for (i in 1:iters){
      temp.matrix <- sub.sample(otu.matrix, size)
      div.matrix[,i] <- apply(temp.matrix, 1, method)
      }
  }else{
    div.matrix <- apply(input, 1, method)
    }
  return(div.matrix)
  }



  
