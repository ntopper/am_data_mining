#function for creating test and train sets
divideDataset <- function(data) {
  set.seed(7873)
  split <- floor(0.8 * nrow(data))
  index <- sample(seq_len(nrow(data)), size = split)
  train <- data[index, ]
  test <- data[-index, ]
  list(trainSet=train, testSet=test)
}

dummy <- read.csv("dummy.csv")
dummy <- subset(life_expectancy, select = -c(caption, lat, long, loginkey))
dummySplit <- divideDataset(dummy)
#Train for RIPPER
dummyRIPPERfit <- JRip(login_key_recurrence~., data=dummySplit$trainSet)
#Test for RIPPER
prediction <- predict(dummyRIPPERfit, dummySplit$testSet, type="class")
cm <- confusionMatrix(prediction, dummySplit$testSet$login_key_recurrence)
accuracy <- cm$overall['Accuracy']
means <- colMeans(cm$byClass)
precision <- means[3]
recall <- means[1]
fmeasure <- 2*precision*recall/(precision+recall)
dummyRIPPERrow <- list("LE RIPPER", accuracy, precision, recall, fmeasure)
#Train for C45
dummyC45fit <- J48(login_key_recurrence~., data=dummySplit$trainSet)
#Test for C45
prediction <- predict(dummyC45fit, dummySplit$testSet, type="class")
cm <- confusionMatrix(prediction, dummySplit$testSet$login_key_recurrence)
accuracy <- cm$overall['Accuracy']
means <- colMeans(cm$byClass)
precision <- means[3]
recall <- means[1]
fmeasure <- 2*precision*recall/(precision+recall)
dummyC45row <- list("LE C45", accuracy, precision, recall, fmeasure)
#Train for Oblique
dummyOblfit <- oblique.tree(login_key_recurrence~., data=dummySplit$trainSet)
#Test for Oblique
prediction <- predict(dummyOblfit, dummySplit$testSet, type="class")
cm <- confusionMatrix(prediction, dummySplit$testSet$login_key_recurrence)
accuracy <- cm$overall['Accuracy']
means <- colMeans(cm$byClass)
precision <- means[3]
recall <- means[1]
fmeasure <- 2*precision*recall/(precision+recall)
dummyOblrow <- list("LE Oblique", accuracy, precision, recall, fmeasure)
#Train for Naive Bayes
dummyNBfit <- naiveBayes(login_key_recurrence~., data=dummySplit$trainSet)
#Test for Naive Bayes
prediction <- predict(dummyNBfit, dummySplit$testSet, type="class")
cm <- confusionMatrix(prediction, dummySplit$testSet$login_key_recurrence)
accuracy <- cm$overall['Accuracy']
means <- colMeans(cm$byClass)
precision <- means[3]
recall <- means[1]
fmeasure <- 2*precision*recall/(precision+recall)
dummyNBrow <- list("LE Naive Bayes", accuracy, precision, recall, fmeasure)
#Train for k-Nearest Neighbor
dummyKNNfit<- knn3(login_key_recurrence~., data=dummySplit$trainSet)
#Test for KNN
prediction <- predict(dummyKNNfit, dummySplit$testSet, type="class")
cm <- confusionMatrix(prediction, dummySplit$testSet$login_key_recurrence)
accuracy <- cm$overall['Accuracy']
means <- colMeans(cm$byClass)
precision <- means[3]
recall <- means[1]
fmeasure <- 2*precision*recall/(precision+recall)
dummyKNNrow <- list("LE k-Nearest Neighbor", accuracy, precision, recall, fmeasure)

print(dummyRIPPERrow)
print(dummyC45row)
print(dummyOblrow)
print(dummyNBrow)
print(dummyKNNrow)