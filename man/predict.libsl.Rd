\name{predict.libsl}
\alias{predict.libsl}

\title{
Prediction from an Flexible Parametric Model
}
\description{
Predict the survival based on a model or algorithm from an object of the class \code{libsl}.
}

\usage{
\method{predict}{libsl}(object, newdata, newtimes, ...)
}

\arguments{
  \item{object}{An object of the class \code{libsl}.}
  \item{newdata}{An optional data frame containing covariate values at which to produce predicted values. The default value is \code{NULL}, the predicted values are computed for the subjects of the training sample.}
  \item{newtimes}{The times at which to produce predicted values. The default value is \code{NULL}, the predicted values are computed for the observed times in the training data frame.}
  \item{...}{For future methods.}
}

\value{
\item{times}{A vector of numeric values with the times of the \code{predictions}.}
\item{predictions}{A matrix with the predictions of survivals of each subject (lines) for each observed time (columns).}
}



\examples{
data("dataDIVAT2")

# The estimation of the model from the first 200 lines

formula<-Surv(times,failures) ~ age + hla + retransplant + ecd
model <- LIB_PHgompertz(formula, data=dataDIVAT2[1:200,])

# Predicted survival for 2 new subjects
pred <- predict(model,
  newdata=data.frame(age=c(52,52), hla=c(0,1), retransplant=c(1,1), ecd=c(0,1)))

plot(y=pred$predictions[1,], x=pred$times, xlab="Time (years)", ylab="Predicted survival",
     col=1, type="l", lty=1, lwd=2, ylim=c(0,1))

lines(y=pred$predictions[2,], x=pred$times, col=2, type="l", lty=1, lwd=2)

legend("bottomright", col=c(1,2), lty=1, lwd=2, c("Subject #1", "Subject #2"))
}

\keyword{Predicting}
