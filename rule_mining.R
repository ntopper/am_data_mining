library(arules)

cat("importing data\n")
ususalSuspects <- read.csv("moviedb_data/UsualSuspects.csv")

cat("mining all rules\n")
rules <- apriori(usualSuspects)
print(inspect(rules))

cat("\n")
cat("\n")
cat("mining all rules where Support = 0.01 and Confidence = 0.90\n")
rules <- apriori(usualSuspects, parameter = list(support = 0.01, confidence = 0.9))

cat("\n")
cat("\n")
cat("sorting by lift\n")
rules.sorted = sort(rules, by="lift")

cat("\n")
cat("\n")
cat("pruning redundant rules\n")
subset.matrix <- is.subset(rules.sorted, rules.sorted)
subset.matrix[lower.tri(subset.matrix, diag=T)] <- NA
redundant <- colSums(subset.matrix, na.rm=T) >= 1
rules.pruned <- rules.sorted[!redundant]

cat("\n")
cat("\n")
print(inspect(rules.pruned))


cat("\n")
cat("\n")
cat("Creating subset where RHS is actor\n")
rules.subset <- subset(rules, (rhs %in% paste0("actor=", unique(usualSuspects$actor))))
print(inspect(rules.subset))