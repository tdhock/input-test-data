library(namedCapture)

line.vec <- readLines("trackDb.txt")

pattern <- paste0(
  "http://epigenomesportal.ca/public_data/donor/.*/",
  "(?<sample>.+?)",
  "[.]",
  "(?<cellType>.+?)",
  "[.]",
  "(?<experiment>.+?)",
  ".signal.bigWig")
match.mat <- str_match_named(line.vec, pattern)
dir.vec <- ifelse(
  match.mat[, "experiment"]=="Input",
  "Input", match.mat[, "cellType"])
new.url <- paste0(
  "    bigDataUrl https://raw.githubusercontent.com/tdhock/input-test-data/master/",
  dir.vec, "/",
  match.mat[, "sample"], ".bigwig")
line.vec[!is.na(dir.vec)] <- new.url[!is.na(dir.vec)]
writeLines(line.vec, "trackDbGitHub.txt")
