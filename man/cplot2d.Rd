\name{cplot2d}
\alias{cplot2d}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
2D Scatter Plot with Classification Labels
}
\description{
\code{cplot2d} produces two dimensional scatter plot with classification labels of binary classes.
} 

\usage{cplot2d(x1, x2, ypred, yobs, colors = c("red", "blue"), symbols = c("circle", "o"), 
  size = 10, xlab = NULL, ylab = NULL, title = NULL)}

%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x1}{the horizontal coordinate of points in the plot.}
  \item{x2}{the vertical coordinate of points in the plot.} 
  \item{ypred}{a factor of the predicted binary response variable.}
  \item{yobs}{a factor of the observed binary response variable.} 
  \item{colors}{a vector of two colors specifying the levels of the observed binary response variable.} 
  \item{symbols}{a vector of two symbols specifying the levels of the predicted binary response variable.} 
  \item{size}{the size of symbols.}
  \item{xlab}{a label for the x axis, defaults to a description of x1.} 
  \item{ylab}{a label for the y axis, defaults to a description of x2.} 
  \item{title}{a main title of the plot.} 

}

\details{

Symbols indicate the observed classes of binary response. Colors show TRUE or FALSE classification of the observations. 

}


\value{
An object with class "plotly" and "htmlwidget".
}



\author{
Osman Dag
}

\seealso{
\code{\link[plotly]{plot_ly}} 
 
}


\examples{

library(GMDH2)

library(mlbench)
data(BreastCancer)

data <- BreastCancer

# to obtain complete observations
completeObs <- complete.cases(data)
data <- data[completeObs,]

x <- data.matrix(data[,2:10])
y <- data[,11]

seed <- 12345
set.seed(seed)
nobs <- length(y)

# to split train, validation and test sets

indices <- sample(1:nobs)

ntrain <- round(nobs*0.6,0)
nvalid <- round(nobs*0.2,0)
ntest <- nobs-(ntrain+nvalid)

train.indices <- sort(indices[1:ntrain])
valid.indices <- sort(indices[(ntrain+1):(ntrain+nvalid)])
test.indices <- sort(indices[(ntrain+nvalid+1):nobs])


x.train <- x[train.indices,]
y.train <- y[train.indices]

x.valid <- x[valid.indices,]
y.valid <- y[valid.indices]

x.test <- x[test.indices,]
y.test <- y[test.indices]

set.seed(seed)
# to construct model via dce-GMDH algorithm
model <- dceGMDH(x.train, y.train, x.valid, y.valid)

# to obtain predicted classes for test set
y.test_pred <- predict(model, x.test, type = "class")

# to obtain confusion matrix and some statistics for test set
confMat(y.test_pred, y.test, positive = "malignant")

# to produce 2D scatter plot with classification labels for test set
cplot2d(x.test[,1], x.test[,6], y.test_pred, y.test, symbols = c("x", "o"))
cplot2d(x.test[,1], x.test[,6], y.test_pred, y.test, colors = c("red", "black"))

}

\keyword{functions}
