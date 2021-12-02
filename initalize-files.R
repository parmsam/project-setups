#initialize files and folders based on Efficient R Programming Book ----
# https://csgillespie.github.io/efficientR/set-up.html#project-management
# project/
# - README.Rmd # Project description
# - set-up.R  # Required packages
# - R/ # For R code
# - input/ # Data files
# - graphics/ #Exported graphics
# - output/ # Results
dir.create("input")
dir.create("graphics")
dir.create("output")
dir.create("R")
file.create("README.md")
file.create("set-up.R")

# https://gist.github.com/jennybc/2bf1dbe6eb1f261dfe60
# declare twee function based on gist from jennybc ----
twee <- function(path = getwd(), level = Inf) {
  
  fad <-
    list.files(path = path, recursive = TRUE,no.. = TRUE, include.dirs = TRUE)
  
  fad_split_up <- strsplit(fad, "/")
  
  too_deep <- lapply(fad_split_up, length) > level
  fad_split_up[too_deep] <- NULL
  
  jfun <- function(x) {
    n <- length(x)
    if(n > 1)
      x[n - 1] <- "|__"
    if(n > 2)
      x[1:(n - 2)] <- "   "
    x <- if(n == 1) c("-- ", x) else c("   ", x)
    x
  }
  fad_subbed_out <- lapply(fad_split_up, jfun)
  
  cat(unlist(lapply(fad_subbed_out, paste, collapse = "")), sep = "\n")
}

# save log file with file tree ----
save_tree <- function(path = "file-tree.txt") {
  sink(file(path), type = "output")
  res_fs_tree <- twee()
  sink()  
}

save_tree()
