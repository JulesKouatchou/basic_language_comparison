#!/usr/bin/env Rscript

library(rbenchmark)

arguments = commandArgs(TRUE)

# Get the filename 'name' from the command line.
if (length(arguments) == 0) {
  stop("At least one argument must be supplied (name of file).n", call.=FALSE)
} else if (length(arguments) == 1) {
  #name <- as.string(arguments[1])
  name <- arguments[1]
}

cat('-----------------------------------------\n')
cat('      Count the number of unique words in: ', name,         '\n')
cat('-----------------------------------------\n')

CountWords <- function(filename, return.an.int=FALSE) {
  # Count the number of unique words in the given file.
  #
  # Args:
  #   filename: The name of the file to read, including its file extension.
  file.id <- file(filename, open="r")
  lines <- readLines(file.id)
  close(file.id)
  unique.words <- c()
  for (i in 1:length(lines)) {
    unique.words <- union(unique.words, tolower(strsplit(gsub("[^[:alpha:] ]", "", lines[i]), " +")[[1]]))
  }
  #unique.words <- unique(tolower(unique.words))
}

benchmark("Count Words" = {
            n <- CountWords(name)
          },
          replications = 1,
          columns = c("test", "replications", "elapsed", "relative", "user.self", "sys.self"))
