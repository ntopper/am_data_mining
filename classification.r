install.packages("caret", dependencies = c("Depends", "Suggests"))
install.packages("RWeka")
install.packages("e1071")
install.packages("oblique.tree")
library(caret)
library(RWeka)
library(e1071)
library(oblique.tree)
#function for creating test and train sets
divideDataset <- function(data) {
  set.seed(7873)
  split <- floor(0.8 * nrow(data))
  index <- sample(seq_len(nrow(data)), size = split)
  train <- data[index, ]
  test <- data[-index, ]
  list(trainSet=train, testSet=test)
}

movie <- read.csv("./moviedb_data/moviedb1.csv")
movieSplit <- divideDataset(movie)
#Train for RIPPER
movieRIPPERfit <- JRip(genre~., data=movieSplit$trainSet)
#Test for RIPPER
prediction <- predict(movieRIPPERfit, movieSplit$testSet, type="class")
cm <- confusionMatrix(prediction, movieSplit$testSet$genre)
accuracy <- cm$overall['Accuracy']
means <- colMeans(cm$byClass)
precision <- means[3]
recall <- means[1]
fmeasure <- 2*precision*recall/(precision+recall)
movieRIPPERrow <- list("movie RIPPER", accuracy, precision, recall, fmeasure)
#Train for C45
movieC45fit <- J48(genre~., data=movieSplit$trainSet)
#Test for C45
prediction <- predict(movieC45fit, movieSplit$testSet, type="class")
cm <- confusionMatrix(prediction, movieSplit$testSet$genre)
accuracy <- cm$overall['Accuracy']
means <- colMeans(cm$byClass)
precision <- means[3]
recall <- means[1]
fmeasure <- 2*precision*recall/(precision+recall)
movieC45row <- list("movie C45", accuracy, precision, recall, fmeasure)
#Train for Oblique
movieOblfit <- oblique.tree(genre~., data=movieSplit$trainSet)
#Test for Oblique
prediction <- predict(movieOblfit, movieSplit$testSet, type="class")
cm <- confusionMatrix(prediction, movieSplit$testSet$genre)
accuracy <- cm$overall['Accuracy']
means <- colMeans(cm$byClass)
precision <- means[3]
recall <- means[1]
fmeasure <- 2*precision*recall/(precision+recall)
movieOblrow <- list("movie Oblique", accuracy, precision, recall, fmeasure)
#Train for Naive Bayes
movieNBfit <- naiveBayes(genre~., data=movieSplit$trainSet)
#Test for Naive Bayes
prediction <- predict(movieNBfit, movieSplit$testSet, type="class")
cm <- confusionMatrix(prediction, movieSplit$testSet$genre)
accuracy <- cm$overall['Accuracy']
means <- colMeans(cm$byClass)
precision <- means[3]
recall <- means[1]
fmeasure <- 2*precision*recall/(precision+recall)
movieNBrow <- list("movie Naive Bayes", accuracy, precision, recall, fmeasure)
#Train for k-Nearest Neighbor
movieKNNfit<- knn3(genre~., data=movieSplit$trainSet)
#Test for KNN
prediction <- predict(movieKNNfit, movieSplit$testSet, type="class")
cm <- confusionMatrix(prediction, movieSplit$testSet$genre)
accuracy <- cm$overall['Accuracy']
means <- colMeans(cm$byClass)
precision <- means[3]
recall <- means[1]
fmeasure <- 2*precision*recall/(precision+recall)
movieKNNrow <- list("movie k-Nearest Neighbor", accuracy, precision, recall, fmeasure)

print(movieRIPPERrow)
print(movieC45row)
print(movieOblrow)
print(movieNBrow)
print(movieKNNrow)